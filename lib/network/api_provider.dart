import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../data/global_data.dart';
import 'custom_exception.dart';

enum Status { LOADING, COMPLETED, ERROR }

class ApiProvider {
  final String _baseUrl = kReleaseMode == false ? "http://192.168.2.168:" : "http://192.168.2.168:"; //서버 붙는 위치
  final String _imageUrl = kReleaseMode == false ? "http://192.168.2.168:" : "http://192.168.2.168:";
  final String _awsUrl = 'https://w0i2o3wnkk.execute-api.ap-northeast-2.amazonaws.com';

  final String port = kReleaseMode == false ? "50012" : "50012";                       //기본 포트

  //String get getUrl => _baseUrl + port;
  String get getUrl => _awsUrl;

  String getImgUrl() {
    var resUrl = _imageUrl;

    if(!kReleaseMode){
      resUrl += port;
    }

    return resUrl;
  }

  //get
  Future<dynamic> get(String url, {String? urlParam}) async {
    var responseJson;

    String tempUri = getUrl;

    var uri = Uri.parse('$tempUri$url/${urlParam ?? ""}');

    try {
      final response = await http.get(uri,
          headers: {
            'Content-Type' : 'application/json',
            // 'Authorization' : GlobalData.accessToken ?? ""
          });

      if(response.body == "") return null;

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('인터넷 접속이 원활하지 않습니다');
    }
    return responseJson;
  }

  //post
  Future<dynamic> post(String url, dynamic data) async {
    var responseJson;

    String tempUri = getUrl;

    var uri = Uri.parse('$tempUri$url');
    try {
      final response = await http.post(uri,
          headers: {
            'Content-Type' : 'application/json',
            // 'Authorization' : GlobalData.accessToken ?? ""
          },
          body: data,
          encoding: Encoding.getByName('utf-8'));

      if(response.body == "") return null;

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('인터넷 접속이 원활하지 않습니다');
    }

    return responseJson;
  }

  //patch
  Future<dynamic> patch(String url, dynamic data) async {
    var responseJson;

    String tempUri = getUrl;

    var uri = Uri.parse('$tempUri$url');
    try {
      final response = await http.patch(uri,
          headers: {
            'Content-Type' : 'application/json',
            // 'Authorization' : GlobalData.accessToken ?? ""
          },
          body: data,
          encoding: Encoding.getByName('utf-8'));

      if(response.body == "") return null;

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('인터넷 접속이 원활하지 않습니다');
    }

    return responseJson;
  }

  //delete
  Future<dynamic> delete(String url, dynamic data) async {
    var responseJson;

    String tempUri = getUrl;

    var uri = Uri.parse('$tempUri$url');
    try {
      final response = await http.delete(uri,
          headers: {
            'Content-Type' : 'application/json',
            // 'Authorization' : GlobalData.accessToken ?? ""
          },
          body: data,
          encoding: Encoding.getByName('utf-8'));

      if(response.body == "") return null;

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('인터넷 접속이 원활하지 않습니다');
    }

    return responseJson;
  }

  dynamic _response(http.Response response) {
    if (kDebugMode) print(response.statusCode.toString());

    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        if (kDebugMode) print(responseJson.toString());
        return responseJson;
      case 400: //잘못된 요청
      case 401: //권한 없음
      case 403: //토큰 오류
      case 404: //찾을수 없음
      case 405: //허용되지않은 호출
      case 409: //중복된 이메일(회원가입)
          if(Get.currentRoute == '/ProfilePage') return 409;
      case 500: //서버 오류
      case 501: //함수실행 실패
      case 502: //잘못된 접근
      case 503: //서비스를 사용할 수 없음
        debugPrint(response.body);
        return null;
      default:
        debugPrint("Unknown response status");
        return null;
    }
  }
}
