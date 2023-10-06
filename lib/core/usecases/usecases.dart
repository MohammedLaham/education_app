import 'package:education_app/core/utils/typdefs.dart';

abstract class UsecaseWithParams<Type,Params>{
  const UsecaseWithParams();
  RsultFuture<Type> call(Params params);
}
abstract class UsecaseWithoutParams<Type>{
  const UsecaseWithoutParams();
  RsultFuture<Type> call();
}
