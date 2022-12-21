import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/services/snack_bar_service.dart';
import '../../core/state_management/view_state.dart';
import '../../core/utils/dialogs.dart';
import '../../locator/locator.dart';
import '../../logic/home/home_repository.dart';
import '../../models/album.dart';
import '../../models/post.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  
  final firstRepository = locator<HomeRepository>();
  final SnackBarService _snackBarService = locator<SnackBarService>();
  final navigator = locator<NavigationService>();
  String errorMsg = '';
  List<Post> posts = [];
  List<Album> albums = [];
  ViewState viewState1 = ViewState.initial;
  ViewState viewState2 = ViewState.initial;

  Future<void> initPosts() async {
    viewState1 = ViewState.loading;
    final result = await firstRepository.getAllPosts();
    result.fold(
      (failure) {
        _snackBarService.showErrorSnackBar(failure.msg);
        viewState1 = ViewState.error;
        errorMsg = failure.msg;
        notifyListeners();
      },
      (posts) {
        this.posts = posts;
        viewState1 = ViewState.success;
        notifyListeners();
      },
    );
  }

  Future<void> initAlbums() async {
    viewState2 = ViewState.loading;
    showLoadingDialog();
    final result = await firstRepository.getAllAlbums();
    result.fold(
      (failure) {
        errorMsg = failure.msg;
        viewState2 = ViewState.error;
        notifyListeners();
        dismissLoadingDialog();
      },
      (albums) {
        this.albums = albums;
        viewState2 = ViewState.success;
        notifyListeners();
        dismissLoadingDialog();
      },
    );
  }

  void deletePosts() {
    posts = posts.take(2).toList();
    notifyListeners();
  }
}
