import 'package:get/get.dart';

class StepController extends GetxController {
  var currentIndex = 0.obs;
  var isThreePack = false.obs;

  changeIsThreePack() {
    isThreePack.value = !isThreePack.value;
  }
}
