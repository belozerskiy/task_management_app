import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_manager_mobile/models/task_status.dart';
import 'package:task_manager_mobile/ui/status_dropdown_button.dart';

class TasksSearchForm extends StatelessWidget {
  const TasksSearchForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(),
          ),
          Container(
            width: 100,
            child: StatusDropdownButton(
              value: TaskStatus.OPEN,
              items: [
                StatusDropdownModel(
                  label: 'OPEN',
                  value: TaskStatus.OPEN,
                  color: Colors.blue[0],
                ),
                StatusDropdownModel(
                  label: 'IN_PROGRESS',
                  value: TaskStatus.IN_PROGRESS,
                  color: Colors.blue[400],
                ),
                StatusDropdownModel(
                  label: 'DONE',
                  value: TaskStatus.DONE,
                  color: Colors.blue[800],
                )
              ],
              onChanged: (value) {},
            ),
          )
        ],
      ),
    );
    // keyboardType: TextInputType.text,
  }
}
