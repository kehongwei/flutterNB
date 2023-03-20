
import 'package:food_delivery/models/article_bean.dart';
import 'package:food_delivery/models/user_bean.dart';
import 'package:food_delivery/models/wan_response.dart';
import 'package:get/get.dart';

import '../data/repository/auth_repo.dart';
import '../data/repository/wan_repo.dart';
import '../models/article_list_bean.dart';
import '../models/response_model.dart';
import '../models/signup_body_model.dart';

class WanController extends GetxController implements GetxService {
   final WanRepo wanRepo;

   WanController({required this.wanRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int page = 0;

   final List<ArticleBean> _articleList = [];
   List<ArticleBean> get articleList => _articleList;

  Future<WanResponse> getArticle() async {
    _isLoading = true;
    WanResponse<ArticleListBean> articleListBean;
    Response response = await wanRepo.getArticle(page);
    print(response.status);

    articleListBean = WanResponse.fromJson(response.body, (json) => ArticleListBean.fromJson(json as Map<String, dynamic>));
    print(articleListBean.data.curPage);
   if(articleListBean.data.size! > 0){
     _articleList.addAll(articleListBean.data.datas as List<ArticleBean>);
   }
    _isLoading = false;
    update();
    return articleListBean;
  }






}
