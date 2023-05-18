part of 'events_bloc.dart';

enum EventsStatus { initial, success, failure }

final class EventsState extends Equatable {
  const EventsState({
    this.status = EventsStatus.initial,
    this.data = const <Data>[],
    this.hasReachedMax = false,
  });

  final EventsStatus status;
  final List<Data> data;
  final bool hasReachedMax;

  EventsState copyWith({
    EventsStatus? status,
    List<Data>? data,
    bool? hasReachedMax,
  }) {
    return EventsState(
      status: status ?? this.status,
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''EventsState { status: $status, hasReachedMax: $hasReachedMax, data: ${data.length} }''';
  }

  @override
  List<Object> get props => [status, data, hasReachedMax];
}
