import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/contact_model.dart';
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
          ContactModel document =
              ContactModel.fromJson(documentSnapshots[index].data() as Map);
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
        query: firestore.collection('contact'),
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
