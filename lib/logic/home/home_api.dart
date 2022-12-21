import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core/api/api_consumer.dart';
import '../../locator/locator.dart';
import '../../models/album.dart';
import '../../models/post.dart';

@lazySingleton
class HomeAPI {
  final dio = locator<ApiConsumer>();
  Future<List<Post>> getAllPosts() async {
    final response = await dio.get('/posts') as List<dynamic>;
    return response.map((e) => Post.fromJson(e)).toList();
  }

  Future<List<Album>> getAllAlbums() async {
    await Future.delayed(Duration(seconds: 5));
    final response = await dio.get('/albums') as List<dynamic>;
    return compute(parseAlbums, response);
  }
}

List<Album> parseAlbums(List<dynamic> albums) {
  return albums.map((e) => Album.fromJson(e)).toList();
}
