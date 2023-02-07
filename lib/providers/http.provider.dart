import 'package:dio/dio.dart';

import '../models/game/music.model.dart';

class HttpProvider {
  factory HttpProvider() {
    return _instance;
  }

  HttpProvider._internal();

  static final HttpProvider _instance = HttpProvider._internal();

  final Dio _dio = Dio();

  Future<MusicModel> downloadMusicJson(String url) async {
    final Response<Map<String, dynamic>> response = await _dio.get<Map<String, dynamic>>(url);

    return MusicModel.fromJson(response.data!);
  }
}
