import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/request_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';

class AdminRequestsScreen extends StatefulWidget {
  const AdminRequestsScreen({super.key});

  @override
  State<AdminRequestsScreen> createState() => _AdminRequestsScreen();
}

class _AdminRequestsScreen extends State<AdminRequestsScreen> {
  final int _limit = 20;
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  bool _isLoading = false;
  List<RequestModel> _documents = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    Query query = firestore.collection('transfer').limit(_limit);

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
              .map((m) => RequestModel.fromJson(m.data() as Map))
              .toList();
        }

        _isLoading = false;
      });
    } else {
      setState(() {
        _hasMore = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('requests'.tr),
      ),
      body: _documents.isEmpty
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
                        RequestModel document = _documents[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.toNamed('/request-details/${document.id}');
                            },
                            title: Text(
                              document.userData.name,
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
