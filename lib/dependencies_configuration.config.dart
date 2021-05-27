// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/authentication/sign_in_cubit.dart' as _i24;
import 'application/authentication/sign_up_cubit.dart' as _i25;
import 'application/common/app_cubit.dart' as _i26;
import 'application/navigation/navigation_service.dart' as _i13;
import 'application/navigation/navigation_service_impl.dart' as _i14;
import 'application/new_challenge/new_challenge_cubit.dart' as _i29;
import 'domain/authentication/authentication_repository.dart' as _i17;
import 'domain/challenge/challenge_info.dart' as _i7;
import 'domain/challenge/challenge_info_serializer.dart' as _i8;
import 'domain/challenge/challenge_repository.dart' as _i27;
import 'domain/challenge/challenge_storage_repository.dart' as _i19;
import 'domain/challenge/challenge_task.dart' as _i9;
import 'domain/challenge/challenge_task_serializer.dart' as _i10;
import 'domain/common/json_serializer.dart' as _i6;
import 'domain/profile/profile_repository.dart' as _i15;
import 'domain/profile/user_profile.dart' as _i11;
import 'domain/profile/user_profile_serializer.dart' as _i12;
import 'infrastructure/authentication/firebase_auth_repository.dart' as _i18;
import 'infrastructure/challenge/firebase_challenge_storage_repository.dart'
    as _i20;
import 'infrastructure/challenge/firestore_challenge_info_repository.dart'
    as _i22;
import 'infrastructure/challenge/firestore_challenge_repository.dart' as _i28;
import 'infrastructure/challenge/firestore_challenge_task_repository.dart'
    as _i23;
import 'infrastructure/common/firebase_injectable_module.dart' as _i30;
import 'infrastructure/common/firestore_crud_repository.dart' as _i21;
import 'infrastructure/profile/firestore_profile_repository.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i5.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i6.JsonSerializer<_i7.ChallengeInfo>>(
      () => _i8.ChallengeInfoSerializer());
  gh.factory<_i6.JsonSerializer<_i9.ChallengeTask>>(
      () => _i10.ChallengeTaskSerializer());
  gh.factory<_i6.JsonSerializer<_i11.UserProfile>>(
      () => _i12.UserProfileSerializer());
  gh.lazySingleton<_i13.NavigationService>(() => _i14.NavigationServiceImpl());
  gh.lazySingleton<_i15.ProfileRepository>(() =>
      _i16.FirestoreProfileRepository(get<_i4.FirebaseFirestore>(),
          get<_i6.JsonSerializer<_i11.UserProfile>>()));
  gh.lazySingleton<_i17.AuthenticationRepository>(() =>
      _i18.FirebaseAuthRepository(
          get<_i3.FirebaseAuth>(), get<_i15.ProfileRepository>()));
  gh.lazySingleton<_i19.ChallengeStorageRepository>(() =>
      _i20.FirebaseChallengeStorageRepository(get<_i5.FirebaseStorage>()));
  gh.lazySingleton<_i21.FirestoreCrudRepository<_i7.ChallengeInfo>>(() =>
      _i22.FirestoreChallengeInfoRepository(get<_i4.FirebaseFirestore>(),
          get<_i6.JsonSerializer<_i7.ChallengeInfo>>()));
  gh.lazySingleton<_i21.FirestoreCrudRepository<_i9.ChallengeTask>>(() =>
      _i23.FirestoreChallengeTaskRepository(get<_i4.FirebaseFirestore>(),
          get<_i6.JsonSerializer<_i9.ChallengeTask>>()));
  gh.factory<_i24.SignInCubit>(() => _i24.SignInCubit(
      get<_i17.AuthenticationRepository>(), get<_i13.NavigationService>()));
  gh.factory<_i25.SignUpCubit>(() => _i25.SignUpCubit(
      get<_i17.AuthenticationRepository>(), get<_i13.NavigationService>()));
  gh.factory<_i26.AppCubit>(
      () => _i26.AppCubit(get<_i17.AuthenticationRepository>()));
  gh.lazySingleton<_i27.ChallengeRepository>(() =>
      _i28.FirestoreChallengeRepository(
          get<_i21.FirestoreCrudRepository<_i7.ChallengeInfo>>(),
          get<_i21.FirestoreCrudRepository<_i9.ChallengeTask>>()));
  gh.factory<_i29.NewChallengeCubit>(() => _i29.NewChallengeCubit(
      get<_i27.ChallengeRepository>(),
      get<_i19.ChallengeStorageRepository>(),
      get<_i13.NavigationService>()));
  return get;
}

class _$FirebaseInjectableModule extends _i30.FirebaseInjectableModule {}
