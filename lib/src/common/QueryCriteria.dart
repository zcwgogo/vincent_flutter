 class QueryCriteria{
   RequestParam requestParam;
   PagingParam pagingParam;
 }

 class RequestParam{
   String url;
   Map condition;
   bool async;
   RequestParam(this.url, this.condition, this.async);
 }

 class PagingParam{
   int page = 0;
   int rows=20;
   String orderField;
   OrderEnum direction=OrderEnum.DESC;

   PagingParam(this.page, this.rows, this.orderField, this.direction);

 }
 enum OrderEnum {
   ASC,
   DESC
 }