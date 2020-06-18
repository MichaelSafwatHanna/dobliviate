import 'dart:async';

import 'package:dobliviate/blocs/images_bloc/bloc.dart';
import 'package:dobliviate/blocs/permission_bloc/bloc.dart';
import 'package:dobliviate/widgets/ImagesGrid.dart';
import 'package:dobliviate/widgets/ImagesListEmtpy.dart';
import 'package:dobliviate/widgets/MultiFab.dart';
import 'package:dobliviate/widgets/RequestPermission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<void> _refreshCompleter;
  bool _isSelectedAll = false;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: SvgPicture.asset(
              "assets/logo.svg",
              color: Colors.white,
              height: 40,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.select_all, color: Colors.white),
                onPressed: () => _selectAll(context))
          ],
        ),
        floatingActionButton: MultiFab(),
        backgroundColor: Colors.black,
        body: RefreshIndicator(
          onRefresh: () {
            BlocProvider.of<ImagesBloc>(context).add(RefreshImages());
            return _refreshCompleter.future;
          },
          child: Center(
            child: BlocBuilder<PermissionBloc, PermissionStatus>(
              builder: (context, state) {
                if (state != PermissionStatus.granted) {
                  return RequestPermission();
                } else {
                  BlocProvider.of<ImagesBloc>(context).add(RefreshImages());
                  return BlocBuilder<ImagesBloc, ImagesState>(
                      builder: (context, state) {
                    if (state is ImagesEmpty) {
                      _refreshCompleter?.complete();
                      _refreshCompleter = Completer();
                      return EmptyImagesList();
                    } else if (state is ImagesLoadInProgress) {
                      return CircularProgressIndicator();
                    } else if (state is ImagesLoadSuccess) {
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

  void _selectAll(BuildContext context) {
    if (_isSelectedAll) {
      BlocProvider.of<ImagesBloc>(context).add(DeselectAllImages());
      _isSelectedAll = false;
    } else {
      BlocProvider.of<ImagesBloc>(context).add(SelectAllImages());
      _isSelectedAll = true;
    }
  }
}
