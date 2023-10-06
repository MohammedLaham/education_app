import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_datasources.dart';
import 'package:education_app/src/on_boarding/data/repos/on_bording_repo_impl.dart';
import 'package:education_app/src/on_boarding/domain/repo/on_bording_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cahce_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  // Feature --> OnBoarding
  //Business Logic
  sl
    ..registerFactory(
      () =>
          OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserIsFirstTimer: sl()),
    )
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
        () => OnBoardingLocalDataSrcImpl(sl()),)
    ..registerLazySingleton(() => prefs);
}
