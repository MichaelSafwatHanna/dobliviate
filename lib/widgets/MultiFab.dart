import 'package:flutter/material.dart';

class MultiFab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MultiFabState();
}

class _MultiFabState extends State<MultiFab>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;

  @override
  initState() {
    super.initState();
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
              onPressed: _expand,
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
