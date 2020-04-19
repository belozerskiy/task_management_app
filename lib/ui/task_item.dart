import 'package:flutter/material.dart';
import 'package:task_manager_mobile/models/task_status.dart';
import 'package:task_manager_mobile/ui/status_dropdown_button.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final TaskStatus status;
  final Function onUpdateStatus;

  const TaskItem({
    Key key,
    this.title,
    this.description,
    this.status,
    this.onUpdateStatus,
  }) : super(key: key);

  get statusList {
    return [
      StatusDropdownModel(
        value: TaskStatus.OPEN,
        label: 'OPEN',
        color: Colors.blue[0],
      ),
      StatusDropdownModel(
        value: TaskStatus.IN_PROGRESS,
        label: 'IN PROGRESS',
        color: Colors.blue[400],
      ),
      StatusDropdownModel(
        value: TaskStatus.DONE,
        label: 'DONE',
        color: Colors.blue[800],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                width: 140,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: StatusDropdownButton(
                  value: status,
                  items: statusList,
                  onChanged: onUpdateStatus,
                ),
              ),
            ],
          ),
          const Divider(
            height: 0,
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
