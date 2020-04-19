import 'package:task_manager_mobile/models/task_model.dart';

abstract class AbstractTaskRepository {
  Future<List<TaskModel>> getTasks({
    String search,
    String status,
  });

  Future<TaskModel> getTask(int id);

  Future<TaskModel> updateTaskStatus({
    int id,
    String status,
  });

  Future<TaskModel> createTask({
    String title,
    String description,
  });

  Future<TaskModel> deleteTask(int id);
}
