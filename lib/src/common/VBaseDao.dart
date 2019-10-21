import 'package:common_utils/common_utils.dart';
import 'package:vincent_flutter/src/common/DataResult.dart';
import 'package:vincent_flutter/src/common/QueryCriteria.dart';
import 'package:vincent_flutter/src/net/HttpManager.dart';

class VBaseDao {
  static list(QueryCriteria criteria) async {

    Map condition=criteria.requestParam.condition??{};
    condition["rows"]=criteria.pagingParam.rows;
    condition["page"]=criteria.pagingParam.page;
    if(!ObjectUtil.isEmptyString(criteria.pagingParam.orderField)){
      condition["orderField"]=criteria.pagingParam.orderField;
      condition["order"]=criteria.pagingParam.direction.toString();
    }
    next() async {
      DataResult res = await HttpManager.instance.request(criteria.requestParam.url, condition, null);
      return res;
    }
    return await next();
  }
}
