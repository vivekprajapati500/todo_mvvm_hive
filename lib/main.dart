
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_mgmt_riverpod/shared/theme_provider.dart';
import 'presentation/view/pages/tasks_list_page.dart';

void main() async{

  await Hive.initFlutter();
  var box = await Hive.openBox('settings');
  bool isDarkMode = box.get('isDarkMode', defaultValue: true);
  runApp(
    ProviderScope(
      overrides: [
        themeModeProvider.overrideWith((ref) => isDarkMode ? ThemeData.dark() : ThemeData.light()),
      ],
      child: const MainApp(),
    ),
  );

}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode == ThemeData.dark() ? ThemeMode.dark : ThemeMode.light,
      home: TasksListPage(),
    );
  }
}
