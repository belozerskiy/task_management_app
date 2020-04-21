import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_mobile/blocs/tasks_search/tasks_search_bloc.dart';
import 'package:task_manager_mobile/blocs/tasks_search/tasks_search_event.dart';
import 'package:task_manager_mobile/blocs/tasks_search/tasks_search_state.dart';
import 'package:task_manager_mobile/ui/search_bar.dart';
import 'package:task_manager_mobile/ui/tasks_status_filter_bloc.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksSearchBloc = BlocProvider.of<TasksSearchBloc>(context);

    return BlocBuilder<TasksSearchBloc, TasksSearchState>(
      builder: (context, state) {
        if (state is TasksSearchShowing) {
          return SearchBar(
            search$: tasksSearchBloc.search$,
            inSearch: tasksSearchBloc.inSearch,
            onClose: () => tasksSearchBloc.add(
              TasksSearchHided(),
            ),
          );
        }

        return AppBar(
          title: Text('Task Management App'),
          actions: <Widget>[
            TaskStatusFilterBloc(),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => tasksSearchBloc.add(TasksSearchShowed()),
            )
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}
