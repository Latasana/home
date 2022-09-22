
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  AddStudentPage({Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var email = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  // Adding Student
  CollectionReference students =
  FirebaseFirestore.instance.collection('students');

  // Future<void> addUser() {
  //   return students
  //       .add({'name': name, 'email': email, 'password': password})
  //       .then((value) => print('User Added'))
  //       .catchError((error) => print('Failed to Add user: $error'));
  // }
  Future<void> addUser() {
    return students
       .doc("7005807751")
        .update(
        {
          "title" : "Plumbing" ,
          "logo": "https://firebasestorage.googleapis.com/v0/b/ehomeservice-722a5.appspot.com/o/plumber.jpg?alt=media&token=99b884f6-ee01-43b3-be4e-28e15123da94",
          "workers" : [
            {"name":"gunjju","status":"false"},
            {"name":"asd","status":"false"}
          ]
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Student"),
      ),
      body: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.

              addUser();
            },
            child: Text(
              'Register',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }
}
