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

class AdminAddDetails extends StatefulWidget {
  const AdminAddDetails({Key? key}) : super(key: key);

  @override
  _AdminAddDetailsState createState() => _AdminAddDetailsState();
}

List<String> serviceList = <String>[
  'Select',
  'Electronic Technician',
  'Plumbing',
  'Gardener',
  'Electrician',
  'Beautician',
  'Home Tutor',
  'Wall Painter',
  'Carpenter'
];
List<String> genderList = <String>['Select', 'Male', 'Female', "Others"];
List<String> jobtype = <String>["Select", "WFH", "Full Time", "Part Time"];

class _AdminAddDetailsState extends State<AdminAddDetails> {
  late DatabaseReference _dbref;

  String dropdownValueGender = genderList.first;
  String dropdownValueJobType = jobtype.first;
  String dropdownValueService = serviceList.first;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController availController = TextEditingController();
  TextEditingController prefLocationController = TextEditingController();
  TextEditingController thumbnailUrl = TextEditingController();
  String? genderValue;
  String? jobtypeValue;
  String? serviceValue;

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
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/${serviceNameController.value.text}')
            .putFile(file);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Icon(
          Icons.person_add_alt_1,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(hintText: "Address"),
                ),
                TextFormField(
                  controller: phoneNumber,
                  decoration: InputDecoration(hintText: "Phone Number"),
                ),
                TextFormField(
                  controller: pincodeController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(hintText: "Pincode"),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                TextFormField(
                  controller: availController,
                  decoration: InputDecoration(hintText: "Working Hour"),
                ),
                Row(
                  children: [
                    Text('Services :'),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton<String>(
                        value: dropdownValueService,
                        elevation: 10,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValueService = value!;
                            serviceValue = value;
                          });
                        },
                        items: serviceList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Gender :'),
                    SizedBox(
                      width: 20,
                    ),
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
                        items: genderList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Job Type :'),
                    SizedBox(
                      width: 30,
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
                        items: jobtype
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ],
                ),
                TextFormField(
                  controller: expController,
                  decoration: InputDecoration(hintText: "Experience"),
                ),
                TextFormField(
                  controller: prefLocationController,
                  decoration:
                      InputDecoration(hintText: "Prefered working area"),
                ),
                Visibility(
                    visible: imageUrl != '',
                    child: Container(
                        width: 100,
                        height: 100,
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/logo.png",
                          image: imageUrl,
                        ))),
                ElevatedButton(
                    onPressed: () {
                      if (nameController.value.text == '' ||
                          addressController.value.text == '' ||
                          pincodeController.value.text == '' ||
                          emailController.value.text == '' ||
                          phoneNumber.value.text == '' ||
                          serviceNameController.value.text == '' ||
                          expController.value.text == '' ||
                          availController.value.text == '' ||
                          prefLocationController.value.text == '' ||
                          jobtypeValue == null ||
                          genderValue == null ||
                          jobtypeValue == "Job Type" ||
                          genderValue == "Gender") {
                        Get.snackbar("ERROR",
                            "All the field are required to upload image",
                            backgroundColor: Colors.grey.withOpacity(0.5));
                      } else {
                        uploadImage();
                      }
                    },
                    child: Text("$_loading")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      _dbref = FirebaseDatabase.instance.ref("ehome");

                      if (nameController.value.text == '' ||
                          addressController.value.text == '' ||
                          pincodeController.value.text == '' ||
                          emailController.value.text == '' ||
                          phoneNumber.value.text == '' ||
                          expController.value.text == '' ||
                          availController.value.text == '' ||
                          prefLocationController.value.text == '' ||
                          serviceValue == null ||
                          jobtypeValue == null ||
                          genderValue == null ||
                          jobtypeValue == "Select" ||
                          genderValue == "Select" ||
                          serviceValue == "Select") {
                        Get.snackbar("ERROR", "All the field are required",
                            backgroundColor: Colors.grey.withOpacity(0.5));
                      } else {
                        Get.snackbar("Login", "uploaded",
                            backgroundColor: Colors.grey.withOpacity(0.5));
                        print("${jobtypeValue}");
                        // _dbref
                        //     .child("${serviceValue}")
                        //     .child("logo")
                        //     .set("${imageUrl}");
                        _dbref
                            .child("${serviceValue}")
                            .child("data")
                            .child("${phoneNumber.value.text}")
                            .set({
                          "name": "${nameController.value.text}",
                          "address": "${addressController.value.text}",
                          "phonenumber": "${phoneNumber.value.text}",
                          "pincode": "${pincodeController.value.text}",
                          "email": "${emailController.value.text}",
                          "servicetype": "${serviceValue}",
                          "gender": "${genderValue}",
                          "jobtype": "${jobtypeValue}",
                          "experience": "${expController.value.text}",
                          "workinghour": "${availController.value.text}",
                          "preferworkinglocation":
                              "${prefLocationController.value.text}",
                        });
                      }
                    },
                    child: Text("Submit")),
                SizedBox(
                  height: 20,
                ),
                Text("All the field are required")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
