import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typdefs.dart';
import 'package:education_app/src/auth/domain/entites/user.dart';
import 'package:education_app/src/auth/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UsecaseWithParams<UserLocal, SignInParams> {

  const SignIn(this._repo);
  final AuthRepo _repo;

  @override
  RsultFuture<UserLocal> call(SignInParams params) =>
      _repo.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : email = '',
        password = '';
  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}
