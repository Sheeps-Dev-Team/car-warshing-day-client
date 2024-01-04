import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import '../data/global_data.dart';
import 'custom_exception.dart';

enum Status { LOADING, COMPLETED, ERROR }

class ApiProvider {
  final String _baseUrl = kReleaseMode == false ? "http://192.168.2.168:" : "http://192.168.2.168:"; //서버 붙는 위치
  final String _imageUrl = kReleaseMode == false ? "http://192.168.2.168:" : "http://192.168.2.168:";

  final String port = kReleaseMode == false ? "50012" : "50012";                       //기본 포트

  String get getUrl => _baseUrl + port;

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

    String tempUri = _baseUrl + port;

    var uri = Uri.parse('$tempUri$url/${urlParam ?? ""}');
    try {
      final response = await http.get(uri,
          headers: {
            'Content-Type' : 'application/json',
            'Authorization' : GlobalData.accessToken ?? ""
          });

      if(response.body == "") return null;

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('인터넷 접속이 원활하지 않습니다');
    }
    return responseJson;
  }

  //post
  Future<dynamic> post(String url, dynamic data, {String? urlParam}) async {
    var responseJson;

    String tempUri = _baseUrl + port;

    var uri = Uri.parse('$tempUri$url/${urlParam ?? ""}');
    try {
      final response = await http.post(uri,
          headers: {
            'Content-Type' : 'application/json',
            'Authorization' : GlobalData.accessToken ?? ""
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

  //post
  Future<dynamic> patch(String url, dynamic data, {String? urlParam}) async {
    var responseJson;

    String tempUri = _baseUrl + port;

    var uri = Uri.parse('$tempUri$url/${urlParam ?? ""}');
    try {
      final response = await http.patch(uri,
          headers: {
            'Content-Type' : 'application/json',
            'Authorization' : GlobalData.accessToken ?? ""
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
      case 400:
      //throw BadRequestException(response.body.toString());
        BadRequestException(response.body.toString());
        return null;
      case 401: //토큰 정보 실패
        BadRequestException(response.body.toString());
        return null;
      case 403:
      //throw UnauthorisedException(response.body.toString());
        BadRequestException(response.body.toString());
        return null;
      case 404: //토큰 정보 실패
      // GlobalFunction.globalLogout(isSend: false);
        throw BadRequestException('토큰 정보가 존재하지 않습니다.');
        return null;
      case 429: //API 한도 초과
        throw BadRequestException("너무 잦은 요청으로 1시간동안 사용이 제한됩니다.");
      case 500:
        return null;
      default:
      //throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        return null;
    }
  }
}
