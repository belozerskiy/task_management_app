import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_mobile/blocs/tasks_filter/task_filter_state.dart';
import 'package:task_manager_mobile/blocs/tasks_filter/tasks_filter_bloc.dart';
import 'package:task_manager_mobile/blocs/tasks_filter/tasks_filter_event.dart';
import 'package:task_manager_mobile/models/tasks_visibility_filter.dart';
import 'package:task_manager_mobile/ui/tasks_status_filter.dart';

class TaskStatusFilterBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasksFilterBloc = BlocProvider.of<TasksFilterBloc>(context);

    return BlocBuilder<TasksFilterBloc, TasksFilterState>(
        builder: (context, state) {
      if (state is TasksFilterSuccess) {
        return TaskStatusFilter(
          handler: (TasksVisibilityFilter filter) {
            tasksFilterBloc.add(TaskFilterUpdated(filter));
          },
        );
      }
      return Container();
    });
  }
}
