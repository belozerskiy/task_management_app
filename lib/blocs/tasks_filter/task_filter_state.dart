import 'package:task_manager_mobile/models/tasks_visibility_filter.dart';

abstract class TasksFilterState {}

class TasksFilterSuccess extends TasksFilterState {
  TasksVisibilityFilter filter;
  TasksFilterSuccess(this.filter);

  TasksFilterSuccess.initialize() {
    this.filter = TasksVisibilityFilter.ALL;
  }
}
