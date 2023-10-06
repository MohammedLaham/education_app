import 'package:education_app/core/enumns/update_user.dart';
import 'package:education_app/core/utils/typdefs.dart';
import 'package:education_app/src/auth/domain/entites/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  RsultFuture<UserLocal> signIn({
    required String email,
    required String password,
  });

  RsultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  RsultFuture<void> forgetPassword(String email);

  RsultFuture<void> updateUser(
      {required UpdateUserAction action, dynamic userData,});
}
