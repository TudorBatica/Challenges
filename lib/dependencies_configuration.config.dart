// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/authentication/sign_in_cubit.dart' as _i29;
import 'application/authentication/sign_up_cubit.dart' as _i30;
import 'application/challenges_list/challenges_list_cubit.dart' as _i33;
import 'application/new_challenge/new_challenge_cubit.dart' as _i34;
import 'application/new_team/new_team_cubit.dart' as _i28;
import 'domain/authentication/authentication_repository.dart' as _i21;
import 'domain/challenge/challenge_info.dart' as _i7;
import 'domain/challenge/challenge_info_serializer.dart' as _i8;
import 'domain/challenge/challenge_repository.dart' as _i31;
import 'domain/challenge/challenge_storage_repository.dart' as _i23;
import 'domain/challenge/challenge_task.dart' as _i9;
import 'domain/challenge/challenge_task_serializer.dart' as _i10;
import 'domain/common/json_serializer.dart' as _i6;
import 'domain/profile/profile_repository.dart' as _i17;
import 'domain/profile/user_profile.dart' as _i11;
import 'domain/profile/user_profile_serializer.dart' as _i12;
import 'domain/teams/team.dart' as _i15;
import 'domain/teams/team_basic_info.dart' as _i13;
import 'domain/teams/team_basic_info_serializer.dart' as _i14;
import 'domain/teams/team_repository.dart' as _i19;
import 'domain/teams/team_serializer.dart' as _i16;
import 'infrastructure/authentication/firebase_auth_repository.dart' as _i22;
import 'infrastructure/challenge/firebase_challenge_storage_repository.dart'
    as _i24;
import 'infrastructure/challenge/firestore_challenge_info_repository.dart'
    as _i26;
import 'infrastructure/challenge/firestore_challenge_repository.dart' as _i32;
import 'infrastructure/challenge/firestore_challenge_task_repository.dart'
    as _i27;
import 'infrastructure/common/firebase_injectable_module.dart' as _i35;
import 'infrastructure/common/firestore_crud_repository.dart' as _i25;
import 'infrastructure/profile/firestore_profile_repository.dart' as _i18;
import 'infrastructure/teams/firestore_team_repository.dart'
    as _i20; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i6.JsonSerializer<_i13.TeamBasicInfo>>(
      () => _i14.TeamBasicInfoSerializer());
  gh.factory<_i6.JsonSerializer<_i15.Team>>(() => _i16.TeamSerializer());
  gh.lazySingleton<_i17.ProfileRepository>(() =>
      _i18.FirestoreProfileRepository(get<_i4.FirebaseFirestore>(),
          get<_i6.JsonSerializer<_i11.UserProfile>>()));
  gh.lazySingleton<_i19.TeamRepository>(() => _i20.FirestoreTeamRepository(
      get<_i4.FirebaseFirestore>(), get<_i6.JsonSerializer<_i15.Team>>()));
  gh.lazySingleton<_i21.AuthenticationRepository>(() =>
      _i22.FirebaseAuthRepository(
          get<_i3.FirebaseAuth>(), get<_i17.ProfileRepository>()));
  gh.lazySingleton<_i23.ChallengeStorageRepository>(() =>
      _i24.FirebaseChallengeStorageRepository(get<_i5.FirebaseStorage>()));
  gh.lazySingleton<_i25.FirestoreCrudRepository<_i7.ChallengeInfo>>(() =>
      _i26.FirestoreChallengeInfoRepository(get<_i4.FirebaseFirestore>(),
          get<_i6.JsonSerializer<_i7.ChallengeInfo>>()));
  gh.lazySingleton<_i25.FirestoreCrudRepository<_i9.ChallengeTask>>(() =>
      _i27.FirestoreChallengeTaskRepository(get<_i4.FirebaseFirestore>(),
          get<_i6.JsonSerializer<_i9.ChallengeTask>>()));
  gh.factory<_i28.NewTeamCubit>(() => _i28.NewTeamCubit(
      get<_i17.ProfileRepository>(), get<_i19.TeamRepository>()));
  gh.factory<_i29.SignInCubit>(
      () => _i29.SignInCubit(get<_i21.AuthenticationRepository>()));
  gh.factory<_i30.SignUpCubit>(
      () => _i30.SignUpCubit(get<_i21.AuthenticationRepository>()));
  gh.lazySingleton<_i31.ChallengeRepository>(() =>
      _i32.FirestoreChallengeRepository(
          get<_i25.FirestoreCrudRepository<_i7.ChallengeInfo>>(),
          get<_i25.FirestoreCrudRepository<_i9.ChallengeTask>>()));
  gh.factory<_i33.ChallengesListCubit>(
      () => _i33.ChallengesListCubit(get<_i31.ChallengeRepository>()));
  gh.factory<_i34.NewChallengeCubit>(() => _i34.NewChallengeCubit(
      get<_i31.ChallengeRepository>(), get<_i23.ChallengeStorageRepository>()));
  return get;
}

class _$FirebaseInjectableModule extends _i35.FirebaseInjectableModule {}
