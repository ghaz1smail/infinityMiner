import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/message_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore_plus/paginate_firestore.dart';

class RepliesScreen extends StatefulWidget {
  const RepliesScreen({super.key});

  @override
  State<RepliesScreen> createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
  @override
  void initState() {
    authController.getCurrentUserData();
    super.initState();
  }

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
              MessageModel.fromMap(documentSnapshots[index].data() as Map);
          return Card(
            child: ListTile(
              title: Text(
                document.message,
              ),
              subtitle: Text(DateFormat('dd/MM/yy | hh:mm')
                  .format(DateTime.parse(document.timestamp))),
            ),
          );
        },
        query: firestore
            .collection('messages')
            .where('uid', isEqualTo: authController.userData!.uid),
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
