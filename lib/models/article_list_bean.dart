
import 'package:json_annotation/json_annotation.dart';

import 'article_bean.dart';
part 'article_list_bean.g.dart';
@JsonSerializable(genericArgumentFactories: true)
class ArticleListBean {

  int? curPage;
  int? size;
  int? pageCount;
  int? total;
  int? offset;
  bool? over;
  List<ArticleBean>? datas;

  ArticleListBean({
    this.curPage,
    this.size,
    this.pageCount,
    this.total,
    this.offset,
    this.over,
    this.datas
  });

  factory ArticleListBean.fromJson(Map<String, dynamic> json) => _$ArticleListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleListBeanToJson(this);
}


