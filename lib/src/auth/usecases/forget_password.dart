import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typdefs.dart';
import 'package:education_app/src/auth/repos/auth_repo.dart';

class ForgetPassword extends UsecaseWithParams<void, String> {
  const ForgetPassword(this._repo);

  final AuthRepo _repo;

  @override
  RsultFuture<void> call(String params) => _repo.forgetPassword(params);
 }
