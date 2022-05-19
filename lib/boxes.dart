import 'package:hive/hive.dart';

import 'model/task.dart';

class Boxes {
  static Box<Task> getTasks() =>
      Hive.box<Task>('task');
}