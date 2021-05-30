// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/authentication/sign_in_cubit.dart' as _i22;
import 'application/authentication/sign_up_cubit.dart' as _i23;
import 'application/challenges_list/challenges_list_cubit.dart' as _i26;
import 'application/new_challenge/new_challenge_cubit.dart' as _i27;
import 'domain/authentication/authentication_repository.dart' as _i15;
import 'domain/challenge/challenge_info.dart' as _i7;
import 'domain/challenge/challenge_info_serializer.dart' as _i8;
import 'domain/challenge/challenge_repository.dart' as _i24;
import 'domain/challenge/challenge_storage_repository.dart' as _i17;
import 'domain/challenge/challenge_task.dart' as _i9;
import 'domain/challenge/challenge_task_serializer.dart' as _i10;
import 'domain/common/json_serializer.dart' as _i6;
import 'domain/profile/profile_repository.dart' as _i13;
import 'domain/profile/user_profile.dart' as _i11;
import 'domain/profile/user_profile_serializer.dart' as _i12;
import 'infrastructure/authentication/firebase_auth_repository.dart' as _i16;
import 'infrastructure/challenge/firebase_challenge_storage_repository.dart'
    as _i18;
import 'infrastructure/challenge/firestore_challenge_info_repository.dart'
    as _i20;
import 'infrastructure/challenge/firestore_challenge_repository.dart' as _i25;
import 'infrastructure/challenge/firestore_challenge_task_repository.dart'
    as _i21;
import 'infrastructure/common/firebase_injectable_module.dart' as _i28;
import 'infrastructure/common/firestore_crud_repository.dart' as _i19;
import 'infrastructure/profile/firestore_profile_repository.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i13.ProfileRepository>(() =>
      _i14.FirestoreProfileRepository(get<_i4.FirebaseFirestore>(),
          get<_i6.JsonSerializer<_i11.UserProfile>>()));
  gh.lazySingleton<_i15.AuthenticationRepository>(() =>
      _i16.FirebaseAuthRepository(
          get<_i3.FirebaseAuth>(), get<_i13.ProfileRepository>()));
  gh.lazySingleton<_i17.ChallengeStorageRepository>(() =>
      _i18.FirebaseChallengeStorageRepository(get<_i5.FirebaseStorage>()));
  gh.lazySingleton<_i19.FirestoreCrudRepository<_i7.ChallengeInfo>>(() =>
      _i20.FirestoreChallengeInfoRepository(get<_i4.FirebaseFirestore>(),
          get<_i6.JsonSerializer<_i7.ChallengeInfo>>()));
  gh.lazySingleton<_i19.FirestoreCrudRepository<_i9.ChallengeTask>>(() =>
      _i21.FirestoreChallengeTaskRepository(get<_i4.FirebaseFirestore>(),
          get<_i6.JsonSerializer<_i9.ChallengeTask>>()));
  gh.factory<_i22.SignInCubit>(
      () => _i22.SignInCubit(get<_i15.AuthenticationRepository>()));
  gh.factory<_i23.SignUpCubit>(
      () => _i23.SignUpCubit(get<_i15.AuthenticationRepository>()));
  gh.lazySingleton<_i24.ChallengeRepository>(() =>
      _i25.FirestoreChallengeRepository(
          get<_i19.FirestoreCrudRepository<_i7.ChallengeInfo>>(),
          get<_i19.FirestoreCrudRepository<_i9.ChallengeTask>>()));
  gh.factory<_i26.ChallengesListCubit>(
      () => _i26.ChallengesListCubit(get<_i24.ChallengeRepository>()));
  gh.factory<_i27.NewChallengeCubit>(() => _i27.NewChallengeCubit(
      get<_i24.ChallengeRepository>(), get<_i17.ChallengeStorageRepository>()));
  return get;
}

class _$FirebaseInjectableModule extends _i28.FirebaseInjectableModule {}
