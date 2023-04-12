import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var historyList;

  Future<void> allHistory() async {
    var mytemp = await FirebaseFirestore.instance.collection('/history').get();
    List<Map<String, dynamic>> list1 =
        mytemp.docs.map((doc) => doc.data()).toList();
    historyList = list1;
    setState(() {});
  }

  @override
  void initState() {
    allHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("History"),
      // ),
      body: Stack(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "History",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 35, bottom: 15, right: 10, left: 10),
            child: historyList == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      if (historyList[index]['user_id'] ==
                          FirebaseAuth.instance.currentUser?.uid) {
                        return Card(
                          child: ListTile(
                            title: Text(historyList[index]['result']),
                            subtitle: Text(
                                historyList[index]['time'].substring(0, 16)),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
