import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString selectedArea = ''.obs; // 선택된 시, 도
  RxString selectedSubArea = ''.obs; // 선택된 구, 군

  // 매장 검색
  // void storeSearch() {
  //   if (selectedArea.isEmpty && storeSearchController.text.trim().isEmpty)
  //     return;

  //   Get.offNamed(
  //     StorePage.route,
  //     arguments: {
  //       'area': selectedArea.value,
  //       'subArea': selectedSubArea.value,
  //       'store': storeSearchController.text.trim(),
  //     },
  //   );
  // }
}
