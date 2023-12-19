import 'package:car_washing_day/respository/user_repository.dart';
import 'package:car_washing_day/screens/login/login_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../config/constants.dart';
import '../../../util/global_function.dart';
import 'kakao_login.dart';

class LoginController extends GetxController {
  // 카카오 로그인
  Future<bool> kakaoLoginFunc() async {
    final String kEmail = await kakaoLogin();

    if (kEmail.isNotEmpty) {
      loginFunc(email: kEmail, loginType: loginTypeKaKao);
      return true;
    } else {
      GlobalFunction.showToast(msg: '카카오 로그인에 실패했습니다.');
      return false;
    }
  }

  // 구글 로그인
  Future<bool> googleLoginFunc() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential user = await FirebaseAuth.instance.signInWithCredential(credential);
      if (user.user != null) {
        loginFunc(email: user.user!.email ?? '', loginType: loginTypeGoogle);
        return true;
      } else {
        GlobalFunction.showToast(msg: '구글 로그인에 실패했습니다.');
        return false;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      GlobalFunction.showToast(msg: '구글 로그인에 실패했습니다.');
      return false;
    }
  }

  // 로그인
  Future<void> loginFunc({required String email, required String loginType, String? name}) async {
    if (kDebugMode) print('$email $loginType');

    GlobalFunction.globalLogin(
      email: email,
      loginType: loginType,
      nullCallback: () {
        GlobalFunction.showCustomDialog(title: '로그인 실패', description: '로그인에 실패하였습니다.\n잠시 후 다시 시도해 주세요.');
      },
    );
  }
}
