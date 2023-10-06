import 'package:education_app/core/utils/typdefs.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();

  RsultFuture<void> cacheFirstTimer();

  RsultFuture<bool> checkIfUserIsFirstTimer();
}
