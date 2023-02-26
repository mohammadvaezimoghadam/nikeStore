import 'package:nikestore/common/http_client.dart';
import 'package:nikestore/data/comment.dart';
import 'package:nikestore/data/source/comment_data_source.dart';

final commentRepository =
    CommentRepository(remotdataSource: CommnetDataSource(httpClient));

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource remotdataSource;

  CommentRepository({required this.remotdataSource});
  @override
  Future<List<CommentEntity>> getAll({required int productId}) {
    return remotdataSource.getAll(productId: productId);
  }
}
