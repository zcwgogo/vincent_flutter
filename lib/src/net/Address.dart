class Address {
  static const String host = "http://103.5.193.84/supply";
  static const String url_host = "$host/res_base/";
  static const String login_url = "$host/j_spring_security_check.action";
  static const String update_url = "$host/update.do";
  static const String refresh_token_url = "$host/refreshToken.do";


  static getUserURL(type) {
    var mapping = <String, String>{
      'list': '/user/list.do',
      'get': '/user/updateInput.do',
      'update': '/user/update.do',
      'delete': '/user/delete.do'
    };
    String module=mapping[type];
    return "$host$module";
  }
  static getRoleURL(type) {
    var mapping = <String, String>{
      'list': '/role/list.do',
      'get': '/role/updateInput.do',
      'update': '/role/update.do',
      'delete': '/role/delete.do'
    };
    String module=mapping[type];
    return "$host$module";
  }


}