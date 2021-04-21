// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/authentication/sign_in_cubit.dart' as _i8;
import 'application/authentication/sign_up_cubit.dart' as _i9;
import 'application/common/app_cubit.dart' as _i10;
import 'application/navigation/navigation_service.dart' as _i4;
import 'application/navigation/navigation_service_impl.dart' as _i5;
import 'domain/authentication/authentication_repository.dart' as _i6;
import 'infrastructure/authentication/firebase_auth_repository.dart' as _i7;
import 'infrastructure/authentication/firebase_injectable_module.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.NavigationService>(() => _i5.NavigationServiceImpl());
  gh.lazySingleton<_i6.AuthenticationRepository>(
      () => _i7.FirebaseAuthRepository(get<_i3.FirebaseAuth>()));
  gh.factory<_i8.SignInCubit>(
      () => _i8.SignInCubit(get<_i6.AuthenticationRepository>()));
  gh.factory<_i9.SignUpCubit>(
      () => _i9.SignUpCubit(get<_i6.AuthenticationRepository>()));
  gh.factory<_i10.AppCubit>(
      () => _i10.AppCubit(get<_i6.AuthenticationRepository>()));
  return get;
}

class _$FirebaseInjectableModule extends _i11.FirebaseInjectableModule {}
