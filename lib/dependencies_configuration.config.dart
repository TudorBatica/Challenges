// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/authentication/sign_in_cubit.dart' as _i14;
import 'application/authentication/sign_up_cubit.dart' as _i15;
import 'application/common/app_cubit.dart' as _i16;
import 'application/navigation/navigation_service.dart' as _i8;
import 'application/navigation/navigation_service_impl.dart' as _i9;
import 'domain/authentication/authentication_repository.dart' as _i12;
import 'domain/common/json_serializer.dart' as _i5;
import 'domain/profile/profile_repository.dart' as _i10;
import 'domain/profile/user_profile.dart' as _i6;
import 'domain/profile/user_profile_serializer.dart' as _i7;
import 'infrastructure/authentication/firebase_auth_repository.dart' as _i13;
import 'infrastructure/common/firebase_injectable_module.dart' as _i17;
import 'infrastructure/profile/firestore_profile_repository.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseInjectableModule.firebaseFirestore);
  gh.factory<_i5.JsonSerializer<_i6.UserProfile>>(
      () => _i7.UserProfileSerializer());
  gh.lazySingleton<_i8.NavigationService>(() => _i9.NavigationServiceImpl());
  gh.lazySingleton<_i10.ProfileRepository>(() =>
      _i11.FirestoreProfileRepository(get<_i4.FirebaseFirestore>(),
          get<_i5.JsonSerializer<_i6.UserProfile>>()));
  gh.lazySingleton<_i12.AuthenticationRepository>(() =>
      _i13.FirebaseAuthRepository(
          get<_i3.FirebaseAuth>(), get<_i10.ProfileRepository>()));
  gh.factory<_i14.SignInCubit>(
      () => _i14.SignInCubit(get<_i12.AuthenticationRepository>()));
  gh.factory<_i15.SignUpCubit>(
      () => _i15.SignUpCubit(get<_i12.AuthenticationRepository>()));
  gh.factory<_i16.AppCubit>(
      () => _i16.AppCubit(get<_i12.AuthenticationRepository>()));
  return get;
}

class _$FirebaseInjectableModule extends _i17.FirebaseInjectableModule {}
