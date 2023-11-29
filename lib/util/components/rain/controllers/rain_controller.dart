import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RainController extends GetxController{
  final rainDropId = List.generate(15, (index) => const Uuid().v1());

  void resetDrop(String id){
    rainDropId.remove(id);
    rainDropId.add(const Uuid().v1());
    update();
  }
}