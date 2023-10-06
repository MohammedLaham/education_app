import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failurs.dart';
import 'package:education_app/src/on_boarding/domain/repo/on_bording_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cahce_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'on_boarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimer useCase;
  setUp(() {
    repo = MockOnBoardingRepo();
    useCase = CacheFirstTimer(repo);
  });
  test(
      'should call the [OnBoardingRepo.cacheFirstTimer] and return the right data ',
      () async {
    when(() => repo.cacheFirstTimer()).thenAnswer((_) async => Left(
        ServerFailure(messages: 'Unknown Error Occurred', statusCode: 500)));
    final result = await useCase();
    expect(
        result,
        equals(Left<Failure, dynamic>(ServerFailure(
            messages: 'Unknown Error Occurred', statusCode: 500))));
    verify(() => repo.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
