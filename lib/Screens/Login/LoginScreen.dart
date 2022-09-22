import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_widget/ticket_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin  {



  checkLogin()async{
    final prefs = await SharedPreferences.getInstance();
    final checkString = prefs.getString("phonePrimary");
    final usertype = prefs.getString("usertype");
    if(checkString != 'null' && usertype == "admin"){
      Get.offAndToNamed("/Home",arguments: "admin");
    }else if(checkString != 'null'){
      Get.offAndToNamed("/Home",arguments: "user");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  ParticleOptions particles = const ParticleOptions(
    baseColor: Colors.cyan,
    spawnOpacity: 0.9,
    opacityChangeRate: 0.25,
    minOpacity: 0.4,
    maxOpacity: 0.5,
    particleCount: 30,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );

  @override
  Widget build(BuildContext context) {

    final xsize = MediaQuery.of(context).size;
    return AnimatedBackground(
        behaviour: RandomParticleBehaviour(options: particles),
      vsync: this,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        body: Center(
          child: TicketWidget(
            width: 350,
            height: 300,
            isCornerRounded: true,
            padding: EdgeInsets.all(20),
            child: TicketData(xsize: xsize,),
          ),
        ),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key? key,
    required this.xsize,
  }) : super(key: key);

  final Size xsize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.asset("assets/images/logo.png",fit: BoxFit.cover,width: xsize.width * 0.2,height: xsize.width * 0.2,),
          ),
          SizedBox(
            height: xsize.width * 0.1,
          ),
          SizedBox(
            height: xsize.width * 0.1,
          ),
          GestureDetector(
              onTap: (){
                Get.toNamed("/loginphone");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login using Phone",style: TextStyle(fontWeight: FontWeight.w500),),
                      Icon(Icons.phone_android)
                    ],
                  ),
                )
              ),
      ),SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed("/loginadmin");
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login as ADMIN",style: TextStyle(fontWeight: FontWeight.w500),),
                      Icon(Icons.admin_panel_settings)
                    ],
                  ),
                )
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
