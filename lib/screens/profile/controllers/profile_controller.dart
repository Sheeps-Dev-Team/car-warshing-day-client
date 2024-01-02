import 'package:get/get.dart';

class ProfileController extends GetxController {
  final List<String> dataTableColumns = [
    '세차일',
    '지속기간',
    '지속일',
  ];

  RxString selectedArea = ''.obs; // 선택된 시, 도
  RxString selectedSubArea = ''.obs; // 선택된 구, 군
  RxString selectedPrecipitationProbability = ''.obs; // 선택된 강수 확률
}
