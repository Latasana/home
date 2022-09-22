import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: Get.arguments.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed("/workersdetails",arguments: Get.arguments[index]);
                    },
                    child: Card(
                      child: ListTile(
                        leading: Text(Get.arguments[index]["name"].toString()),
                        title: Text(Get.arguments[index]["experience"].toString()),
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ),
      ),
    );
  }
}
