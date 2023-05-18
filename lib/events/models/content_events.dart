import '../../models/data.dart';

class ContentEvents{
  ContentEvents({required this.data, required this.meta});

  final List<Data> data;
  final int meta;

  factory ContentEvents.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return ContentEvents(
      data: dataList,
      meta: parsedJson['meta']['total'],
    );
  }
}