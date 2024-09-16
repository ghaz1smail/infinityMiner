import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/user_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';

class MembersDialog extends StatefulWidget {
  final UserModel userData;
  const MembersDialog({super.key, required this.userData});

  @override
  State<MembersDialog> createState() => _MembersDialogState();
}

class _MembersDialogState extends State<MembersDialog> {
  List<UserModel> users = [];
  bool loading = true;
  getUsersData() async {
    for (var e in widget.userData.userUsingCode!) {
      await firestore.collection('users').doc(e.uid).get().then((t) {
        var x = UserModel.fromJson(t.data() as Map);
        if (!e.status) {
          users.add(x);
        }
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getUsersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Get.width < 600;
    return SizedBox(
      height: isMobile ? Get.height : 300,
      width: isMobile ? Get.width : 600,
      child: loading
          ? const CustomLoading()
          : users.isEmpty
              ? Center(
                  child: Text('no_data_found'.tr),
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index];
                    return ListTile(
                      onTap: () {
                        Get.toNamed('/user-details/${user.uid}');
                      },
                      title: Text(
                        user.name,
                      ),
                    );
                  },
                ),
    );
  }
}
