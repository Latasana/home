import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sdetails extends StatefulWidget {
  const Sdetails({Key? key}) : super(key: key);

  @override
  State<Sdetails> createState() => _SdetailsState();
}
class _SdetailsState extends State<Sdetails> {

  List workerList = [];
  List workerdetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.arguments[1].forEach((key,value){
      workerList.add(key);
      workerdetails.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${Get.arguments[0]}",style: TextStyle(
          color: Colors.black
        ),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: ListView.builder(
            itemCount: workerList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: (){
                    Get.toNamed("workerdetails",arguments: workerdetails[index]);
                  },
                  child: Card(
                    child: Container(

                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.black,child: Icon(Icons.account_circle,color: Colors.amber,)),
                          title: Text("${workerdetails[index]["name"]}"),
                        )),
                  ));
            },)
        ),
      ),
    );
  }
}
