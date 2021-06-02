// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_messaging/firebase_messaging.dart' as _i5;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/authentication/sign_in_cubit.dart' as _i34;
import 'application/authentication/sign_up_cubit.dart' as _i35;
import 'application/challenges_list/challenges_list_cubit.dart' as _i38;
import 'application/chat/chat_cubit.dart' as _i39;
import 'application/new_challenge/new_challenge_cubit.dart' as _i40;
import 'application/new_team/new_team_cubit.dart' as _i33;
import 'domain/authentication/authentication_repository.dart' as _i24;
import 'domain/challenge/challenge_info.dart' as _i8;
import 'domain/challenge/challenge_info_serializer.dart' as _i9;
import 'domain/challenge/challenge_repository.dart' as _i36;
import 'domain/challenge/challenge_storage_repository.dart' as _i26;
import 'domain/challenge/challenge_task.dart' as _i10;
import 'domain/challenge/challenge_task_serializer.dart' as _i11;
import 'domain/chat/chat_repository.dart' as _i28;
import 'domain/chat/message.dart' as _i12;
import 'domain/chat/message_serializer.dart' as _i13;
import 'domain/common/json_serializer.dart' as _i7;
import 'domain/profile/profile_repository.dart' as _i20;
import 'domain/profile/user_profile.dart' as _i14;
import 'domain/profile/user_profile_serializer.dart' as _i15;
import 'domain/teams/team.dart' as _i18;
import 'domain/teams/team_basic_info.dart' as _i16;
import 'domain/teams/team_basic_info_serializer.dart' as _i17;
import 'domain/teams/team_repository.dart' as _i22;
import 'domain/teams/team_serializer.dart' as _i19;
import 'infrastructure/authentication/firebase_auth_repository.dart' as _i25;
import 'infrastructure/challenge/firebase_challenge_storage_repository.dart'
    as _i27;
import 'infrastructure/challenge/firestore_challenge_info_repository.dart'
    as _i31;
import 'infrastructure/challenge/firestore_challenge_repository.dart' as _i37;
import 'infrastructure/challenge/firestore_challenge_task_repository.dart'
    as _i32;
import 'infrastructure/chat/firestore_chat_repository.dart' as _i29;
import 'infrastructure/common/firebase_injectable_module.dart' as _i41;
import 'infrastructure/common/firestore_crud_repository.dart' as _i30;
import 'infrastructure/profile/firestore_profile_repository.dart' as _i21;
import 'infrastructure/teams/firestore_team_repository.dart'
    as _i23; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i5.FirebaseMessaging>(
      () => firebaseInjectableModule.firebaseMessaging);
  gh.lazySingleton<_i6.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.factory<_i7.JsonSerializer<_i8.ChallengeInfo>>(
      () => _i9.ChallengeInfoSerializer());
  gh.factory<_i7.JsonSerializer<_i10.ChallengeTask>>(
      () => _i11.ChallengeTaskSerializer());
  gh.factory<_i7.JsonSerializer<_i12.Message>>(() => _i13.MessageSerializer());
  gh.factory<_i7.JsonSerializer<_i14.UserProfile>>(
      () => _i15.UserProfileSerializer());
  gh.factory<_i7.JsonSerializer<_i16.TeamBasicInfo>>(
      () => _i17.TeamBasicInfoSerializer());
  gh.factory<_i7.JsonSerializer<_i18.Team>>(() => _i19.TeamSerializer());
  gh.lazySingleton<_i20.ProfileRepository>(() =>
      _i21.FirestoreProfileRepository(get<_i4.FirebaseFirestore>(),
          get<_i7.JsonSerializer<_i14.UserProfile>>()));
  gh.lazySingleton<_i22.TeamRepository>(() => _i23.FirestoreTeamRepository(
      get<_i4.FirebaseFirestore>(), get<_i7.JsonSerializer<_i18.Team>>()));
  gh.lazySingleton<_i24.AuthenticationRepository>(() =>
      _i25.FirebaseAuthRepository(
          get<_i3.FirebaseAuth>(), get<_i20.ProfileRepository>()));
  gh.lazySingleton<_i26.ChallengeStorageRepository>(() =>
      _i27.FirebaseChallengeStorageRepository(get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i28.ChatRepository>(() => _i29.FirestoreChatRepository(
      get<_i7.JsonSerializer<_i12.Message>>(), get<_i4.FirebaseFirestore>()));
  gh.lazySingleton<_i30.FirestoreCrudRepository<_i8.ChallengeInfo>>(() =>
      _i31.FirestoreChallengeInfoRepository(get<_i4.FirebaseFirestore>(),
          get<_i7.JsonSerializer<_i8.ChallengeInfo>>()));
  gh.lazySingleton<_i30.FirestoreCrudRepository<_i10.ChallengeTask>>(() =>
      _i32.FirestoreChallengeTaskRepository(get<_i4.FirebaseFirestore>(),
          get<_i7.JsonSerializer<_i10.ChallengeTask>>()));
  gh.factory<_i33.NewTeamCubit>(() => _i33.NewTeamCubit(
      get<_i20.ProfileRepository>(), get<_i22.TeamRepository>()));
  gh.factory<_i34.SignInCubit>(
      () => _i34.SignInCubit(get<_i24.AuthenticationRepository>()));
  gh.factory<_i35.SignUpCubit>(
      () => _i35.SignUpCubit(get<_i24.AuthenticationRepository>()));
  gh.lazySingleton<_i36.ChallengeRepository>(() =>
      _i37.FirestoreChallengeRepository(
          get<_i30.FirestoreCrudRepository<_i8.ChallengeInfo>>(),
          get<_i30.FirestoreCrudRepository<_i10.ChallengeTask>>()));
  gh.factory<_i38.ChallengesListCubit>(
      () => _i38.ChallengesListCubit(get<_i36.ChallengeRepository>()));
  gh.factory<_i39.ChatCubit>(() => _i39.ChatCubit(get<_i28.ChatRepository>(),
      get<_i22.TeamRepository>(), get<String>(), get<String>()));
  gh.factory<_i40.NewChallengeCubit>(() => _i40.NewChallengeCubit(
      get<_i36.ChallengeRepository>(), get<_i26.ChallengeStorageRepository>()));
  return get;
}

class _$FirebaseInjectableModule extends _i41.FirebaseInjectableModule {}
