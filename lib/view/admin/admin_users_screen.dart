import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/user_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminRequestsScreen();
}

class _AdminRequestsScreen extends State<AdminUsersScreen> {
  final int _limit = 20;
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true, _isLoading = false, firstLoading = true;
  List<UserModel> _documents = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (mounted) {
      if (_isLoading) return;
      setState(() {
        _isLoading = true;
      });

      Query query = firestore
          .collection('users')
          .where('type', isNotEqualTo: 'admin')
          .limit(_limit);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          _lastDocument = querySnapshot.docs.last;
          _hasMore = querySnapshot.docs.length == _limit;
          if (querySnapshot.docs.isNotEmpty) {
            _documents = querySnapshot.docs
                .map((m) => UserModel.fromJson(m.data() as Map))
                .toList();
          }
          _isLoading = false;
          firstLoading = false;
        });
      } else {
        setState(() {
          _hasMore = false;
          _isLoading = false;
          firstLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('users'.tr),
      ),
      body: firstLoading
          ? const CustomLoading()
          : _documents.isEmpty
              ? Center(
                  child: Text(
                  'no_data_found'.tr,
                  style: const TextStyle(color: Colors.white),
                ))
              : NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!_isLoading &&
                        _hasMore &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      _fetchData();
                    }
                    return false;
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _documents.length,
                          itemBuilder: (context, index) {
                            UserModel document = _documents[index];
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
                        ),
                      ),
                      if (_isLoading) const CustomLoading()
                    ],
                  ),
                ),
    );
  }
}
