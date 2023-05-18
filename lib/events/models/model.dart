import 'dart:core';

import 'package:equatable/equatable.dart';

final class Model extends Equatable {
  const Model({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerImage,
    required this.dateTime,
    required this.organizerName,
    required this.organizerIcon,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
  });

  final int id;
  final String title;
  final String description;
  final String bannerImage;
  final String dateTime;
  final String organizerName;
  final String organizerIcon;
  final String venueName;
  final String venueCity;
  final String venueCountry;

  @override
// TODO: implement props
  List<Object?> get props => [
        id,
        title,
        description,
        bannerImage,
        dateTime,
        organizerName,
        organizerIcon,
        venueName,
        venueCity,
        venueCountry,
      ];
}
