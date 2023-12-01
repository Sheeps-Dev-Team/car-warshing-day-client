import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class BubbleController extends GetxController {
  final bubbleId = List.generate(10, (index) => const Uuid().v1());

  void resetDrop(String id){
    bubbleId.remove(id);
    bubbleId.add(const Uuid().v1());
    update();
  }
}