import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:tif_assignment/constants/constants.dart';
import 'package:tif_assignment/events/models/data.dart';

import '../models/model.dart';

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
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(
    EventsFetched event,
    Emitter<EventsState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == EventsStatus.initial) {
        final posts = await _fetchPosts();
        return emit(
          state.copyWith(
            status: EventsStatus.success,
            data: posts,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await _fetchPosts();
      if (state.data.length < 13) {
        emit(
          state.copyWith(
            status: EventsStatus.success,
            data: List.of(state.data)..addAll(posts),
            hasReachedMax: false,
          ),
        );
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(status: EventsStatus.failure));
    }
  }

  Future<List<Data>> _fetchPosts() async {
    final response = await httpClient.get(
      Uri.https(
        Constants.endPoint,
        Constants.eventPageLink,
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      // Content content = Content.fromJson(body);
      Model model = Model.fromJson(body);
      return model.content.data;
    }
    throw Exception('Error fetching posts');
  }
}
