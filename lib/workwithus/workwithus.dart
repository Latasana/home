import 'dart:ffi';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkWithUs extends StatefulWidget {
  const WorkWithUs({Key? key}) : super(key: key);

  @override
  _WorkWithUsState createState() => _WorkWithUsState();
}
List<String> serviceList = <String>['One', 'Two', 'Three', 'Four'];
List<String> genderList = <String>['Gender','Male','Female',"Others"];
List<String> jobtype = <String>["Job Type","WFH","Full Time","Part Time"];
class _WorkWithUsState extends State<WorkWithUs> {

  late DatabaseReference _dbref;

  String dropdownValueGender = genderList.first;
  String dropdownValueJobType = jobtype.first;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  //TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController availController = TextEditingController();
  TextEditingController prefLocationController = TextEditingController();
  TextEditingController thumbnailUrl = TextEditingController();
  String? genderValue;
  String? jobtypeValue;

  String imageUrl = '';
  String _loading = 'Upload';

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
        await _firebaseStorage.ref().child('images/${serviceNameController.value.text}').putFile(file);
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
  String phoneNumber = '';
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getphone();
  }

  getphone()async{
    final prefs = await SharedPreferences.getInstance();
   // phoneNumber = prefs.getString("phonePrimary").toString();
    phoneNumber = "+911234567890";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("WORK WITH US",style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Name"
                  ),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                      hintText: "Address"
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("Phone number: $phoneNumber",style: TextStyle(color: Colors.black),)),
                TextFormField(
                  controller: pincodeController,
                  keyboardType:TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      hintText: "Pincode"
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType:TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                ),
                TextFormField(
                  controller: serviceNameController,
                  decoration: InputDecoration(
                      hintText: "Service Type"
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                        value: dropdownValueGender,
                        elevation: 10,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValueGender = value!;
                            genderValue = value;
                          });
                        },

                        items: genderList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                        value: dropdownValueJobType,
                        elevation: 10,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValueJobType = value!;
                            jobtypeValue = value;
                          });
                        },
                        items: jobtype.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ],
                ),
                TextFormField(
                  controller: expController,
                  decoration: InputDecoration(
                      hintText: "Experience"
                  ),
                ),
                TextFormField(
                  controller: availController,
                  decoration: InputDecoration(
                      hintText: "Avaibility"
                  ),
                ),
                TextFormField(
                  controller: prefLocationController,
                  decoration: InputDecoration(
                      hintText: "Prefered working area"
                  ),
                ),
                // Visibility(
                //     visible: imageUrl != '',
                //     child: Container(
                //         width: 100,
                //         height: 100,
                //         child: FadeInImage.assetNetwork(placeholder: "assets/images/logo.png", image: imageUrl,))),
                //
                // ElevatedButton(onPressed: (){
                //   if(
                //   nameController.value.text == '' ||
                //       addressController.value.text == '' ||
                //       pincodeController.value.text == '' ||
                //       emailController.value.text == '' ||
                //       phoneNumber == '' ||
                //       serviceNameController.value.text == '' ||
                //       expController.value.text == '' ||
                //       availController.value.text == '' ||
                //       prefLocationController.value.text == '' ||
                //       jobtypeValue == null ||
                //       genderValue == null ||
                //       jobtypeValue == "Job Type" || genderValue == "Gender"
                //   ){
                //     Get.snackbar("ERROR","All the field are required to upload image",backgroundColor: Colors.grey.withOpacity(0.5));
                //   }else{
                //     uploadImage();
                //   }
                //
                // }, child: Text("$_loading")),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  _dbref = FirebaseDatabase.instance.ref("ehomeWWU");

                  if(
                  nameController.value.text == '' ||
                      addressController.value.text == '' ||
                      pincodeController.value.text == '' ||
                      emailController.value.text == '' ||
                      phoneNumber == '' ||
                      serviceNameController.value.text == '' ||
                      expController.value.text == '' ||
                      availController.value.text == '' ||
                      prefLocationController.value.text == '' ||
                    //  imageUrl == '' ||
                      jobtypeValue == null ||
                      genderValue == null ||
                      jobtypeValue == "Job Type" || genderValue == "Gender"

                  ){
                    Get.snackbar("ERROR","All the field are required",backgroundColor: Colors.grey.withOpacity(0.5));
                  }
                  else{
                    Get.snackbar("Login","You have uploaded successfully",backgroundColor: Colors.grey.withOpacity(0.5));
                    print("${jobtypeValue}");
                    // _dbref.child("${serviceNameController.value.text}").child("logo").set(
                    //     "${imageUrl}");
                    _dbref
                        .child("WWU")
                        .child("data")
                        .child("${phoneNumber}")
                        .set(
                        {
                          "name": "${nameController.value.text}",
                          "address": "${addressController.value.text}",
                          "phonenumber": "${phoneNumber}",
                          "pincode": "${pincodeController.value.text}",
                          "email": "${emailController.value.text}",
                          "servicetype": "${serviceNameController.value.text}",
                          "gender": "${genderValue}",
                          "jobtype": "${jobtypeValue}",
                          "experience": "${expController.value.text}",
                          "workinghour": "${availController.value.text}",
                          "preferworkinglocation": "${prefLocationController.value.text}",
                        //  "thumbnail": "${imageUrl}",
                        });
                  }

                }, child: Text("Submit")),
                SizedBox(height: 20,),
                Text("All the field are required")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
