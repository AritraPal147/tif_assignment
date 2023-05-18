part of 'events_bloc.dart';

sealed class EventsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class EventsFetched extends EventsEvent {}