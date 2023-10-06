import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exception.dart';
import 'package:education_app/core/errors/failurs.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_datasources.dart';
import 'package:education_app/src/on_boarding/data/repos/on_bording_repo_impl.dart';
import 'package:education_app/src/on_boarding/domain/repo/on_bording_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cahce_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImpl repoImpl;
  setUp(() {
    localDataSource = MockOnBoardingLocalDataSrc();
    repoImpl = OnBoardingRepoImpl(localDataSource);
  });
  test('should be a subclass of [onBoardingRepo]', () {
    expect(repoImpl, isA<OnBoardingRepo>());
  });
  group('cacheFirstTimer', () {
    // ignore: lines_longer_than_80_chars
    test('should complete successfully when call to local source is successful',
        () async {
      // ignore: lines_longer_than_80_chars
      when(() => localDataSource.cacheFirstTimer())
          .thenAnswer((_) async => Future.value());
      final result = await repoImpl.cacheFirstTimer();
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => localDataSource.cacheFirstTimer());
      verifyNoMoreInteractions(localDataSource);
    });
    // ignore: lines_longer_than_80_chars
    test(
        'should return [CacheFailure] when call to local source is unsuccessful',
        () async {
      // ignore: lines_longer_than_80_chars
      when(() => localDataSource.cacheFirstTimer())
          .thenThrow(const CacheException(message: 'Insufficient storage'));
      final result = await repoImpl.cacheFirstTimer();
      expect(
        result,
        Left<CacheFailure, dynamic>(
          CacheFailure(
            messages: 'Insufficient storage',
            statusCode: 500,
          ),
        ),
      );
      verify(() => localDataSource.cacheFirstTimer());
      verifyNoMoreInteractions(localDataSource);
    });
  });
  group('CheckIfUserIsFirstTimer', () {
    test('should return true when user is first timer', () async {
      when(() => localDataSource.checkIfUserIsFirstTimer())
          .thenAnswer((_) async => Future.value(true));
      final result = await repoImpl.checkIfUserIsFirstTimer();
      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
    test('should return false when user is not first timer', () async {
      when(() => localDataSource.checkIfUserIsFirstTimer())
          .thenAnswer((_) async => Future.value(false));
      final result = await repoImpl.checkIfUserIsFirstTimer();
      expect(result, equals(const Right<dynamic, bool>(false)));
      verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
    test(
        'should return a CacheFailure when call to local data source is unsuccessful',
        () async {
      when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
          const CacheException(
              message: 'Insufficient permission', statusCode: 403));
      final result = await repoImpl.checkIfUserIsFirstTimer();
      expect(
          result,
          equals(Left<CacheFailure, bool>(CacheFailure(
              messages: 'Insufficient permission', statusCode: 403))));
      verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
