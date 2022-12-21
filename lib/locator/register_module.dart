import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class RegisterModule {
  @injectable
  GoogleSignIn get googleSignIn => GoogleSignIn();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();

  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  LogInterceptor get logInterceptor => LogInterceptor();

  @singleton
  NavigationService get navigationService => NavigationService();

  @singleton
  DialogService get dialogService => DialogService();

  @singleton
  BottomSheetService get bottomSheetService => BottomSheetService();
}
