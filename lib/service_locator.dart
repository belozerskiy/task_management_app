import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:task_manager_mobile/repositories/graphql_task_repository.dart';
import 'package:task_manager_mobile/utils/client.dart';

import 'blocs/task/task_bloc.dart';
import 'blocs/tasks_filter/tasks_filter_bloc.dart';
import 'blocs/tasks_search/tasks_search_bloc.dart';

void setup() {
  // Graphql client
  GetIt.I.registerSingleton<GraphQLClient>(createClient());

  // Graphql repository
  GetIt.I.registerSingleton<GraphQLTaskRepository>(
    GraphQLTaskRepository(
      client: GetIt.I<GraphQLClient>(),
    ),
  );

  // Task Bloc
  GetIt.I.registerSingleton<TaskBloc>(
    TaskBloc(
      taskRepository: GetIt.I<GraphQLTaskRepository>(),
    ),
  );

  // Filter Task Bloc
  GetIt.I.registerSingleton<TasksFilterBloc>(
    TasksFilterBloc(
      taskBloc: GetIt.I<TaskBloc>(),
    ),
  );

  // Search Task Bloc
  GetIt.I.registerSingleton<TasksSearchBloc>(
    TasksSearchBloc(
      taskBloc: GetIt.I<TaskBloc>(),
    ),
  );
}
