import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/details/bloc/details_bloc.dart';
import 'package:http/http.dart' as http;

import 'details.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    int id = arg['id'];
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => DetailsBloc(httpClient: http.Client(), id: id),
        child: const Details(),
      ),
    );
  }
}
