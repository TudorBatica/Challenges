// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/authentication/sign_in_cubit.dart' as _i21;
import 'application/authentication/sign_up_cubit.dart' as _i22;
import 'application/common/app_cubit.dart' as _i23;
import 'application/navigation/navigation_service.dart' as _i12;
import 'application/navigation/navigation_service_impl.dart' as _i13;
import 'application/new_challenge/new_challenge_cubit.dart' as _i26;
import 'domain/authentication/authentication_repository.dart' as _i16;
import 'domain/challenge/challenge_info.dart' as _i8;
import 'domain/challenge/challenge_info_serializer.dart' as _i9;
import 'domain/challenge/challenge_repository.dart' as _i24;
import 'domain/challenge/challenge_task.dart' as _i10;
import 'domain/challenge/challenge_task_serializer.dart' as _i11;
import 'domain/common/json_serializer.dart' as _i5;
import 'domain/profile/profile_repository.dart' as _i14;
import 'domain/profile/user_profile.dart' as _i6;
import 'domain/profile/user_profile_serializer.dart' as _i7;
import 'infrastructure/authentication/firebase_auth_repository.dart' as _i17;
import 'infrastructure/challenge/firestore_challenge_info_repository.dart'
    as _i19;
import 'infrastructure/challenge/firestore_challenge_repository.dart' as _i25;
import 'infrastructure/challenge/firestore_challenge_task_repository.dart'
    as _i20;
import 'infrastructure/common/firebase_injectable_module.dart' as _i27;
import 'infrastructure/common/firestore_crud_repository.dart' as _i18;
import 'infrastructure/profile/firestore_profile_repository.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i5.JsonSerializer<_i8.ChallengeInfo>>(
      () => _i9.ChallengeInfoSerializer());
  gh.factory<_i5.JsonSerializer<_i10.ChallengeTask>>(
      () => _i11.ChallengeTaskSerializer());
  gh.lazySingleton<_i12.NavigationService>(() => _i13.NavigationServiceImpl());
  gh.lazySingleton<_i14.ProfileRepository>(() =>
      _i15.FirestoreProfileRepository(get<_i4.FirebaseFirestore>(),
          get<_i5.JsonSerializer<_i6.UserProfile>>()));
  gh.lazySingleton<_i16.AuthenticationRepository>(() =>
      _i17.FirebaseAuthRepository(
          get<_i3.FirebaseAuth>(), get<_i14.ProfileRepository>()));
  gh.lazySingleton<_i18.FirestoreCrudRepository<_i8.ChallengeInfo>>(() =>
      _i19.FirestoreChallengeInfoRepository(get<_i4.FirebaseFirestore>(),
          get<_i5.JsonSerializer<_i8.ChallengeInfo>>()));
  gh.lazySingleton<_i18.FirestoreCrudRepository<_i10.ChallengeTask>>(() =>
      _i20.FirestoreChallengeTaskRepository(get<_i4.FirebaseFirestore>(),
          get<_i5.JsonSerializer<_i10.ChallengeTask>>()));
  gh.factory<_i21.SignInCubit>(
      () => _i21.SignInCubit(get<_i16.AuthenticationRepository>()));
  gh.factory<_i22.SignUpCubit>(
      () => _i22.SignUpCubit(get<_i16.AuthenticationRepository>()));
  gh.factory<_i23.AppCubit>(
      () => _i23.AppCubit(get<_i16.AuthenticationRepository>()));
  gh.lazySingleton<_i24.ChallengeRepository>(() =>
      _i25.FirestoreChallengeRepository(
          get<_i18.FirestoreCrudRepository<_i8.ChallengeInfo>>(),
          get<_i18.FirestoreCrudRepository<_i10.ChallengeTask>>()));
  gh.factory<_i26.NewChallengeCubit>(
      () => _i26.NewChallengeCubit(get<_i24.ChallengeRepository>()));
  return get;
}

class _$FirebaseInjectableModule extends _i27.FirebaseInjectableModule {}
