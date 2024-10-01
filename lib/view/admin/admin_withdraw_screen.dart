import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/withdraw_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class AdminWithdrawScreen extends StatelessWidget {
  const AdminWithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('withdraw'.tr),
      ),
      body: PaginateFirestore(
        onEmpty: Center(
            child: Text(
          'no_data_found'.tr,
          style: const TextStyle(color: Colors.white),
        )),
        initialLoader: const CustomLoading(),
        itemBuilder: (context, documentSnapshots, index) {
          WithdrawModel document =
              WithdrawModel.fromJson(documentSnapshots[index].data() as Map);
          return Card(
            color: document.status == 'done' ? Colors.green : null,
            child: ListTile(
              onTap: () {
                Get.toNamed('/withdraw-details/${document.id}');
              },
              title: Text(
                document.userData.name,
              ),
            ),
          );
        },
        query: firestore.collection('withdraw'),
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
