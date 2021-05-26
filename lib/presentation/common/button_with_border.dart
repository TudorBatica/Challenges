import 'package:flutter/material.dart';

/// The bordered button used throughout the app
class ButtonWithBorder extends StatelessWidget {
  /// Function which executes when the button is tapped.
  /// If null it makes the button untappable.
  final void Function()? onPressed;

  /// Displayed text.
  final String text;

  // ignore: public_member_api_docs
  const ButtonWithBorder({Key? key, this.onPressed, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.only(
            left: 30.0,
            right: 30.0,
            top: 17.5,
            bottom: 17.5,
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .button!
            .copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
