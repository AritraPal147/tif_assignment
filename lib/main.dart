import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tif_assignment/events/view/home_screen.dart';
import 'package:tif_assignment/simple_bloc_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TIF Assignment',
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      // '/details': (context) => const DetailsScreen(),
      // '/search': (context) => const SearchScreen(),
    },
  ),);
}

