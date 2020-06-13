import 'package:dobliviate/blocs/permission_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestPermission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.error_outline, color: Colors.red),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Permission Denied to Access Storage!",
            style: TextStyle(color: Colors.red),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            color: Colors.white,
            onPressed: () {
              BlocProvider.of<PermissionBloc>(context)
                  .add(RequestStoragePermission());
            },
            child: Text("Request Permission"),
          ),
        )
      ],
    );
  }
}
