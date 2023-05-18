import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assignment/events/bloc/events_bloc.dart';
import 'package:http/http.dart' as http;

import 'events_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events'),),
      body: BlocProvider(
        create: (_) => EventsBloc(httpClient: http.Client())..add(EventsFetched()),
        child: const EventsList(),
      ),
    );
  }
}
