import 'package:flutter/material.dart';
import 'package:task_manager_mobile/models/tasks_visibility_filter.dart';

class TaskStatusFilter extends StatelessWidget {
  TaskStatusFilter({
    Key key,
    this.filter,
    this.handler,
  }) : super(key: key);

  final Function handler;
  final TasksVisibilityFilter filter;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TasksVisibilityFilter>(
      enabled: true,
      initialValue: filter,
      icon: Icon(Icons.filter_list),
      onSelected: handler,
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<TasksVisibilityFilter>>[
        // CheckedPopupMenuItem()
        PopupMenuItem(
          value: TasksVisibilityFilter.ALL,
          child: Text('Show all tasks'),
        ),
        PopupMenuItem(
          value: TasksVisibilityFilter.OPEN,
          child: Text('Show opened tasks'),
        ),
        PopupMenuItem(
          value: TasksVisibilityFilter.IN_PROGRESS,
          child: Text('Show in progressed tasks'),
        ),
        PopupMenuItem(
          value: TasksVisibilityFilter.DONE,
          child: Text('Show doned tasks'),
        ),
      ],
    );
  }
}
