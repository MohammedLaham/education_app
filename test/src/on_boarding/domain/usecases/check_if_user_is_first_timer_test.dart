import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failurs.dart';
import 'package:education_app/src/on_boarding/domain/repo/on_bording_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cahce_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'on_boarding_repo.mock.dart';

void main() {
  late MockOnBoardingRepo repo;
  late CheckIfUserIsFirstTimer useCase;
  setUp(() {
    repo = MockOnBoardingRepo();
    useCase = CheckIfUserIsFirstTimer(repo);
  });
  test('should get a response from the [MockOnBoardingRepo]', () async {
    when(() => repo.checkIfUserIsFirstTimer())
        .thenAnswer((_) async => const Right(true));
    final result = await useCase();
    expect(
        result,
        equals(const Right<dynamic,bool>(true)));
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
