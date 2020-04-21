import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task_manager_mobile/blocs/task/task_bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_event.dart';
import 'package:task_manager_mobile/blocs/tasks_search/tasks_search_event.dart';
import 'package:task_manager_mobile/blocs/tasks_search/tasks_search_state.dart';

class TasksSearchBloc extends Bloc<TasksSearchEvent, TasksSearchState> {
  TasksSearchBloc({this.taskBloc}) {
    this.search$.debounceTime(Duration(milliseconds: 500)).listen(handleSearch);
  }

  final TaskBloc taskBloc;
  final _search = BehaviorSubject<String>();

  Stream<String> get search$ => _search.stream;
  Sink<String> get inSearch => _search.sink;

  @override
  Future<void> close() async {
    _search.close();
    super.close();
  }

  handleSearch(String searchQuery) {
    print(searchQuery);
    // final taskState = (taskBloc.state as TasksLoadingSuccess)
    taskBloc.add(TasksLoaded(search: searchQuery, reset: true));
  }

  @override
  get initialState => TasksSearchHiding();

  @override
  Stream<TasksSearchState> mapEventToState(event) async* {
    if (event is TasksSearchShowed) {
      yield* _mapSearchShowedToState(event);
    }
    if (event is TasksSearchHided) {
      yield* _mapSearchHiddedToState(event);
    }
  }

  Stream<TasksSearchState> _mapSearchShowedToState(event) async* {
    yield TasksSearchShowing();
  }

  Stream<TasksSearchState> _mapSearchHiddedToState(event) async* {
    yield TasksSearchHiding();
    taskBloc.add(TasksLoaded());
  }
}
