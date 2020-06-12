import 'dart:io';

import 'package:dobliviate/Image.dart' as dobliviate;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dobliviate/blocs/images_loader_bloc/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DObivialte',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context) => ImagesLoaderBloc(),
          child: MyHomePage(title: 'DObliviate')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List images = List<dobliviate.Image>();

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child:
              BlocBuilder<ImagesLoaderBloc, ImagesLoaderState>(builder: (context, state) {
            if (state is ImagesLoading || state is ImagesEmpty) {
              return CircularProgressIndicator();
            } else if (state is ImagesLoaded) {
              images = state.images;
              return GridView.count(
                  crossAxisCount: 3,
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  children: List<Container>.generate(
                      images.length,
                      (int index) => Container(
                              child: Image.file(
                            File(images[index].uri),
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ))));
            } else {
              return Text("Something went wrong");
            }
          }),
        ));
  }

  void _requestPermissions() async {
    await Permission.storage.request().then((value) {
      if (value == PermissionStatus.denied) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      } else {
        BlocProvider.of<ImagesLoaderBloc>(context).add(RefreshImages());
      }
    });
  }
}
