import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinityminer/helper/get_initial.dart';
import 'package:infinityminer/models/message_model.dart';
import 'package:infinityminer/view/widgets/custom_loading.dart';

class AdminMessagesScreen extends StatefulWidget {
  const AdminMessagesScreen({super.key});

  @override
  State<AdminMessagesScreen> createState() => _AdminRequestsScreen();
}

class _AdminRequestsScreen extends State<AdminMessagesScreen> {
  final int _limit = 20;
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  bool _isLoading = false;
  List<MessageModel> _documents = [];

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

    Query query = firestore.collection('contact').limit(_limit);

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
              .map((m) => MessageModel.fromJson(m.data() as Map))
              .toList();
        }
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
        title: Text('messages'.tr),
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
                        MessageModel document = _documents[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              document.name,
                              style: const TextStyle(color: Colors.white),
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
