import 'package:education_app/core/errors/exception.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({required this.messages, required this.statusCode})
      : assert(statusCode is String || statusCode is int,
            'StatusCode cannot be a ${statusCode.runtimeType}');
  final String messages;
  final dynamic statusCode;

  String get errorMessage => '$statusCode Error : $messages';

  @override
  List<dynamic> get props => [messages, statusCode];
}

class ServerFailure extends Failure {
  ServerFailure({required super.messages, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(messages: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure {
  CacheFailure({required super.messages, required super.statusCode});
}
