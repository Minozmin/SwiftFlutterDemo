import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class DioHttpRequest {
  static Future<ResponseData> getReqeust(String path, [dynamic params]) async {
    return _request('GET', path, params);
  }

  static Future<ResponseData> postRequest(String path,
      [dynamic params]) async {
    return _request('POST', path, params);
  }

  static Future<ResponseData> _request(String method, String path,
      [dynamic params]) async {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://m.devapi.haoshiqi.net',
    );

    Dio dio = Dio(options);

    try {
      Response response;
      if (method == 'POST') {
        response = await dio.post(path, queryParameters: params);
      }else {
        response = await dio.get(path, queryParameters: params);
      }

      if (response.statusCode == 200) {
        print(response.data);
        return Future.value(ResponseData.parse(response.data));
      } else {
        ResponseData responseData = ResponseData();
        responseData.errno = response.statusCode;
        responseData.errmsg = '服务器异常';
        return Future.value(responseData);
      }
    } on DioError catch (e) {
      ResponseData responseData = ResponseData();
    responseData.errmsg = _errmsg(e.type);
    //类型判断 is
    if (e.error is SocketException) {
      SocketException error = e.error;
      responseData.errno = error.osError.errorCode;
    } else {
      responseData.errno = -1;
    }

    return Future.value(responseData);
    }
  }

  //错误码处理
  static String _errmsg(DioErrorType type) {
    switch (type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return '连接超时';
        break;
      case DioErrorType.SEND_TIMEOUT:
        return '请求超时';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        return '响应超时';
        break;
      case DioErrorType.RESPONSE:
        return '出现异常';
        break;
      case DioErrorType.CANCEL:
        return '请求取消';
        break;
      default:
        return '无网络';
        break;
    }
  }
}

//返回数据处理
class ResponseData {
  String errmsg;
  int errno;
  int timestamp;
  Map data;
  static ResponseData parse(dynamic data) {
    Map map;
    if (data is Map) {
      map = data;
    }else {
      map = jsonDecode(data);
    }
    ResponseData responseData = ResponseData();
    responseData.errmsg = map['errmsg'];
    responseData.errno = map['errno'];
    responseData.timestamp = map['timestamp'];
    responseData.data = map['data'];
    return responseData;
  }
}
