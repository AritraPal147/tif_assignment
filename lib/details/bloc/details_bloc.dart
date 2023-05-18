import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tif_assignment/constants/constants.dart';
import 'package:tif_assignment/details/models/model_details.dart';
import 'package:tif_assignment/models/data.dart';
import 'package:http/http.dart' as http;

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc({required this.httpClient, required this.id})
      : super(const DetailsState()) {
    on<DetailsFetched>((event, emit) {
      _onDetailsFetched;
    });
  }

  final http.Client httpClient;
  final int id;

  Future<void> _onDetailsFetched(
    DetailsFetched event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      final details = await _fetchDetails();
      print(details);
      emit(
        state.copyWith(
          status: DetailsStatus.success,
          data: details,
        ),
      );
    } catch (_) {
      print(_);
      emit(state.copyWith(status: DetailsStatus.failure));
    }
  }

  Future<Data> _fetchDetails() async {
    final response = await httpClient.get(
      Uri.https(
        '${Constants.endPoint}${Constants.eventPageLink}',
        id.toString(),
      ),
    );
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      ModelDetails model = ModelDetails.fromJson(jsonBody);
      return model.content.data;
    }
    throw Exception(Constants.errorText);
  }
}
