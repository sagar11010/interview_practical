import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:interview_task/core/local/sql_helper.dart';
import 'package:interview_task/core/network/model/random_user_response_model.dart';
import 'package:interview_task/core/network/service/random_user_service.dart';

class UserListController extends GetxController {
  final RandomUserService randomUserService = RandomUserServiceImpl();
  RxList<Result> userList = <Result>[].obs;

  @override
  void onInit() async {
    getUserList();
    super.onInit();
  }

  void getUserList() async {
    //get data from local database
    userList.value = await SQLHelper.getUsers();

    //api call
    var v = await randomUserService.getRandomUserList();
    v.fold((error) => print(error), (r) {
      userList.value = r.results!;
    });
  }
}
