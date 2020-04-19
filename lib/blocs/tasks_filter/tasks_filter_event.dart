// class TaskFilterEve

import 'package:task_manager_mobile/models/tasks_visibility_filter.dart';

abstract class TasksFilterEvent {}

class TaskFilterUpdated implements TasksFilterEvent {
  final TasksVisibilityFilter filter;
  TaskFilterUpdated(this.filter);
}
