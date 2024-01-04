import 'package:car_washing_day/config/constants.dart';
import 'package:car_washing_day/data/global_data.dart';
import 'package:car_washing_day/data/location_data.dart';

class User {
  User(
      {this.userId = nullInt,
      required this.email,
      required this.loginType,
      required this.nickName,
      required this.address,
      this.createdAt,
      this.lastModifiedAt});

  int userId;
  String email;
  String loginType;
  String nickName;
  String address;
  DateTime? createdAt;
  DateTime? lastModifiedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    if (json['badgeCount'] != null) {
      GlobalData.badgeCount = json['badgeCount']!;
    }

    if (json['alarm'] != null) {
      GlobalData.alarm = json['alarm'];
    }

    if (json['accessToken'] != null) {
      GlobalData.accessToken = json['schema'] + ' ' + json['accessToken'];
    }

    return User(
      userId: json['userId'],
      email: json['email'] ?? '',
      loginType: json['loginType'] ?? '',
      nickName: json['nickName'] ?? '',
      address: json['address'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      lastModifiedAt: json['lastModifiedAt'] == null
          ? null
          : DateTime.parse(json['lastModifiedAt']),
    );
  }

  Map<String, dynamic> toCreateJson() => {
        'email': email,
        'loginType': loginType,
        'nickName': nickName,
        'address': address
      };

//단기 좌표
  String get getShortTerm {
    final List<String> splitList = address.split('|');

    final String userArea = splitList.first; //user의 시, 도
    final String userSubArea = splitList.last; //user의 구, 군

    final String shortTermValue = locationMap[userArea]![userSubArea]!;
    return shortTermValue;
  }

//중기 좌표
  String get getMidTerm {
    final String userArea = address.split('|').first; //user의 시, 도

    final String midTermValue = midTermLocationMap[userArea]!; //중기 코드 추출
    return midTermValue;
  }
}
