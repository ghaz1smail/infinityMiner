import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/models/message_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class AdminMessagesScreen extends StatelessWidget {
  const AdminMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('messages'.tr),
      ),
      body: PaginateFirestore(
        onEmpty: Center(
            child: Text(
          'no_data_found'.tr,
          style: const TextStyle(color: Colors.white),
        )),
        initialLoader: const CustomLoading(),
        itemBuilder: (context, documentSnapshots, index) {
          MessageModel document =
              MessageModel.fromJson(documentSnapshots[index].data() as Map);
          return Card(
            child: ListTile(
              onTap: () {
                Get.toNamed('/message-details/${document.id}');
              },
              title: Text(
                document.name,
              ),
            ),
          );
        },
        query: FirebaseFirestore.instance.collection('contact'),
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
