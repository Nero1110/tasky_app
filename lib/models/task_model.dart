import 'package:hive_ce_flutter/hive_flutter.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool isDone;
  @HiveField(4)
  DateTime createdAt;
  @HiveField(5)
  bool isHighpriority;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
    required this.isHighpriority
  });
}
