import 'package:dobliviate/blocs/images_bloc/bloc.dart';
import 'package:dobliviate/widgets/ConfirmDeletion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiFab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MultiFabState();
}

class _MultiFabState extends State<MultiFab>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  ImagesBloc _imagesBloc;

  AnimationController _animationController;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;

  @override
  initState() {
    super.initState();
    _imagesBloc = BlocProvider.of<ImagesBloc>(context);

    _animationController =
    AnimationController(duration: Duration(milliseconds: 256), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _translateButton = Tween<double>(
      begin: 56,
      end: -14.0,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.64, curve: Curves.easeOut)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2.5,
              0.0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              mini: true,
              tooltip: "Time Range",
              onPressed: _expand,
              heroTag: "timerange",
              child: Icon(Icons.history),
            )),
        Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 1.8,
              0.0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              mini: true,
              tooltip: "Notification",
              onPressed: _expand,
              heroTag: "notification",
              child: Icon(Icons.notifications),
            )),
        Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value,
              0.0,
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              mini: true,
              tooltip: "Delete",
              onPressed: () {
                if ((_imagesBloc.state is ImagesLoadSuccess) &&
                    (_imagesBloc.state as ImagesLoadSuccess).selected > 0) {
                  _showMyDialog();
                  _expand();
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Select Images!"),
                    backgroundColor: Colors.black,
                  ));
                }
              },
              heroTag: "delete",
              child: Icon(Icons.delete_forever),
            )),
        FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: _expand,
          tooltip: "Menu",
          heroTag: "menu",
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animateIcon,
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ConfirmDeletion(
            onPressPositive: (() {
              _imagesBloc.add(DeleteImages());
            }),
          );
        });
  }

  void _expand() {
    if (!expanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    expanded = !expanded;
  }

  @override
  dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
