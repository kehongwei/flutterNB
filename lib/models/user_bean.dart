import 'article_bean.dart';

import 'package:json_annotation/json_annotation.dart';
part 'user_bean.g.dart';
@JsonSerializable(genericArgumentFactories: true)
class UserBean {
  bool? admin;
  List<ArticleBean>? chapterTops;
  int? coinCount;
  List<int>? collectIds;
  String? email;
  String? icon;
  int? id;
  String? nickname;
  String? password;
  String? publicName;
  String? token;
  int? type;
  String? username;

  UserBean(
      {this.admin,
        this.chapterTops,
        this.coinCount,
        this.collectIds,
        this.email,
        this.icon,
        this.id,
        this.nickname,
        this.password,
        this.publicName,
        this.token,
        this.type,
        this.username});

  factory UserBean.fromJson(Map<String, dynamic> json) => _$UserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UserBeanToJson(this);

}