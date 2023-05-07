import 'package:get/get.dart';

class ReplyMessageData {
  static final ReplyMessageData instance = ReplyMessageData._initInstance();
  ReplyMessageData._initInstance();

  RxString replyMessage = "".obs;
  RxInt replyMessageId = (-1).obs;
  RxBool isReplied = false.obs;
}
