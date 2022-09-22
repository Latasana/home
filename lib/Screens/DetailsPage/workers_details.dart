import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WorkersDetails extends StatelessWidget {
  const WorkersDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Get.arguments["name"]),
              Text(Get.arguments["contact"]),
              Text(Get.arguments["address"]),
              Text(Get.arguments["gender"]),
            ],
          ),
        ),
      ),
    );
  }
}
