import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<String> {
  @override
  void onInit() {
    super.onInit();
    change("Home Page Loaded", status: RxStatus.success());
  }

  void refreshPage() {
    change(null, status: RxStatus.loading());
    // 执行数据刷新逻辑
    change("Home Page Refreshed", status: RxStatus.success());
  }
}
