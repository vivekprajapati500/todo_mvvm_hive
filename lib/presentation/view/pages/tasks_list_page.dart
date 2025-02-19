import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:task_mgmt_riverpod/shared/responsive.dart';
import '../../../domain/model/task.dart';
import '../../../domain/model/tasks_list.dart';
import '../../../shared/constants.dart';
import '../../../shared/sorting_provider.dart';
import '../../../shared/theme_provider.dart';
import '../../viewmodel/taskslist/task_list_viewmodel.dart';
import '../widgets/task_type_header_widget.dart';
import 'task_form_page.dart';

class TasksListPage extends StatelessWidget {
  final _filteredTasksListProvider = filteredTasksListProvider;
  final _tasksListProvider = tasksListViewModelStateNotifierProvider;

  TasksListPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Management'),
        actions: [
          // Sorting Icon
          Consumer(builder: (context, ref, child) {
            final isAscending = ref.watch(sortOrderProvider);
            return IconButton(
              onPressed: () async {
                var box = Hive.box('settings');
                bool newOrder = !isAscending; // Toggle sorting order

                // Update sorting state
                ref.read(sortOrderProvider.notifier).state = newOrder;

                // Save sorting preference
                await box.put('isAscending', newOrder);
              },
              icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
            );
          }),
          Consumer(builder: (context, ref, child) {
            final theme = ref.watch(themeModeProvider);
            return IconButton(
              onPressed: () async {
                var box = Hive.box('settings');
                bool isDarkMode = theme == ThemeData.light();

                debugPrint("isDarkMode set: $isDarkMode");
                // Toggle theme
                ref.read(themeModeProvider.notifier).state =
                isDarkMode ? ThemeData.dark() : ThemeData.light();

                // Save new preference
                await box.put('isDarkMode', isDarkMode);
              },
              icon: Icon(theme == ThemeData.dark()
                  ? Icons.light_mode
                  : Icons.dark_mode),
            );
          })

        ],
      ),
      body: Column(
        children: [
          TaskTypeWidget(),
          const Divider(height: 2, color: Colors.grey),
          Consumer(
            builder: (context, ref, _) {
              return ref.watch(_filteredTasksListProvider).maybeWhen(
                    success: (content) =>
                        _buildTasksListContainerWidget(context, ref, content),
                    error: (_) => _buildErrorWidget(),
                    orElse: () => const Expanded(
                        child: Center(child: CircularProgressIndicator())),
                  );
            },
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildTasksListContainerWidget(
      BuildContext context, WidgetRef ref, final TaskList tasksList) {
    return Expanded(child: _buildTasksListWidget(context, ref, tasksList));
  }

  Widget _buildTasksListWidget(final BuildContext context, final WidgetRef ref,
      final TaskList tasksList) {
    if (tasksList.length == 0) {
      return const Center(child: Text('No Task'));
    } else {

      final isAscending = ref.watch(sortOrderProvider);

      final sortedTasks = tasksList.values.toList()
        ..sort((a, b) => isAscending
            ? a.dueDate.compareTo(b.dueDate)  // Ascending
            : b.dueDate.compareTo(a.dueDate)); // Descending

      return SingleChildScrollView(
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: Responsive.isMobile(context)
                ? const EdgeInsets.all(18.0)
                : const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 15,
              runSpacing: 15,
              children: sortedTasks
                  .map((task) => _buildTaskItemCardWidget(context, ref, task))
                  .toList(),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildTaskItemCardWidget(
      final BuildContext context, final WidgetRef ref, final Task task) {
    return InkWell(
      child: Consumer(builder: (context, ref, child) {
        final theme = ref.watch(themeModeProvider);
        return Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
              color: theme == ThemeData.light()
                  ? task.isCompleted ? lightcardColors[0] : lightcardColors[1]
                  : task.isCompleted ? darkcardColors[0] : darkcardColors[1],
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormat('yyyy/MM/dd').format(task.dueDate),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description.isEmpty
                          ? 'No Description'
                          : task.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              task.isCompleted
                  ? _buildCheckedIcon(ref, task)
                  : _buildUncheckedIcon(ref, task),
            ],
          ),
        );
      }),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TaskFormPage(task),
          )),
    );
  }

  Widget _buildCheckedIcon(final WidgetRef ref, final Task task) {
    return InkResponse(
      onTap: () => ref.watch(_tasksListProvider.notifier).undoTask(task),
      splashColor: Colors.transparent,
      child: const Icon(Icons.done, size: 24, color: Colors.green),
    );
  }

  Widget _buildUncheckedIcon(final WidgetRef ref, final Task task) {
    return InkResponse(
      onTap: () => ref.watch(_tasksListProvider.notifier).completeTask(task),
      splashColor: Colors.transparent,
      child: const Icon(
        Icons.radio_button_off_rounded,
        size: 24,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildFloatingActionButton(final BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TaskFormPage(null),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(child: Text('An error has occurred!'));
  }
}


