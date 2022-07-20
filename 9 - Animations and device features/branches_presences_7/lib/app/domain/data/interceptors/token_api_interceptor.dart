import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';

class TokenApiInterceptor implements InterceptorContract {

  final FlutterSecureStorage storage;

  TokenApiInterceptor({ required this.storage, });

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    var token = await storage.read(key: "apiToken");
    if ( token != '' ) {
      data.params['auth'] = token;
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}