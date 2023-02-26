import 'package:dio/dio.dart';
import 'package:nikestore/common/http_response_validator.dart';
import 'package:nikestore/data/comment.dart';

abstract class ICommentDataSource{
  Future<List<CommentEntity>> getAll({required int productId});
 }

 class CommnetDataSource with HttpResponseValidator implements ICommentDataSource{
  final Dio httpClient;

  CommnetDataSource(this.httpClient);
  @override
  Future<List<CommentEntity>> getAll({required int productId}) async{
   final response=await httpClient.get('comment/list?product_id=$productId');
   validateResponse(response);
   final List<CommentEntity> comments=[];
   (response.data as List).forEach((element) {
    comments.add(CommentEntity.fromjson(element));
   });
   return comments;
  }

 }