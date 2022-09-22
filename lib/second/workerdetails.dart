import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerDetails extends StatelessWidget {
  const WorkerDetails({Key? key}) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          launch("tel://${Get.arguments["phonenumber"]}");
        },
        backgroundColor: Colors.amber,
        child: Icon(Icons.call),
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.account_box,
                      size: 30,
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child:
                          Center(child: Text("Name: ${Get.arguments["name"]}")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child: Text("Address: ${Get.arguments["address"]}")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child: Text("Email: ${Get.arguments["email"]}")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child: Text("Gender: ${Get.arguments["gender"]}")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child: Text("Job type: ${Get.arguments["jobtype"]}")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child: Text(
                              "Experience: ${Get.arguments["experience"]}")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child:
                              Text("Phone: ${Get.arguments["phonenumber"]}")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child: Text("Pincode: ${Get.arguments["pincode"]}")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child: Text(
                              "Location: ${Get.arguments["preferworkinglocation"]}")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child:
                              Text("Service: ${Get.arguments["servicetype"]}")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 50,
                      child: Center(
                          child: Text(
                              "Working time: ${Get.arguments["workinghour"]}")),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
