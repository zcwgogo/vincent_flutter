import 'package:vincent_flutter/src/common/DataResult.dart';

class DataResult4List extends DataResult {
  List rows;
  int total;
  int currentPage;
  int totalPage;

  DataResult4List(this.rows, this.total, this.currentPage, this.totalPage, bool success, String message, Object data)
      : super(success, message, data);
}
