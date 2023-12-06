import '../main.dart';
import 'style.dart';

AppStyle get $style => MyApp.style;

double sizeUnit = 1;

const int nullInt = -100;
const double nullDouble = -100;

final DateTime nullDateTime = DateTime(1000, 1, 1, 9);

const int genderMale = 0; // 남
const int genderFemale = 1; // 여

const String division = '|'; // 문자열 구분자

enum LoginType{kakao, apple, google, none} // 로그인 타입 (카카오, 애플, 구글, 비로그인)

const int defaultPop = 30; // 기본 강수 확률 (사용자 설정 강수 확률 없을 시 쓰임)