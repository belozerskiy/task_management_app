import 'package:flutter/material.dart';

class TaskDismissible extends StatelessWidget {
  final Widget child;
  final Function onDismiss;

  const TaskDismissible({
    Key key,
    this.child,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: child,
      background: Container(
        padding: EdgeInsets.only(right: 20),
        alignment: Alignment(1, 0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      onDismissed: onDismiss,
    );
  }
}
