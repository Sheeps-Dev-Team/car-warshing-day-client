import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/config/storage.dart';
import 'package:car_washing_day/data/global_data.dart';
import 'package:car_washing_day/screens/main/controllers/main_page_controller.dart';
import 'package:car_washing_day/util/global_function.dart';
import 'package:get/get.dart';

class AddressInputController extends GetxController {
  RxString selectedArea = ''.obs; // 선택된 시, 도
  RxString selectedSubArea = ''.obs; // 선택된 구, 군

  RxBool get isOk => (selectedArea.isNotEmpty && selectedSubArea.isNotEmpty).obs;

  // 지역 변경
  void onChangedArea(String? value){
    selectedSubArea('');
    selectedArea(value);
  }

  // 작은 지역 변경
  void onChangedSubArea(String? value) {
    selectedSubArea(value);
  }

  // 주소 세팅
  void setAddress() async{
    final String address = '${selectedArea.value}$division${selectedSubArea.value}';

    await Storage.setAddressData(address); // 로컬에 저장
    GlobalData.weatherList = await GlobalFunction.getWeatherList(address); // 날씨 리스트 세팅
    MainPageController.to.update();

    Get.back(); // 메인 페이지로 이동
  }
}