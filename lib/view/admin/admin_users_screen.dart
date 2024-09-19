import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/models/user_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('users'.tr),
      ),
      body: PaginateFirestore(
        onEmpty: Center(
            child: Text(
          'no_data_found'.tr,
          style: const TextStyle(color: Colors.white),
        )),
        initialLoader: const CustomLoading(),
        itemBuilder: (context, documentSnapshots, index) {
          UserModel document =
              UserModel.fromJson(documentSnapshots[index].data() as Map);
          return Card(
            child: ListTile(
              onTap: () {
                Get.toNamed('/user-details/${document.uid}');
              },
              title: Text(
                document.name,
              ),
            ),
          );
        },
        query: FirebaseFirestore.instance
            .collection('users')
            .where('type', isEqualTo: 'user'),
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
