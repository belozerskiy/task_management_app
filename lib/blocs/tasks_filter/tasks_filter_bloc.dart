import 'package:bloc/bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_event.dart';
import 'package:task_manager_mobile/blocs/tasks_filter/task_filter_state.dart';
import 'package:task_manager_mobile/blocs/tasks_filter/tasks_filter_event.dart';
import 'package:task_manager_mobile/models/tasks_visibility_filter.dart';

class TasksFilterBloc extends Bloc<TasksFilterEvent, TasksFilterState> {
  TasksFilterBloc({this.taskBloc});

  final TaskBloc taskBloc;

  @override
  TasksFilterState get initialState => TasksFilterSuccess.initialize();

  @override
  Stream<TasksFilterState> mapEventToState(
    TasksFilterEvent event,
  ) async* {
    if (event is TaskFilterUpdated) {
      yield TasksFilterSuccess(event.filter);

      taskBloc.add(
        TasksLoaded(
          status: TaskVisibilityFilterHelper(event.filter).toString(),
          reset: true,
        ),
      );
    }
  }
}
