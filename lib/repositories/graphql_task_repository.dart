import 'package:graphql/client.dart';
import 'package:task_manager_mobile/models/task_model.dart';
import 'package:task_manager_mobile/queries/task_query.dart';
import 'abstract_task_repository.dart';

class GraphQLTaskRepository implements AbstractTaskRepository {
  final GraphQLClient client;

  GraphQLTaskRepository({this.client});

  // Get all tasks or task equal search or status
  @override
  Future<List<TaskModel>> getTasks({
    String search,
    String status,
    int skip = 0,
    int limit = 15,
  }) async {
    const query = GET_TASKS_QUERY;

    final WatchQueryOptions options = WatchQueryOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
        'search': search,
        'status': status,
        'skip': skip,
        'limit': limit,
      },
      pollInterval: 100,
      fetchResults: true,
    );

    final QueryResult resultQuery = await this.client.query(options);

    if (resultQuery.hasException) {
      print(resultQuery.exception.graphqlErrors);
      print(resultQuery.exception.clientException);
    }

    List<TaskModel> result = resultQuery.data['getTasks']
        .map<TaskModel>((task) => TaskModel.fromHashMap(task))
        .toList();
    return result;
  }

  @override
  Future<TaskModel> getTask(int id) {
    return null;
  }

  // Update task status
  @override
  Future<TaskModel> updateTaskStatus({
    int id,
    String status,
  }) async {
    const query = UPDATE_TASK_STATUS_QUERY;

    final MutationOptions options = MutationOptions(
      documentNode: gql(query),
      variables: <String, dynamic>{
        'id': id,
        'status': status,
      },
    );
    final QueryResult queryResult = await this.client.mutate(options);
    return TaskModel.fromHashMap(queryResult.data['updateTaskStatus']);
  }

  // Delete task by id
  @override
  Future<TaskModel> deleteTask(int id) async {
    const mutation = DELETE_TASK_BY_ID;

    final MutationOptions options = MutationOptions(
      documentNode: gql(mutation),
      variables: <String, dynamic>{
        'id': id,
      },
    );

    final queryResult = await this.client.mutate(options);

    if (queryResult.hasException) {
      print(queryResult.exception);
      print(queryResult.exception.clientException);
      print(queryResult.exception.graphqlErrors);
      print(queryResult.data);
    }

    return TaskModel.fromHashMap(queryResult.data['deleteTask']);
  }

  // Create task
  @override
  Future<TaskModel> createTask({
    String title,
    String description,
  }) async {
    const mutation = CREATE_TASK;
    final options = MutationOptions(
      documentNode: gql(mutation),
      variables: {
        'title': title,
        'description': description,
      },
    );

    final queryResult = await this.client.mutate(options);

    if (queryResult.hasException) {
      print(queryResult.exception);
      print(queryResult.exception.clientException);
      print(queryResult.exception.graphqlErrors);
      print(queryResult.data);
    }

    return TaskModel.fromHashMap(queryResult.data['createTask']);
  }
}
