import 'package:flutter/material.dart';

class ChallengeDetailSection extends StatelessWidget {
  final double width;
  final Widget leading;
  final Widget title;
  final Widget content;

  const ChallengeDetailSection(
      {Key? key,
      required this.width,
      required this.leading,
      required this.title,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leading,
            SizedBox(height: 12.5),
            title,
            SizedBox(height: 20.0),
            content
          ],
        ),
      ),
    );
  }
}
