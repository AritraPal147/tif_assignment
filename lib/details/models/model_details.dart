import 'package:tif_assignment/details/models/content_details.dart';

class ModelDetails {
  ContentDetails content;
  bool status;

  ModelDetails({required this.content, required this.status});

  factory ModelDetails.fromJson(Map<String, dynamic> json) {
    return ModelDetails(
      content: ContentDetails.fromJson(json['content']),
      status: json['status'],
    );
  }
}
