import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typdefs.dart';
import 'package:education_app/src/on_boarding/domain/repo/on_bording_repo.dart';

class CacheFirstTimer extends UsecaseWithoutParams<void>{
  const CacheFirstTimer(this._repo);
  final OnBoardingRepo _repo;
  @override
  RsultFuture<void> call() async => _repo.cacheFirstTimer();
}