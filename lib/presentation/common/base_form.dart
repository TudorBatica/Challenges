import 'package:flutter/material.dart';

/// Shapes the form used throughout the app.
class BaseForm extends StatelessWidget {
  /// Form's widgets(inputs, headers, button, etc.)
  final List<Widget> elements;

  // ignore: public_member_api_docs
  const BaseForm({Key? key, required this.elements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 900,
        maxHeight: MediaQuery.of(context).size.height * 0.80,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: elements,
            ),
          ),
        ),
      ),
    );
  }
}
