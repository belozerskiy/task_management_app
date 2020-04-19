enum TaskStatus {
  OPEN,
  IN_PROGRESS,
  DONE,
}

class TaskStatusHelper {
  TaskStatusHelper(this._status);

  TaskStatusHelper.fromString(String status) {
    this._status = _stringToEnum[status];
  }

  TaskStatus _status;

  TaskStatus get enumStatus {
    return _status;
  }

  String get stringStatus {
    return _enumToString[_status];
  }

  String toString() {
    return _enumToString[_status];
  }

  static const Map<TaskStatus, String> _enumToString = {
    TaskStatus.OPEN: 'OPEN',
    TaskStatus.IN_PROGRESS: 'IN_PROGRESS',
    TaskStatus.DONE: 'DONE',
  };

  static const Map<String, TaskStatus> _stringToEnum = {
    'OPEN': TaskStatus.OPEN,
    'IN_PROGRESS': TaskStatus.IN_PROGRESS,
    'DONE': TaskStatus.DONE,
  };
}
