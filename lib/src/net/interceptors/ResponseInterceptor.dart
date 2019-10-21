import 'package:dio/dio.dart';
import 'package:vincent_flutter/src/common/DataResult.dart';
import 'package:vincent_flutter/src/common/DataResult4List.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    RequestOptions option = response.request;
    try {
      return _handelResult(response.data);
    } catch (e) {
      print(e.toString() + option.path);
      return new DataResult(false, e.toString(), response.data);
    }
  }

  _handelResult(data) {
    if (data['currentPage'] != null) {
      //for list
      return new DataResult4List(
        data['rows'],
        data['total'],
        data['currentPage'],
        data['totalPage'],
        data['success'],
        data['message'],
        data['data'],
      );
    }
    return new DataResult(data['success'], data['message'], data['data']);
  }
}
