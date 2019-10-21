import 'package:flutter/material.dart';
import 'package:vincent_flutter/src/common/DataResult4List.dart';
import 'package:vincent_flutter/src/common/QueryCriteria.dart';
import 'package:vincent_flutter/src/common/VBaseDao.dart';
import 'package:vincent_flutter/src/common/config/AppConfig.dart';

class VWPullLoadControl {
  int _page = 1;
  bool needHeader = false;
  String url;
  List dataList = new List();
  ValueNotifier<bool> needLoadMore = new ValueNotifier(false);

  QueryCriteria generateQueryCriteria(Map param, String order) {
    QueryCriteria criteria = new QueryCriteria();
    criteria.pagingParam = new PagingParam(_page, AppConfig.PAGE_SIZE, order ?? "", OrderEnum.DESC);
    criteria.requestParam = new RequestParam(this.url, param ?? {}, true);
    return criteria;
  }

  requestRefresh({Map param, String order}) async {
    _page = 1;
    await VBaseDao.list(generateQueryCriteria(param, order)).then((result) {
      if (result is DataResult4List) {
        this.needLoadMore = ValueNotifier(result.currentPage < result.totalPage);
        this.dataList = result.rows;
      }
      return result;
    });
  }

  requestLoadMore({Map param, String order}) async {
    _page++;
    await VBaseDao.list(generateQueryCriteria(param, order)).then((result) {
      if (result is DataResult4List) {
        this.needLoadMore = ValueNotifier(result.totalPage <= result.currentPage);
        if (result.rows != null) {
          dataList.addAll(result.rows);
        }
      }
      return result;
    });
  }
}
