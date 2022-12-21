import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImp implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;
  NetworkInfoImp({
    required this.dataConnectionChecker,
  });
  @override
  Future<bool> get isConnected async =>
      await dataConnectionChecker.hasConnection;
}
