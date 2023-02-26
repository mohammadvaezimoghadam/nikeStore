part of 'comment_list_bloc_bloc.dart';

abstract class CommentListBlocState extends Equatable {
  const CommentListBlocState();

  @override
  List<Object> get props => [];
}

class CommentListLoading extends CommentListBlocState {}

class CommentListSuccess extends CommentListBlocState {
 final List<CommentEntity> comments;

  const CommentListSuccess(this.comments);
  @override
  // TODO: implement props
  List<Object> get props => [comments];
}
class CommentListError extends CommentListBlocState{
  final AppException exception;

  const CommentListError(this.exception);
  @override
  // TODO: implement props
  List<Object> get props => [exception];

}
