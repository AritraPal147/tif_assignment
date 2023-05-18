import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tif_assignment/events/models/model.dart';
import 'package:http/http.dart' as http;

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc({required this.httpClient}) : super(const EventsState()) {
    /// TODO: register on<EventFetched> event
  }

  final http.Client httpClient;
}