import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RealTimeDB extends StatefulWidget {
  const RealTimeDB({Key? key}) : super(key: key);

  @override
  State<RealTimeDB> createState() => _RealTimeDBState();
}

class _RealTimeDBState extends State<RealTimeDB> {
  late DatabaseReference _dbref;
  late DatabaseReference _dbrefPost;
  String databaseString = "";
  String PhoneNumber ='';
  @override
  void initState() {
    super.initState();
  _dbref = FirebaseDatabase.instance.ref("ehome");
    // _dbrefPost = _dbref.push();
  }


  // List titleList = [];
  // List logoList = [];
  // List sdetails = [];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    SimpleBuilder(
      builder: (BuildContext) {
        late DatabaseReference _dbref;
        _dbref = FirebaseDatabase.instance.ref("ehome");
        List titleList = [];
        List logoList = [];
        List sdetails = [];

        return StreamBuilder(
          stream: _dbref.onValue,
          builder: (context, snapshot) {
            List messageList = [];
            if (snapshot.hasData &&
                snapshot.data != null &&
                (snapshot.data! as DatabaseEvent).snapshot.value != null) {
              final myMessages = Map<dynamic, dynamic>.from(
                  (snapshot.data! as DatabaseEvent).snapshot.value
                      as Map<dynamic, dynamic>);
              titleList = [];
              logoList = [];
              sdetails = [];
              //typecasting
              // myMessages.forEach((key, value) {
              //   titleList.add(key);
              //   final currentMessage = Map<String, dynamic>.from(value);
              //   messageList.add(currentMessage);
              // }); //created a class called message and added all messages in a List of class message

              myMessages.forEach((key, value) {
                titleList.add(key); //get title
                logoList.add(myMessages[key]["logo"]); //get logo
                sdetails.add(myMessages[key]["data"]);
              });
              print("Sdetails  ${sdetails}");
              print("Sdetails  ${sdetails.length}");
              // Get.arguments.forEach((key, value) {
              //   detailList.add(value);
              // });

              return ListView.builder(
                shrinkWrap: true,
                itemCount: titleList.length,
                itemBuilder: (context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("sdetails", arguments: [titleList[index],sdetails[index]]);
                      },
                      child: Card(
                          child: Stack(
                        fit: StackFit.loose,
                        children: [
                          Center(
                              child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/applogo.png",
                            image: logoList[index],
                            fit: BoxFit.cover,
                            height: 200,
                          )),
                          Positioned(
                              bottom: 10,
                              left: 50,
                              right: 50,
                              child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.amber,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${titleList[index]}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )))
                        ],
                      )),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: SpinKitSquareCircle(
                  color: Colors.amber,
                ),
              );
            }
          },
        );
      },
    ),
    Text(
      'Explorer coming soon!!!',
      style: optionStyle,
    ),
    SimpleBuilder(builder: (BuildContext ) {
      String? usertype;
      Future<String> checkLogin()async{
        final prefs = await SharedPreferences.getInstance();
        String checkString = prefs.getString("phonePrimary").toString();
         usertype = prefs.getString("usertype").toString();
        return checkString;
      }

      return FutureBuilder(
        future: checkLogin(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.data != null){
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),color: Colors.white
              ),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,

                      ),
                      child: Image.asset("assets/images/logo.png",width: 100,height: 100,)),
                  Container(
                    child: Center(child: Text("${snapshot.data}",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),)),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width:(MediaQuery.of(context).size.width /4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)
          ),
                    child: Center(child: Padding(
                      padding:EdgeInsets.all(5),
                      child: Text("${usertype}",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),),
                    )),
                  ),
                  SizedBox(height: 30,),
                  ElevatedButton(onPressed: ()async{
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString("phonePrimary", 'null');
                    prefs.setString("usertype", 'null');
                    Get.offAndToNamed("loginscreen");
                  }, child: Text("LOGOUT"))
                ],
              ),
            );
          }
          return SpinKitSquareCircle(
            color: Colors.amber,
          );
        },);
    },

    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  late DatabaseReference _dbrefADMIN;
  TextEditingController phoneNum = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/applogo.png",
          fit: BoxFit.fitHeight,
          width: 60,
        ),
        centerTitle: true,
        actions: [
          Visibility(
            visible: Get.arguments == "user",
            child: Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                    onTap: (){
                      Get.toNamed("workwithus");
                    },
                    child: Icon(Icons.work,color: Colors.black,))),),
          Visibility(
            visible: Get.arguments == "admin",
            child: Padding(
                padding: EdgeInsets.all(5),
                child: GestureDetector(
                    onTap: (){
                      Get.toNamed("wwuadminscreen");
                    },
                    child: Icon(Icons.notifications,color: Colors.black,))),),
          Visibility(
            visible: Get.arguments == "admin",
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                      onTap: (){
                        Get.toNamed("adminadddetails");
                      },
                      child: Icon(Icons.person_add,color: Colors.black,))),),
          Visibility(
            visible: Get.arguments == "admin",
            child: Padding(
                padding: EdgeInsets.all(5),
                child: GestureDetector(
                    onTap: (){
                      phoneNum.text = "+91";
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Add Admin'),
                            content: TextField(
                              controller: phoneNum,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                labelText: "Phone Number",
                                border: OutlineInputBorder(

                                )
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('ADD'),
                                onPressed: () {


                                  _dbrefADMIN = FirebaseDatabase.instance.ref("ehomeADMIN");
                                  _dbrefADMIN.child("${phoneNum.value.text}").set("{'val' : 'true'}");

                                  Navigator.of(context).pop();
                                },
                              ),

                            ],
                          );
                        },
                      );
                    },
                    child: Icon(Icons.admin_panel_settings,color: Colors.black,))),)
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explorer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

}
