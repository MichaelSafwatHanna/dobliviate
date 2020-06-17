import 'package:flutter/material.dart';

class ConfirmDeletion extends StatefulWidget {
  final Function onPressPositive;

  const ConfirmDeletion({Key key, @required this.onPressPositive})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfirmDeletionState();
}

class _ConfirmDeletionState extends State<ConfirmDeletion> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: ListTile(
        title: Text(
          'Warning',
          style: TextStyle(fontSize: 24),
        ),
        leading: Icon(
          Icons.warning,
          size: 28,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Are you sure you want to delete selected images?'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Discard', style: TextStyle(fontSize: 16)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Obliviate',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              )),
          onPressed: () {
            widget.onPressPositive();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
