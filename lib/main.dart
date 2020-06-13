import 'package:dobliviate/blocs/images_loader_bloc/bloc.dart';
import 'package:dobliviate/blocs/permission_bloc/bloc.dart';
import 'package:dobliviate/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (context) => PermissionBloc()),
        BlocProvider(create: (context) => ImagesLoaderBloc()),
      ], child: MyHomePage(title: 'DObliviate')),
    );
  }
}
