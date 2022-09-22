import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkWithUsDetails extends StatefulWidget {

  @override
  State<WorkWithUsDetails> createState() => _WorkWithUsDetailsState();
}

class _WorkWithUsDetailsState extends State<WorkWithUsDetails> {
  late DatabaseReference _dbref;


  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  String imageUrl = '';
  String OldimageUrl = '';
  String togglestatus = 'x';
  String _loading = 'Upload';
  List a = [];

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile? image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image  .getImage(source: ImageSource.gallery);
      // image = await _imagePicker.pickImage(source: source)
      final XFile? image =
      await _imagePicker.pickImage(source: ImageSource.gallery);
      var file = File(image!.path);

      setState(() {
        _loading = "Uploading...";
      });
      if (image != null) {
        //Upload to Firebase
        var snapshot =
        await _firebaseStorage.ref().child('images/${Get.arguments["servicetype"]}').putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
          _loading = "Uploaded";
        });
        print("$imageUrl");
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbref = FirebaseDatabase.instance.ref("ehome");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Details",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if(togglestatus != "x") {
                _dbref.child("${Get.arguments["servicetype"]}")
                    .child("logo")
                    .set(
                    "${imageUrl}");
                _dbref
                    .child("${Get.arguments["servicetype"]}")
                    .child("data")
                    .child("${Get.arguments["phonenumber"]}")
                    .set(
                    {
                      "name": "${Get.arguments["name"]}",
                      "address": "${Get.arguments["address"]}",
                      "phonenumber": "${Get.arguments["phonenumber"]}",
                      "pincode": "${Get.arguments["pincode"]}",
                      "email": "${Get.arguments["email"]}",
                      "servicetype": "${Get.arguments["servicetype"]}",
                      "gender": "${Get.arguments["gender"]}",
                      "jobtype": "${Get.arguments["servicetype"]}",
                      "experience": "${Get.arguments["experience"]}",
                      "workinghour": "${Get.arguments["workinghour"]}",
                      "preferworkinglocation": "${Get
                          .arguments["preferworkinglocation"]}",
                    }).then((value) {
                  late DatabaseReference _dbref;
                  _dbref = FirebaseDatabase.instance.ref("ehomeWWU");
                  _dbref
                      .child("WWU")
                      .child("data")
                      .child(Get.arguments["phonenumber"]).remove();
                  Navigator.pop(context);
                });
              }else{
                Get.snackbar("ERROR","Upload the logo",backgroundColor: Colors.grey.withOpacity(0.5));
              }

            },
            backgroundColor: Colors.green,
            child: Icon(Icons.done),),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              late DatabaseReference _dbref;
              _dbref = FirebaseDatabase.instance.ref("ehomeWWU");
              _dbref
                  .child("WWU")
                  .child("data")
                  .child(Get.arguments["phonenumber"]).remove();
              Navigator.pop(context);
            },
            backgroundColor: Colors.red,
            child: Icon(Icons.close),),
        ],
      ),
      body: SafeArea(
        child: Center(child:
        SingleChildScrollView(
          child: Column(
            children: [
            StreamBuilder(
            stream: _dbref.onValue,
            builder: (context, snapshot) {
              List messageList = [];
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  (snapshot.data! as DatabaseEvent).snapshot.value != null) {
                final myMessages = Map<dynamic, dynamic>.from(
                    (snapshot.data! as DatabaseEvent).snapshot.value
                    as Map<dynamic, dynamic>);

                a.add(myMessages);

                try {
                  OldimageUrl = a[0][Get.arguments["servicetype"]]["logo"];
                  togglestatus = OldimageUrl;
                }catch(e){
                  OldimageUrl = 'null';
                  togglestatus = "null";
                }
                print(OldimageUrl);

                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            child: Visibility(
                                visible: imageUrl != '',
                                child: CircleAvatar(child: FadeInImage.assetNetwork(placeholder: "assets/images/logo.png", image: imageUrl,))),),
                          ElevatedButton(onPressed: OldimageUrl == "null" ? (){
                            uploadImage();
                          } : null
                          , child: Text(_loading))
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Name: ${Get.arguments["name"]}")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Address: ${Get.arguments["address"]}")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Email: ${Get.arguments["email"]}")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Gender: ${Get.arguments["gender"]}")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Job type: ${Get.arguments["jobtype"]}")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Phone: ${Get.arguments["phonenumber"]}")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Pincode: ${Get.arguments["pincode"]}")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Location: ${Get.arguments["preferworkinglocation"]}")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Service: ${Get.arguments["servicetype"]}")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 50,
                            child:Center(child: Text("Working time: ${Get.arguments["workinghour"]}")),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                );


                // myMessages.forEach((key, value) {
                //   titleList.add(key);
                //   final currentMessage = Map<String, dynamic>.from(value);
                //   messageList.add(currentMessage);
                // }); //created a class called message and added all messages in a List of class message

                // myMessages.forEach((key, value) {
                //   titleList.add(key); //get title
                //   logoList.add(myMessages[key]["logo"]); //get logo
                //   sdetails.add(myMessages[key]["data"]);
                // });
                // print("Sdetails  ${sdetails}");
                // print("Sdetails  ${sdetails.length}");
                // // Get.arguments.forEach((key, value) {
                // //   detailList.add(value);
                // // });

              }
              return Container();
            },
          ),
            ],
          ),
        )),
      ),
    );
  }
}
