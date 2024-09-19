import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/models/request_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class AdminRequestsScreen extends StatelessWidget {
  const AdminRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('requests'.tr),
      ),
      body: PaginateFirestore(
        onEmpty: Center(
            child: Text(
          'no_data_found'.tr,
          style: const TextStyle(color: Colors.white),
        )),
        initialLoader: const CustomLoading(),
        itemBuilder: (context, documentSnapshots, index) {
          RequestModel document =
              RequestModel.fromJson(documentSnapshots[index].data() as Map);
          return Card(
            child: ListTile(
              onTap: () {
                Get.toNamed('/request-details/${document.id}');
              },
              title: Text(
                document.userData.name,
              ),
              tileColor: document.status == 'pending'
                  ? Colors.orange
                  : document.status == 'accepted'
                      ? Colors.green
                      : Colors.red,
            ),
          );
        },
        query: FirebaseFirestore.instance.collection('transfer'),
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
