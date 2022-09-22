import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {


  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  var list = [
    {"name":"gunjju","status":"false"}
  ];

  Future<void> updateUser() {
    return students
        .doc('7005807751')
        .update({'workers': FieldValue.arrayUnion(list)
        }
        )
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
      ),
      body:Center(
        child:  ElevatedButton(
          onPressed: () => {
            updateUser()
          },
          child: Text(
            'Update',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      )
    );
  }
}
