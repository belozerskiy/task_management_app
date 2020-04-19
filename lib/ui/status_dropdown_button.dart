import 'package:flutter/material.dart';
import 'package:task_manager_mobile/models/task_status.dart';
import 'package:task_manager_mobile/ui/status_dropdow_label.dart';

class StatusDropdownModel {
  final TaskStatus value;
  final String label;
  final Color color;
  const StatusDropdownModel({this.value, this.label, this.color});
}

class StatusDropdownButton extends StatelessWidget {
  final TaskStatus value;
  final List<StatusDropdownModel> items;
  final Function onChanged;

  const StatusDropdownButton({
    Key key,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      iconSize: 0,
      icon: Container(),
      underline: Container(),
      style: TextStyle(color: Colors.white),
      isExpanded: true,
      value: value,
      onChanged: onChanged,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item.value,
              child: StatusDropdownLabel(
                label: item.label,
                color: item.color,
              ),
            ),
          )
          .toList(),
    );
  }
}
