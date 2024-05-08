// ignore_for_file: avoid_print, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/common/const.dart';
import 'package:news_app/model/news_model.dart';

class ApiServices {
  Future<NewsModel> getNewsData() async {
    Response response = await Dio().get(STRING_URL);
    if (response.statusCode == 200) {
      print("ISI: ${response.data}");
      final data = NewsModel.fromJson(response.data);
      print("MODEL: ${data.data.length}");
      return data;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}

final newsProvider = Provider<ApiServices>((ref) => ApiServices());
final newsDataProvider = FutureProvider.autoDispose((ref) async {
  return ref.read(newsProvider).getNewsData();
});
