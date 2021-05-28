import 'package:challengesapp/presentation/common/scaffold_with_background.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatelessWidget {
  /// Challenge id
  final String id;

  // ignore: public_member_api_docs
  ChallengePage(this.id);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(child: Container(child: Text(id.toString())));
  }
}
