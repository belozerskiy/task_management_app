import 'package:flutter/material.dart';

class StatusDropdownLabel extends StatelessWidget {
  final Color color;
  final String label;

  const StatusDropdownLabel({
    Key key,
    @required this.label,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1, 0),
      child: Chip(
        backgroundColor: color,
        label: Text(label),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
