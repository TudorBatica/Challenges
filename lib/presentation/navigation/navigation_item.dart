import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/common/app_cubit.dart';
import '../common/button_with_border.dart';

/// The actual navigation item.
class NavigationItem extends StatelessWidget {
  /// Text to display
  final String name;

  /// Navigation path
  final String navigationPath;

  /// Background color
  final Color? color;

  // ignore: public_member_api_docs
  final Color borderColor;

  // ignore: public_member_api_docs
  final Color textColor;

  /// Constructor
  const NavigationItem(
      {Key? key,
      required this.name,
      required this.navigationPath,
      this.color,
      required this.borderColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return ButtonWithBorder(
          onPressed: () => context.read<AppCubit>().navigateTo(navigationPath),
          text: name,
          borderColor: borderColor,
          textColor: textColor,
          backgroundColor: color,
        );
      },
    );
  }
}
