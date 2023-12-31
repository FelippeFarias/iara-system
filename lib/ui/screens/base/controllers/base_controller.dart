import 'package:get/get.dart';

class BaseController extends GetxController {
  int topIndex = 0;

  void navigatTo(int index) {
    topIndex = index;
    update();
  }
}