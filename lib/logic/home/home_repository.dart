import 'package:dartz/dartz.dart';
import 'package:helloworld/models/album.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../../locator/locator.dart';
import '../../models/post.dart';
import 'home_api.dart';

@lazySingleton
class HomeRepository {
  final firstApi = locator<HomeAPI>();

  Future<Either<Failure, List<Post>>> getAllPosts() async {
    try {
      final posts = await firstApi.getAllPosts();
      return Right(posts);
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }

  Future<Either<Failure, List<Album>>> getAllAlbums() async {
    try {
      final alboms = await firstApi.getAllAlbums();
      return Right(alboms);
    } catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    }
  }
    


}
