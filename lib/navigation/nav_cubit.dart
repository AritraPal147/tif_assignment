import 'package:bloc/bloc.dart';
import 'package:tif_assignment/details/bloc/details_bloc.dart';
import 'package:tif_assignment/events/bloc/events_bloc.dart';

class NavCubit extends Cubit<EventsState> {
  NavCubit() : super(const EventsState());

  void showDetails(EventsState state) => emit(state);

  void popToEvents() => emit(const EventsState());
}
