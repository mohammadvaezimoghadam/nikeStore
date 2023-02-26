part of 'comment_list_bloc_bloc.dart';

abstract class CommentListBlocEvent extends Equatable {
  const CommentListBlocEvent();

  @override
  List<Object> get props => [];
}
class CommentListStarted extends CommentListBlocEvent{}
