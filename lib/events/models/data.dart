import 'dart:core';

final class Data {
  const Data({
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

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      id: parsedJson['id'],
      title: parsedJson['title'],
      description: parsedJson['description'],
      bannerImage: parsedJson['banner_image'],
      dateTime: parsedJson['date_time'],
      organizerName: parsedJson['organiser_name'],
      organizerIcon: parsedJson['organiser_icon'],
      venueName: parsedJson['venue_name'],
      venueCity: parsedJson['venue_city'],
      venueCountry: parsedJson['venue_country'],
    );
  }
}
