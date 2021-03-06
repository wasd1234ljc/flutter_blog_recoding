import 'dart:ui';

import 'package:blog_flutter/model/commentList.dart';
import 'package:fish_redux/fish_redux.dart';

class CommentState implements Cloneable<CommentState> {
  CommentListResult clr;
  bool isLiked = false;
  var userInfo;
  int index = 0;
  int articleId;
  @override
  CommentState clone() {
    return CommentState()
      ..clr = clr
      ..isLiked = isLiked
      ..userInfo = userInfo
      ..articleId = articleId
      ..index = index;
  }
}

CommentState initState(Map<String, dynamic> args) {
  return CommentState();
}
