import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikestore/common/exception.dart';
import 'package:nikestore/data/comment.dart';
import 'package:nikestore/data/repo/comment_repository.dart';

import 'package:nikestore/ui/product/comment/bloc/comment_list_bloc_bloc.dart';
import 'package:nikestore/ui/widgets/error.dart';

class CommentsList extends StatelessWidget {
  final int productId;

  const CommentsList({Key? key, required this.productId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
            repository: commentRepository, productId: productId);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListBlocState>(
          builder: (context, state) {
        if (state is CommentListSuccess) {
          return SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return CommentItem(
                comment: state.comments[index],
              );
            },
            childCount: state.comments.length,
          ));
        } else if (state is CommentListLoading) {
          return SliverToBoxAdapter(
            child: Center(child: CupertinoActivityIndicator()),
          );
        } else if (state is CommentListError) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
                exception: state.exception,
                onPressed: () {
                  BlocProvider.of<CommentListBloc>(context)
                      .add(CommentListStarted());
                }),
          );
        } else {
          throw Exception("state is not suppoted");
        }
      }),
    );
  }
}

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: Theme.of(context).dividerColor)),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.title),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    comment.email,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              Text(
                comment.date,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            comment.content,
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
