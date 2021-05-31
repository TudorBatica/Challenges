import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'members_input.dart';
import 'team_name_input.dart';

part 'new_team_state.dart';

/// Manages the new team form state
class NewTeamCubit extends Cubit<NewTeamState> {
  // ignore: public_member_api_docs
  NewTeamCubit() : super(NewTeamState.intial());
}
