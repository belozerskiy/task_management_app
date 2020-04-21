import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget with PreferredSizeWidget {
  final Stream<String> search$;
  final Sink<String> inSearch;
  final Function onClose;

  SearchBar({
    this.search$,
    this.inSearch,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white70,
      title: StreamBuilder(
        stream: search$,
        builder: (context, snapshot) {
          return TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              errorText: snapshot.error,
            ),
            onChanged: inSearch.add,
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: onClose,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}
