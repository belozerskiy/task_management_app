import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_event.dart';
import 'package:task_manager_mobile/models/task_model.dart';
import 'package:task_manager_mobile/models/task_status.dart';
import 'package:task_manager_mobile/ui/task_dissmisible.dart';
import 'package:task_manager_mobile/ui/task_item.dart';

class TaskList extends StatefulWidget {
  final List<TaskModel> tasks;
  final bool loadMore;

  const TaskList({
    Key key,
    this.tasks,
    this.loadMore = false,
  }) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  ScrollController _scrollController;
  TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _scrollController = ScrollController();
    _scrollController.addListener(onScrollChange);
  }

  @override
  void dispose() {
    _scrollController.removeListener(onScrollChange);
    _scrollController.dispose();
    super.dispose();
  }

  int get itemCount {
    return widget.loadMore ? widget.tasks.length + 1 : widget.tasks.length;
  }

  int get tasksLength {
    return widget.tasks.length - 1;
  }

  void onScrollChange() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll && widget.loadMore) {
      _taskBloc.add(TasksLoaded());
    }
  }

  Future<void> onRefresh() async {
    _taskBloc.add(TasksLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index <= tasksLength) {
            TaskModel task = widget.tasks[index];

            return TaskDismissible(
              child: TaskItem(
                title: task.title,
                description: task.description,
                status: task.status,
                onUpdateStatus: (TaskStatus status) => _taskBloc.add(
                  TaskStatusChanged(task: task, status: status),
                ),
              ),
              onDismiss: (_) {
                _taskBloc.add(TaskDeleted(task));
              },
            );
          } else {
            return LoadingItem(
              key: ValueKey(index),
            );
          }
        },
      ),
    );
  }
}

class LoadingItem extends StatelessWidget {
  const LoadingItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, 0),
      padding: const EdgeInsets.all(20),
      child: const SizedBox(
        child: const CircularProgressIndicator(),
        height: 20.0,
        width: 20.0,
      ),
    );
  }
}
