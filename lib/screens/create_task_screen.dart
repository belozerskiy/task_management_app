import 'package:flutter/material.dart';

import 'package:task_manager_mobile/ui/task_form.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({Key key}) : super(key: key);

  static const routeName = 'create-task';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create task'),
      ),
      body: TaskForm(),
    );
  }
}
