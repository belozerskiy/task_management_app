enum TasksVisibilityFilter { ALL, OPEN, IN_PROGRESS, DONE }

class TaskVisibilityFilterHelper {
  TaskVisibilityFilterHelper(this._filter);

  TaskVisibilityFilterHelper.fromString(String status) {
    this._filter = _stringToEnum[status];
  }

  TasksVisibilityFilter _filter;

  TasksVisibilityFilter get enumStatus {
    return _filter;
  }

  String get stringStatus {
    return _enumToString[_filter];
  }

  String toString() {
    return _enumToString[_filter];
  }

  static const Map<TasksVisibilityFilter, String> _enumToString = {
    TasksVisibilityFilter.ALL: null,
    TasksVisibilityFilter.OPEN: 'OPEN',
    TasksVisibilityFilter.IN_PROGRESS: 'IN_PROGRESS',
    TasksVisibilityFilter.DONE: 'DONE',
  };

  static const Map<String, TasksVisibilityFilter> _stringToEnum = {
    null: TasksVisibilityFilter.ALL,
    'OPEN': TasksVisibilityFilter.OPEN,
    'IN_PROGRESS': TasksVisibilityFilter.IN_PROGRESS,
    'DONE': TasksVisibilityFilter.DONE,
  };
}
