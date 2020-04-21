import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_event.dart';
import 'package:task_manager_mobile/blocs/task/task_state.dart';
import 'package:task_manager_mobile/blocs/tasks_search/tasks_search_bloc.dart';
import 'package:task_manager_mobile/blocs/tasks_search/tasks_search_event.dart';
import 'package:task_manager_mobile/blocs/tasks_search/tasks_search_state.dart';
import 'package:task_manager_mobile/screens/create_task_screen.dart';
import 'package:task_manager_mobile/ui/header.dart';
import 'package:task_manager_mobile/ui/search_bar.dart';
import 'package:task_manager_mobile/ui/tasks_list.dart';
import 'package:task_manager_mobile/ui/tasks_status_filter_bloc.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/';

  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TasksLoadingSuccess) {
                  final tasks = state.tasks;
                  final loadMore = state.loadMore;

                  if (tasks.isNotEmpty) {
                    return TaskList(
                      tasks: tasks,
                      loadMore: loadMore,
                    );
                  } else {
                    return Center(
                      child: Text(
                        'You don\'t have any task',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                    );
                  }
                }
                if (state is TasksLoadingError) {
                  return Center(
                    child: Text('Error acured'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(CreateTaskScreen.routeName);
        },
      ),
    );
  }
}
