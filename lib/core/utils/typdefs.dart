import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failurs.dart';

typedef RsultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
