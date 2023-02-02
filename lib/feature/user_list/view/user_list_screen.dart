import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/feature/user_list/controller/user_list_controller.dart';
import 'package:interview_task/shared/contstants/strings.dart';

class UserListScreen extends GetView<UserListController> {
  UserListController controller = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Strings.randomUser)),
        body: Obx(
          () => controller.userList.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    //  var user = snapshot.data[index];
                    var user=controller.userList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                           user.picture!.thumbnail!),
                      ),
                      title: Text(user.name!.first!),
                      subtitle: Text('sagar@gmail.com' /*user.email*/),
                      onTap: () {},
                    );
                  },
                )
              : Center(child: CircularProgressIndicator()),
        ));
  }
}
