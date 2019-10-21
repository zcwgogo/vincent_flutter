import 'package:vincent_flutter/view/event/index.dart';
import 'package:vincent_flutter/view/event/http_error_event.dart';
class HTTPCode {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const HTTP_CODE_EXPIRE = 403;

  static errorHandleFunction(code, message) {
    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}
