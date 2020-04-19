import 'package:task_manager_mobile/models/task_model.dart';

abstract class TaskState {}

class TasksLoadingStart extends TaskState {}

class TasksLoadingSuccess extends TaskState {
  final List<TaskModel> tasks;
  final int skip;
  final int limit;
  final bool loadMore;

  TasksLoadingSuccess({
    this.tasks,
    this.skip,
    this.limit,
    this.loadMore,
  });
}

class TasksLoadingError extends TaskState {}
