import 'package:bloc/bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_event.dart';
import 'package:task_manager_mobile/blocs/task/task_state.dart';
import 'package:task_manager_mobile/models/task_model.dart';
import 'package:task_manager_mobile/models/task_status.dart';
import 'package:task_manager_mobile/repositories/graphql_task_repository.dart';

import 'package:rxdart/rxdart.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  GraphQLTaskRepository taskRepository;

  TaskBloc({this.taskRepository});

  @override
  TaskState get initialState => TasksLoadingStart();

  @override
  Stream<TaskState> transformEvents(
    Stream<TaskEvent> events,
    next,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      next,
    );
  }

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is TasksLoaded) {
      yield* _mapTaskLoadedEventToState(event);
    }

    if (event is TaskStatusChanged) {
      yield* _mapTaskStatusChangedEventToState(event);
    }

    if (event is TaskAdded) {
      yield* _mapTaskAddedEventToState(event);
    }

    if (event is TaskDeleted) {
      yield* _mapTaskDeletedEventToState(event);
    }
  }

  Stream<TaskState> _mapTaskLoadedEventToState(TasksLoaded event) async* {
    try {
      final limit = 15;

      if (event.reset) {
        yield TasksLoadingStart();

        List<TaskModel> tasks = await taskRepository.getTasks(
          search: event.search,
          status: event.status,
          skip: 0,
          limit: limit,
        );

        yield TasksLoadingSuccess(
          tasks: tasks,
          skip: 0,
          limit: limit,
          loadMore: tasks.length >= limit,
        );
      } else if (state is TasksLoadingSuccess) {
        final prevState = (state as TasksLoadingSuccess);

        if (prevState.loadMore) {
          final skip = limit + prevState.skip;

          List<TaskModel> tasks = await taskRepository.getTasks(
            search: event.search,
            status: event.status,
            skip: skip,
            limit: limit,
          );

          yield TasksLoadingSuccess(
            tasks: prevState.tasks + tasks,
            skip: skip,
            limit: limit,
            loadMore: tasks.length >= limit,
          );
        }
      }
    } catch (e) {
      yield TasksLoadingError();
    }
  }

  Stream<TaskState> _mapTaskStatusChangedEventToState(
      TaskStatusChanged event) async* {
    // Clone prev task and pass new status to it
    final updatedTask = await taskRepository.updateTaskStatus(
      id: event.task.id,
      status: TaskStatusHelper(event.status).stringStatus,
    );
    // Replace old task
    final tasks = (state as TasksLoadingSuccess)
        .tasks
        .map((task) => task.id == updatedTask.id ? updatedTask : task)
        .toList();

    yield TasksLoadingSuccess(tasks: tasks);
  }

  Stream<TaskState> _mapTaskDeletedEventToState(TaskDeleted event) async* {
    final deletedTask = await taskRepository.deleteTask(event.task.id);

    if (deletedTask != null) {
      final prevState = (state as TasksLoadingSuccess);
      final tasks =
          prevState.tasks.where((task) => task.id != deletedTask.id).toList();

      yield TasksLoadingSuccess(
        tasks: tasks,
        skip: prevState.skip,
        limit: prevState.limit,
        loadMore: prevState.loadMore,
      );
    }
  }

  Stream<TaskState> _mapTaskAddedEventToState(TaskAdded event) async* {
    final createdTask = await taskRepository.createTask(
        title: event.title, description: event.description);
    if (createdTask != null) {
      final tasks = (state as TasksLoadingSuccess).tasks;
      yield TasksLoadingSuccess(tasks: [createdTask, ...tasks]);
    }
  }
}
