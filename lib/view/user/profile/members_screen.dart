import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/user_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  List<UserModel> users = [];
  bool loading = true;

  getUsersData() async {
    if (authController.userData == null) {
      await authController.getCurrentUserData();
    }
    for (var e in authController.userData!.userUsingCode!) {
      await firestore.collection('users').doc(e).get().then((t) {
        var x = UserModel.fromJson(t.data() as Map);

        users.add(x);
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
    return Scaffold(
      body: loading
          ? const CustomLoading()
          : users.isEmpty
              ? Center(
                  child: Text(
                    'no_data_found'.tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index];
                    return Chip(label: ListTile(title: Text(user.name)));
                  },
                ),
    );
  }
}
