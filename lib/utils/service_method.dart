import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../utils/httpHeaders.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

class DioUtil {
  static Dio dio = new Dio();
  static bool loading = false;
  static Future request(url, {formData, context}) async {
    try {
      // Options options = Options(headers: {HttpHeaders.acceptHeader:"accept: application/json"});

      print('开始获取数据...............');
      loading = true;
      Response response;
      dio.options.responseType = ResponseType.plain;
      dio.options.headers = httpHeaders;
      tokenInter();
//  dio.options.contentType = ContentType.parse("application/json;charset=UTF-8")
      print(servicePath[url]);

      if (formData == null) {
        response = await dio.post(servicePath[url]);
      } else {
        response = await dio.post(servicePath[url], data: formData);
      }

      if (response.statusCode == 200) {
        var responseData = json.decode(response.data);
        // print(responseData['status'].toString() == '401');

        //判断是否有权限，
        if (responseData['status'].toString() == '401') {
          print(responseData['status']);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();

          //在这里跳转，点赞功能会出问题：总是跳转。改成更改登录状态
          Navigator.of(context).pushNamed('login_page');

          // Provider.of<IsLoginModal>(context).changeLoginState(false);
          loading = false;

          return null;
        }

        loading = false;
        return response.data;
      } else {
        loading = false;

        throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    } catch (e) {
      return print('ERROR:======>$e');
    }
  }

  static Future upLoadImage(File image) async {
    String path = image.path;
    print(image);
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(path, filename: name),
      // "fileName": name,
    });
    print(name);
    Response response;
    dio.options.responseType = ResponseType.plain;
    dio.options.headers = uploadHeaders;
    response = await dio.post(servicePath['uploadImg'], data: formData);
    if (response.statusCode == 200) {
      print(json.decode(response.data));
      var responseData = json.decode(response.data);
      return responseData;
    }
  }

  static tokenInter() {
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (RequestOptions options) {
        dio.lock();
        Future<dynamic> future = Future(() async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          return prefs.getString('token');
        });
        return future.then((value) {
          options.headers["token"] = value;
          return options;
        }).whenComplete(() => dio.unlock());
      }, onResponse: (Response response) {
        // 在返回响应数据之前做一些预处理

        return response; // continue
      }),
    );
  }
}

// Function isPermisson(permission) {
//   permission = json.decode(permission);
//   if (permission['status'] == 401) {
//     // Application.router.navigateTo();

//   }
// }
