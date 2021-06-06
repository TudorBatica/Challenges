// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../application/challenge/challenge_cubit.dart';
import '../../domain/challenge/challenge_task.dart';
import '../common/button_with_border.dart';
import 'challenge_detail_section.dart';

/// Display a section of details for the challenge details page
class ChallengePresentationSection extends StatelessWidget {
  final double width;
  final String title;
  final String hostName;
  final String description;

  const ChallengePresentationSection(
      {Key? key,
      required this.title,
      required this.description,
      required this.hostName,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.description),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(title,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.black)),
          SelectableText('by $hostName',
              style: Theme.of(context).textTheme.headline6)
        ],
      ),
      content: SelectableText(description),
    );
  }
}

class TaskSection extends StatelessWidget {
  final double width;
  final ChallengeTask? task;

  const TaskSection({Key? key, required this.width, this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.lightbulb_outline),
      title: SelectableText('Your task',
          style: Theme.of(context).textTheme.headline5),
      content: (task == null)
          ? SelectableText('Task not yet available.')
          : SelectableText(task!.description),
    );
  }
}

class ScheduleSection extends StatelessWidget {
  final double width;
  final DateTime registration;
  final DateTime start;
  final DateTime solutions;

  const ScheduleSection(
      {Key? key,
      required this.width,
      required this.registration,
      required this.start,
      required this.solutions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.access_time),
      title: SelectableText('Schedule',
          style: Theme.of(context).textTheme.headline5),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText('Register until'),
          SelectableText(
            DateFormat('EEE, M/d/y').add_Hm().format(registration),
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 12.5),
          SelectableText('Challenge starts'),
          SelectableText(
            DateFormat('EEE, M/d/y').add_Hm().format(start),
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 12.5),
          SelectableText('Submit solutions until'),
          SelectableText(
            DateFormat('EEE, M/d/y').add_Hm().format(solutions),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

class TeamSizeSection extends StatelessWidget {
  final double width;
  final int minSize;
  final int maxSize;

  const TeamSizeSection(
      {Key? key,
      required this.width,
      required this.minSize,
      required this.maxSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.group),
      title: SelectableText('Team size',
          style: Theme.of(context).textTheme.headline5),
      content: SelectableText('Make teams of $minSize-$maxSize people'),
    );
  }
}

class PrizeSection extends StatelessWidget {
  final double width;
  final String prize;

  const PrizeSection({Key? key, required this.width, required this.prize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChallengeDetailSection(
      width: width,
      leading: Icon(Icons.monetization_on),
      title:
          SelectableText('Prize', style: Theme.of(context).textTheme.headline5),
      content: SelectableText(prize),
    );
  }
}

class RegistrationSection extends StatelessWidget {
  final double width;
  const RegistrationSection({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeCubit, ChallengeState>(
      builder: (context, state) {
        return ChallengeDetailSection(
          width: width,
          leading: Icon(Icons.assignment_ind),
          title: SelectableText(
            'Register for this challenge',
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (id) =>
                    context.read<ChallengeCubit>().registrationInputChanged(id),
                decoration: InputDecoration(
                  labelText: 'Team ID',
                  errorText: state.registrationStatus.isSubmissionFailure
                      ? 'We could not register this team.'
                          ' Check ID and try again.'
                      : null,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              state.registrationStatus.isSubmissionInProgress
                  ? CircularProgressIndicator()
                  : ButtonWithBorder(
                      text: 'ENTER CHALLENGE',
                      borderColor: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColor,
                      onPressed: state.registrationStatus.isSubmissionInProgress
                          ? null
                          : () => context.read<ChallengeCubit>().registerTeam(),
                    )
            ],
          ),
        );
      },
    );
  }
}

class RegisteredTeamsList extends StatelessWidget {
  final double width;

  const RegisteredTeamsList({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeCubit, ChallengeState>(
      builder: (context, state) {
        return ChallengeDetailSection(
          width: width,
          leading: Icon(Icons.people_alt),
          title: SelectableText('Registered teams',
              style: Theme.of(context).textTheme.headline5),
          content: Column(
            children: state.challenge!.information.registeredTeams
                    ?.map(
                      (team) => Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.group, color: Colors.black),
                                ),
                                TextSpan(
                                  text: '     ${team.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Colors.black,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        );
      },
    );
  }
}
