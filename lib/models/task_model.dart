import 'package:task_manager_mobile/interfaces/cloneable.dart';
import 'package:task_manager_mobile/models/task_status.dart';

class TaskModel implements Cloneable {
  int id;
  String title;
  String description;
  TaskStatus status;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.status,
  });

  factory TaskModel.fromHashMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: TaskStatusHelper.fromString(map['status']).enumStatus,
    );
  }

  TaskModel clone() {
    return TaskModel()
      ..id = id
      ..title = title
      ..description = description
      ..status = status;
  }

  @override
  String toString() {
    return 'id: $id, title: $title, description: $description, status: $status';
  }
}
