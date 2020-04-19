import 'package:task_manager_mobile/models/task_model.dart';
import 'package:task_manager_mobile/models/task_status.dart';

abstract class TaskEvent {}

class TasksLoaded extends TaskEvent {
  final String search;
  final String status;
  final bool reset;

  TasksLoaded({
    this.search,
    this.status,
    this.reset = false,
  });
}

class TaskAdded extends TaskEvent {
  final String title;
  final String description;

  TaskAdded({
    this.title,
    this.description,
  });
}

class TaskSelected extends TaskEvent {
  final TaskModel task;
  TaskSelected(this.task);
}

class TaskDeleted extends TaskEvent {
  final TaskModel task;
  TaskDeleted(this.task);
}

class TaskStatusChanged extends TaskEvent {
  final TaskStatus status;
  final TaskModel task;
  TaskStatusChanged({this.task, this.status});
}
