part of 'challenge_cubit.dart';

/// Models the data required to build
/// a challenge details page
@immutable
class ChallengeState extends Equatable {
  /// Challenge does not exist in the db
  final bool notFound;

  /// The challenge model.
  /// [ChallengeTask] will be if it should not be displayed
  /// yet to the user.
  final Challenge? challenge;

  /// Whether the page should display a solution submission section
  final bool shouldDisplaySubmitSection;

  /// Whether the page should display a section where
  /// teams can register
  final bool shouldDisplayRegistrationSection;

  /// Team registration input value
  final String? registrationInput;

  /// Registration form status
  final FormzStatus registrationStatus;

  // ignore: public_member_api_docs
  const ChallengeState(
      {this.notFound = false,
      this.shouldDisplayRegistrationSection = false,
      this.shouldDisplaySubmitSection = false,
      this.challenge,
      this.registrationStatus = FormzStatus.invalid,
      this.registrationInput});

  @override
  List<Object?> get props => [
        notFound,
        challenge,
        shouldDisplayRegistrationSection,
        shouldDisplaySubmitSection,
        registrationStatus,
        registrationInput
      ];

  // ignore: public_member_api_docs
  ChallengeState copyWith({
    bool? notFound,
    Challenge? challenge,
    bool? shouldDisplaySubmitSection,
    bool? shouldDisplayRegistrationSection,
    FormzStatus? registrationStatus,
    String? registrationInput,
  }) {
    return ChallengeState(
      notFound: notFound ?? this.notFound,
      challenge: challenge ?? this.challenge,
      shouldDisplaySubmitSection:
          shouldDisplaySubmitSection ?? this.shouldDisplaySubmitSection,
      shouldDisplayRegistrationSection: shouldDisplayRegistrationSection ??
          this.shouldDisplayRegistrationSection,
      registrationStatus: registrationStatus ?? this.registrationStatus,
      registrationInput: registrationInput ?? this.registrationInput,
    );
  }
}
