import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/user_model.dart';
import 'package:infinityminer/view/admin/add_fund_dialog.dart';
import 'package:infinityminer/view/widgets/custom_button.dart';
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
    for (String e in widget.userData.userUsingCode!) {
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
              : ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
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
                      trailing: user.gotCodePrize
                          ? null
                          : CustomButton(
                              title: 'add_fund',
                              function: () {
                                customUi.customDialog(AddFundDialog(
                                  userData: user,
                                  getUserData: () {},
                                  codePrize: true,
                                ));
                              },
                              size: 14,
                              width: 100,
                              height: 30,
                              color: appTheme.primaryColor),
                    );
                  },
                ),
    );
  }
}
