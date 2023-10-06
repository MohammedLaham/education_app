import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typdefs.dart';
import 'package:education_app/src/auth/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  final AuthRepo _repo;

  const SignUp(this._repo);

  @override
  RsultFuture<void> call(SignUpParams params) => _repo.signUp(
      email: params.email,
      fullName: params.fullName,
      password: params.password);
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParams.empty() : this(email: '', password: '', fullName: '');
  final String email;
  final String fullName;
  final String password;

  @override
  List<String> get props => [email, password, fullName];
}
