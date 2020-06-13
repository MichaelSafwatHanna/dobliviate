import 'dart:async';

import 'package:dobliviate/blocs/images_loader_bloc/bloc.dart';
import 'package:dobliviate/blocs/permission_bloc/bloc.dart';
import 'package:dobliviate/widgets/ImagesGrid.dart';
import 'package:dobliviate/widgets/RequestPermission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PermissionBloc>(context).add(CheckStoragePermission());
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            BlocProvider.of<ImagesLoaderBloc>(context).add(RefreshImages());
            return _refreshCompleter.future;
          },
          child: Center(
            child: BlocBuilder<PermissionBloc, PermissionStatus>(
              builder: (context, state) {
                if (state != PermissionStatus.granted) {
                  return RequestPermission();
                } else {
                  BlocProvider.of<ImagesLoaderBloc>(context)
                      .add(RefreshImages());
                  return BlocBuilder<ImagesLoaderBloc, ImagesLoaderState>(
                      builder: (context, state) {
                    if (state is ImagesLoading || state is ImagesEmpty) {
                      return CircularProgressIndicator();
                    } else if (state is ImagesLoaded) {
                      _refreshCompleter?.complete();
                      _refreshCompleter = Completer();
                      return ImagesGrid(images: state.images);
                    } else {
                      return Text("Something went wrong!");
                    }
                  });
                }
              },
            ),
          ),
        ));
  }
}
