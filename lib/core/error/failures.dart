// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String msg;
  const Failure({
    required this.msg,
  });
  @override
  List<Object> get props => [msg];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.msg});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.msg});
}
