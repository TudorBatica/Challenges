import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/new_challenge/new_challenge_cubit.dart';
import '../common/button_with_border.dart';

// ignore_for_file: public_member_api_docs

class ImageSelectionInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChallengeCubit, NewChallengeState>(
      buildWhen: (previous, current) =>
          previous.image.value.first != current.image.value.first ||
          previous.image.value.second != current.image.value.second,
      builder: (context, state) {
        // this horrible section is due to sound null safety
        final Widget? _containerChild;
        final imgBytes = state.image.value.first;

        if (imgBytes != null) {
          final img = imgBytes;
          _containerChild = Image.memory(img);
        } else {
          _containerChild = Container(
            height: 0.0,
          );
        }

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (state.image.value.second) ?? 'No image selected',
                style: Theme.of(context).textTheme.caption,
              ),
              Container(
                constraints: BoxConstraints(maxHeight: 300, minHeight: 0.0),
                child: _containerChild,
              ),
              SizedBox(height: 10.0),
              ButtonWithBorder(
                text: (state.image.value.first == null)
                    ? 'SELECT IMAGE'
                    : 'CHANGE IMAGE',
                borderColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryColor,
                onPressed: () async =>
                    await context.read<NewChallengeCubit>().selectFile(),
              ),
            ],
          ),
        );
      },
    );
  }
}
