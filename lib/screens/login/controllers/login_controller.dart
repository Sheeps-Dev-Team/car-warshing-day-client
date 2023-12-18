import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../util/global_function.dart';
import 'kakao_login.dart';

class LoginController extends GetxController {
  // 카카오 로그인
  Future<bool> kakaoLoginFunc() async {
    final String kEmail = await kakaoLogin();

    if (kEmail.isNotEmpty) {
      loginFunc(email: kEmail, loginType: LoginType.kakao);
      return true;
    } else {
      GlobalFunction.showToast(msg: '카카오 로그인에 실패했습니다.');
      return false;
    }
  }

  // 로그인
  Future<void> loginFunc({required String email, required LoginType loginType, String? name}) async {
    if (kDebugMode) print('$email $loginType');

    // // 등록된 유저인지 체크
    // final bool idCheck = await AppRepository.userIDCheck(email);
    //
    // if (idCheck) {
    //   GlobalFunction.globalLogin(
    //     email: email,
    //     nullCallback: () {
    //       GlobalFunction.showCustomDialog(title: '로그인 실패', description: '로그인에 실패하였습니다.\n잠시 후 다시 시도해 주세요.');
    //     },
    //   );
    // } else {
    //   Get.to(() => PermissionPage(name: name, loginType: loginType, email: email)); // 권한 관리 페이지로 이동
    // }
  }
}