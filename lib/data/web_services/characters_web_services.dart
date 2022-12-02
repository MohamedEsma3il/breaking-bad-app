import 'package:breaking_bad/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: 20 * 1000, //20 seconds
      connectTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      debugPrint(response.data.toString());
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response = await dio.get('quote',queryParameters: {'author':charName});
      debugPrint(response.data.toString());
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
