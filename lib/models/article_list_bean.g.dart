// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleListBean _$ArticleListBeanFromJson(Map<String, dynamic> json) =>
    ArticleListBean(
      curPage: json['curPage'] as int?,
      size: json['size'] as int?,
      pageCount: json['pageCount'] as int?,
      total: json['total'] as int?,
      offset: json['offset'] as int?,
      over: json['over'] as bool?,
      datas: (json['datas'] as List<dynamic>?)
          ?.map((e) => ArticleBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleListBeanToJson(ArticleListBean instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'size': instance.size,
      'pageCount': instance.pageCount,
      'total': instance.total,
      'offset': instance.offset,
      'over': instance.over,
      'datas': instance.datas,
    };
