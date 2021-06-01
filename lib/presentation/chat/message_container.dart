import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class MessageContainer extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final AlignmentGeometry alignment;

  final String senderName;
  final DateTime createdAt;
  final String content;

  const MessageContainer(
      {Key? key,
      required this.backgroundColor,
      required this.textColor,
      required this.alignment,
      required this.senderName,
      required this.createdAt,
      required this.content})
      : super(key: key);

  /// Recommended colors palette and alignment for messages from current user
  factory MessageContainer.messageFromCurrentUser(
          {required String senderName,
          required DateTime createdAt,
          required String content}) =>
      MessageContainer(
        backgroundColor: Colors.white,
        textColor: Colors.black,
        alignment: Alignment.topRight,
        senderName: senderName,
        createdAt: createdAt,
        content: content,
      );

  /// Recommended colors palette and alignment for messages from other users
  factory MessageContainer.messageFromOtherUser(
          {required String senderName,
          required DateTime createdAt,
          required String content}) =>
      MessageContainer(
        backgroundColor: Color.fromRGBO(31, 29, 43, 1),
        textColor: Color.fromRGBO(241, 241, 241, 1),
        alignment: Alignment.topLeft,
        senderName: senderName,
        createdAt: createdAt,
        content: content,
      );

  @override
  Widget build(BuildContext context) {
    final headerColor =
        Color.fromRGBO(textColor.red, textColor.green, textColor.blue, 0.7);
    final dividerColor =
        Color.fromRGBO(textColor.red, textColor.green, textColor.blue, 0.5);
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$senderName   •   ${Jiffy(createdAt).fromNow()}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: headerColor)),
                Divider(
                  color: dividerColor,
                  height: 0.01,
                ),
                SizedBox(height: 10.0),
                Text(
                  content,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: textColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
