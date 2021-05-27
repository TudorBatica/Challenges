import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/challenge/challenge_repository.dart';
import 'challenges_list_state.dart';

/// Manages the challenges list state
@injectable
class ChallengesListCubit extends Cubit<ChallengesListState> {
  final ChallengeRepository _challengeRepository;

  ChallengesListCubit(this._challengeRepository)
      : super(const ChallengesListState()) {
    retrieveChallengeInfos();
  }

  Future<void> retrieveChallengeInfos() async {
    final challenges = await _challengeRepository.getAllChallengeInfos();
    emit(state.copyWith(challenges: challenges));
  }
}
