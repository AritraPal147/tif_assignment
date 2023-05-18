import '../../models/data.dart';

class ContentDetails {
  ContentDetails({required this.data, required this.meta});

  final Data data;
  final int meta;

  factory ContentDetails.fromJson(Map<String, dynamic> parsedJson) {
    return ContentDetails(
      data: parsedJson['data'],
      meta: parsedJson['meta']['total'],
    );
  }
}
