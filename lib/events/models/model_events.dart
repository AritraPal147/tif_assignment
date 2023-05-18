import 'package:tif_assignment/events/models/content_events.dart';

class ModelEvents {
  ContentEvents content;
  bool status;

  ModelEvents({required this.content, required this.status});

  factory ModelEvents.fromJson(Map<String, dynamic> json) {
    return ModelEvents(
      content: ContentEvents.fromJson(json['content']),
      status: json['status'],
    );
  }
}
