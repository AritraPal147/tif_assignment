import 'package:tif_assignment/events/models/content.dart';

class Model {
  Content content;
  bool status;

  Model({required this.content, required this.status});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      content: Content.fromJson(json['content']),
      status: json['status'],
    );
  }
}
