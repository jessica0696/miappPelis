import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {

  @HiveField(0)
  String titulo;

  @HiveField(1)
 String sinopsis;

  @HiveField(2)
bool isCompleted = false;
}