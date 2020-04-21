import 'package:task_manager_mobile/models/task_model.dart';

abstract class TaskState {}

class TasksLoadingStart extends TaskState {}

class TasksLoadingSuccess extends TaskState {
  List<TaskModel> tasks;
  int skip;
  int limit;
  bool loadMore;

  TasksLoadingSuccess({
    this.tasks,
    this.skip,
    this.limit,
    this.loadMore,
  });

  TasksLoadingSuccess copyWith({tasks, skip, limit, loadMore}) {
    return TasksLoadingSuccess()
      ..tasks = tasks ?? this.tasks
      ..skip = skip ?? this.skip
      ..limit = limit ?? this.limit
      ..loadMore = loadMore ?? this.loadMore;
  }
}

class TasksLoadingError extends TaskState {}
