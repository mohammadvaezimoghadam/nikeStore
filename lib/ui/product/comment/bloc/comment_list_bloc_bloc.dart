import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nikestore/common/exception.dart';
import 'package:nikestore/data/comment.dart';
import 'package:nikestore/data/repo/comment_repository.dart';

part 'comment_list_bloc_event.dart';
part 'comment_list_bloc_state.dart';

class CommentListBloc
    extends Bloc<CommentListBlocEvent, CommentListBlocState> {
  final ICommentRepository repository;
  final int productId;
  CommentListBloc({required this.repository, required this.productId})
      : super(CommentListLoading()) {
    on<CommentListBlocEvent>((event, emit) async {
      if (event is CommentListStarted) {
        emit(CommentListLoading());
        try {
          final comments = await repository.getAll(productId: productId);
          emit(CommentListSuccess(comments));
        } catch (e) {
          emit(CommentListError(e is AppException ? e : AppException()));
        }
      }
    });
  }
}
