import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failurs.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cahce_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnBoardingCubit onBoardingCubit;
  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    onBoardingCubit = OnBoardingCubit(
        cacheFirstTimer: cacheFirstTimer,
        checkIfUserIsFirstTimer: checkIfUserIsFirstTimer);
  });
  final tFauiler =
      CacheFailure(messages: 'Insufficient Permissions', statusCode: 4032);
  test('initial state should be [OnBoardingInitial]', () {
    expect(onBoardingCubit.state, const OnBoardingInitial());
  });
  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit [CachingFirstTimer, UserCached] when successful',
        build: () {
          when(() => cacheFirstTimer())
              .thenAnswer((_) async => const Right(null));
          return onBoardingCubit;
        },
        act: (onBoardingCubit) => onBoardingCubit.cachedFirstTimer(),
        expect: () => const [CachingFirstTimer(), UserCached()],
        verify: (_) {
          verify(() => cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        });
    blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit [CachingFirstTimer, OnBoardingError] when unsuccessful',
        build: () {
          when(() => cacheFirstTimer()).thenAnswer((_) async => Left(tFauiler));
          return onBoardingCubit;
        },
        act: (onBoardingCubit) => onBoardingCubit.cachedFirstTimer(),
        expect: () =>
            [const CachingFirstTimer(), OnBoardingError(tFauiler.errorMessage)],
        verify: (_) {
          verify(() => cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        });
  });
  group('checkIfUserIsFirstTime', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit [CheckingIfUserIsFirstTimer,OnBoardingStatus] when successful',
        build: () {
          when(() => checkIfUserIsFirstTimer())
              .thenAnswer((_) async => const Right(false));
          return onBoardingCubit;
        },
        act: (onBoardingCubit) => onBoardingCubit.checkedIfUserIsFirstTimer(),
        expect: () => const [
              CheckingIfUserIsFirstTimer(),
              OnBoardingStatus(isFirstTimer: false)
            ],
        verify: (_) {
          verify(() => checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(checkIfUserIsFirstTimer);
        });
    blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit [CheckingIfUserIsFirstTimer,OnBoardingStatus(true)] when unsuccessful',
        build: () {
          when(() => checkIfUserIsFirstTimer())
              .thenAnswer((_) async => Left(tFauiler));
          return onBoardingCubit;
        },
        act: (onBoardingCubit) => onBoardingCubit.checkedIfUserIsFirstTimer(),
        expect: () =>const [
               CheckingIfUserIsFirstTimer(),
              OnBoardingStatus(isFirstTimer: true)
            ],
        verify: (_) {
          verify(() => checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(checkIfUserIsFirstTimer);
        });
  });
}
