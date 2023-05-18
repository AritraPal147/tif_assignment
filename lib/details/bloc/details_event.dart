part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class DetailsFetched extends DetailsEvent {}
