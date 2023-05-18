import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:tif_assignment/events/models/model.dart';

part 'events_state.dart';

part 'events_event.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<EventsEvent, EventsState> {
  PostBloc({required this.httpClient}) : super(const EventsState()) {
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
      final posts = await _fetchPosts(state.data.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: EventsStatus.success,
                data: List.of(state.data)..addAll(posts),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: EventsStatus.failure));
    }
  }

  Future<List<Model>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Model(
          id: map['id'] as int,
          title: map['title'] as String,
          description: map['description'] as String,
          bannerImage: map['banner_image'] as String,
          dateTime: map['date_time'] as String,
          organizerName: map['organizer_name'] as String,
          organizerIcon: map['organizer_icon'] as String,
          venueName: map['venue_name'] as String,
          venueCity: map['venue_city'] as String,
          venueCountry: map['venue_country'] as String,
        );
      }).toList();
    }
    throw Exception('Error fetching posts');
  }
}
