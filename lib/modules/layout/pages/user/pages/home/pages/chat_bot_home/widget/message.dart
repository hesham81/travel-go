import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';

class Message extends StatefulWidget {
  final String message;
  final bool isSender;

  const Message({
    super.key,
    required this.message,
    this.isSender = true,
  });

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment:
          (widget.isSender) ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          (widget.isSender) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          height: 0.04.height,
          padding: EdgeInsets.symmetric(
            vertical: 0.01.height,
            horizontal: 0.02.width,
          ),
          decoration: BoxDecoration(
            color: AppColors.newBlueColor,
            borderRadius: BorderRadius.only(
              topRight:
                  (!widget.isSender) ? Radius.circular(20) : Radius.circular(0),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topLeft:
                  (!widget.isSender) ? Radius.circular(0) : Radius.circular(20),
            ),
          ),
          child: Text(
            widget.message,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
