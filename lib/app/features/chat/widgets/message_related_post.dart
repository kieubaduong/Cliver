import 'package:cliver_mobile/app/features/chat/widgets/card_post.dart';
import 'package:cliver_mobile/data/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageRelatedPost extends StatelessWidget {
  const MessageRelatedPost(
      {super.key,
      required this.isRelatedToPost,
      required this.message,
      required this.isSentByMe});
  final bool isRelatedToPost;
  final Message message;
  final bool isSentByMe;

  @override
  Widget build(BuildContext context) {
    return isRelatedToPost
        ? Column(
            crossAxisAlignment: (isSentByMe)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "${'This message is related to'.tr}:",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                width: context.width * 0.9,
                child: CardPost(
                  imageUrl: message.relatedPost!.images![0],
                  description: message.relatedPost?.description as String,
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
