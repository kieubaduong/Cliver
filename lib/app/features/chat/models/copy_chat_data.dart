import 'package:get/get.dart';
import '../../../../data/models/model.dart';

class CopyChatData {
  static final CopyChatData instance = CopyChatData._initInstance();
  CopyChatData._initInstance();

  RxDouble tapX = 0.0.obs, tapY = 300.0.obs;
  Rx<Message> message = Message().obs;
  RxBool isSentByMe = false.obs;
}
