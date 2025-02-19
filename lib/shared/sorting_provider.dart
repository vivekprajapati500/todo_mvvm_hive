
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sortOrderProvider = StateProvider<bool>((ref) {
  var box = Hive.box('settings');
  return box.get('isAscending', defaultValue: true); // Default to ascending
});