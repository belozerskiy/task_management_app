import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_bloc.dart';
import 'package:task_manager_mobile/blocs/task/task_event.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({
    Key key,
  }) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  TaskBloc _taskBloc;
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _taskBloc = BlocProvider.of<TaskBloc>(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  addTask() {
    final String title = _titleController.value.text;
    final String description = _descriptionController.value.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      _taskBloc.add(
        TaskAdded(
          title: title,
          description: description,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment(1, 0),
            child: Container(
              child: RaisedButton(
                child: Text('Add task'),
                onPressed: addTask,
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
