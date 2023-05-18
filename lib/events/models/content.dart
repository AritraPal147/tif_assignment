import 'data.dart';

class Content{
  Content({required this.data, required this.meta});

  final List<Data> data;
  final int meta;

  factory Content.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();

    return Content(
      data: dataList,
      meta: parsedJson['meta']['total'],
    );
  }
}