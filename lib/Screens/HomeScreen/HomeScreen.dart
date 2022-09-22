
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homeserviceprovider/firet/update_student_page.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreen> {
  final Stream<QuerySnapshot> studentsStream =
  FirebaseFirestore.instance.collection('students').snapshots();

  // For Deleting User
  CollectionReference students =
  FirebaseFirestore.instance.collection('students');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }
  List storedocsCopy = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Get.toNamed('/addpage');
            }, child: Text("ADD")),
            ElevatedButton(onPressed: (){
              Get.toNamed('/updatepage',arguments: storedocsCopy[0]["id"]);
            }, child: Text("Update")),
            StreamBuilder<QuerySnapshot>(
                stream: studentsStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print('Something went Wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final List storedocs = [];
                  storedocsCopy = storedocs;
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map a = document.data() as Map<String, dynamic>;
                    storedocs.add(a);
                    a['id'] = document.id;
                  }).toList();

                  print(storedocs);

                  if(snapshot.data != null){
                    print(storedocs.length);
                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: storedocs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: GestureDetector(
                              onTap: (){
                                Get.toNamed("detailspage",arguments: storedocs[index]['workers']);
                              },
                              child: Column(
                                children: [
                                ClipRRect(
                                  child: FadeInImage.assetNetwork(placeholder: "assets/images/logo.png", image: "${storedocs[index]['logo']}",fit: BoxFit.cover,width: 100,height: 100,),
                                ),
                                  Text("${storedocs[index]['title']}")
                                ],
                              ),
                            ),
                          );
                        },);
                  }
                  return CircularProgressIndicator();

                }),

               // ListView.builder(
               //   shrinkWrap: true,
               //    itemCount: 3,
               //    itemBuilder: (BuildContext context, int index) {
               //      return Text("sdf");
               //    },)


          ],
        ),
      ),
    );
  }
}
