import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager_mobile/blocs/task/task_bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_event.dart';
import 'package:task_manager_mobile/blocs/tasks_filter/tasks_filter_bloc.dart';
import 'package:task_manager_mobile/blocs/tasks_search/tasks_search_bloc.dart';
import 'package:task_manager_mobile/screens/create_task_screen.dart';
import 'package:task_manager_mobile/screens/main_screen.dart';
import 'package:task_manager_mobile/service_locator.dart';

class SimpleBlocDelegate extends BlocDelegate {
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  setup();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(TaskManagmentApp());
}

class TaskManagmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (_) => GetIt.I<TaskBloc>()..add(TasksLoaded(reset: true)),
        ),
        BlocProvider<TasksFilterBloc>(
          create: (_) => GetIt.I<TasksFilterBloc>(),
        ),
        BlocProvider<TasksSearchBloc>(
          create: (_) => GetIt.I<TasksSearchBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Task Management App',
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (_) => MainScreen(),
          CreateTaskScreen.routeName: (_) => CreateTaskScreen(),
        },
      ),
    );
  }
}
