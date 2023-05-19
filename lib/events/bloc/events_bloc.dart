import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:tif_assignment/constants/constants.dart';
import 'package:tif_assignment/models/data.dart';

import '../models/model_events.dart';

part 'events_state.dart';

part 'events_event.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc({required this.httpClient}) : super(const EventsState()) {
    on<EventsFetched>(
      _onEventsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onEventsFetched(
    EventsFetched event,
    Emitter<EventsState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == EventsStatus.initial) {
        final events = await _fetchEvents();
        return emit(
          state.copyWith(
            status: EventsStatus.success,
            data: events,
            hasReachedMax: false,
          ),
        );
      }
      final events = await _fetchEvents();
      if (state.data.length < 13) {
        emit(
          state.copyWith(
            status: EventsStatus.success,
            data: List.of(state.data)..addAll(events),
            hasReachedMax: true,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: EventsStatus.failure));
    }
  }

  Future<List<Data>> _fetchEvents() async {
    final response = await httpClient.get(
      Uri.https(
        Constants.endPoint,
        Constants.eventPageLink,
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      ModelEvents model = ModelEvents.fromJson(body);
      return model.content.data;
    }
    throw Exception(Constants.errorText);
  }
}
