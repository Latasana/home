import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/simple_builder.dart';

class WWUAdminScreen extends StatefulWidget {
  const WWUAdminScreen({Key? key}) : super(key: key);

  @override
  _WWUAdminScreenState createState() => _WWUAdminScreenState();
}

class _WWUAdminScreenState extends State<WWUAdminScreen> {
  List workerList = [];
  List workerdetails = [];
  List logocheck = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Request list",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // actions: [
        // Center(
        //   child: GestureDetector(
        //     onTap: (){
        //       late DatabaseReference _dbref;
        //       _dbref = FirebaseDatabase.instance.ref("ehomeWWU");
        //       _dbref
        //           .child("WWU")
        //           .child("data")
        //           .child("+911234567890").remove();
        //     },
        //     child: Text("sdf",style: TextStyle(
        //       fontSize: 20,
        //       color: Colors.black
        //     ),),
        //   ),
        // )
        // ],
      ),
      body: SafeArea(
        child: SimpleBuilder(
          builder: (BuildContext) {
            late DatabaseReference _dbref;
            _dbref = FirebaseDatabase.instance.ref("ehomeWWU");

            List titleList = [];
            //  List logoList = [];
            List sdetails = [];

            return StreamBuilder(
              stream: _dbref.onValue,
              builder: (context, snapshot) {
                List messageList = [];
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    (snapshot.data! as DatabaseEvent).snapshot.value != null) {
                  final myMessages = Map<dynamic, dynamic>.from(
                      (snapshot.data! as DatabaseEvent).snapshot.value
                          as Map<dynamic, dynamic>);
                  titleList = [];
                  //  logoList = [];
                  sdetails = [];
                  //typecasting
                  // myMessages.forEach((key, value) {
                  //   titleList.add(key);
                  //   final currentMessage = Map<String, dynamic>.from(value);
                  //   messageList.add(currentMessage);
                  // }); //created a class called message and added all messages in a List of class message
                  myMessages.forEach((key, value) {
                    titleList.add(key); //get title
                    // logoList.add(myMessages[key]["logo"]); //get logo
                    print(key.toString());
                    sdetails.add(myMessages[key]["data"]);
                  });

                  // logocheck.add(myMessages);
                  // print("XXXXXXXXXXXXXXXXXX ${logocheck[0]["Cleaner"]["logo"]}");

                  print("Sdetails  ${sdetails}");
                  // print("Sdetails  ${sdetails[0].length}");
                  workerList = [];
                  workerdetails = [];
                  sdetails[0].forEach((key, value) {
                    workerList.add(key);
                    workerdetails.add(value);
                  });

                  // Get.arguments.forEach((key, value) {
                  //   detailList.add(value);
                  // });

                  return Container(
                    child: Center(
                        child: ListView.builder(
                      itemCount: workerList.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                            onTap: () {
                              Get.toNamed("workwithusdetails",
                                  arguments: workerdetails[index]);
                            },
                            child: Card(
                              child: Container(
                                  child: ListTile(
                                leading: const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.account_circle,
                                      color: Colors.amber,
                                    )),
                                title: Text("${workerdetails[index]["name"]}"),
                              )),
                            ));
                      },
                    )),
                  );
                } else {
                  return Center(
                    child: SpinKitSquareCircle(
                      color: Colors.amber,
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
