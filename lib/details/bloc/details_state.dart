part of 'details_bloc.dart';

enum DetailsStatus { initial, success, failure }

final class DetailsState extends Equatable {
  const DetailsState({
    this.status = DetailsStatus.initial,
    this.data,
  });

  final DetailsStatus status;
  final Data? data;

  DetailsState copyWith({
    DetailsStatus? status,
    Data? data,
  }) {
    return DetailsState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return '''DetailsState { status: $status, data: $data }''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, data];
}
