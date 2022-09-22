import 'package:animated_background/animated_background.dart';
import 'package:animated_background/particles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_widget/ticket_widget.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginPhone extends StatefulWidget {
  @override
  _LoginPhoneState createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;



  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  String PhoneNumber = "0";

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = '';

  bool showLoading = false;

  saveData(phone)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("phonePrimary", phone);
    prefs.setString("usertype", "user");
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
       Get.snackbar("Login","You have login successfully",backgroundColor: Colors.grey.withOpacity(0.5));
       // Obtain shared preferences.
      saveData(PhoneNumber);
       Get.offAndToNamed("/Home",arguments: "user");


        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

    //  _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text("s")));
    }
  }
  @override
  initState(){
    phoneController.text = "+91";
  }
  getMobileFormWidget(context) {

    return TicketWidget(
      width: 350,
      height: 450,
      isCornerRounded: true,
      padding: EdgeInsets.all(20),
      child: Column(
        
        children: [
          Spacer(),
          Image.asset("assets/images/logo.png",fit: BoxFit.cover,width:100,height: 100),
          SizedBox(
            height: 50,
          ),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(),
              hintText: "",
            ),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: ()async{
              setState(() {
                showLoading = true;
              });

              PhoneNumber = phoneController.text;

              await _auth.verifyPhoneNumber(
                phoneNumber: phoneController.text,
                verificationCompleted: (phoneAuthCredential) async {
                  setState(() {
                    showLoading = false;
                  });
                  //signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                verificationFailed: (verificationFailed) async {
                  setState(() {
                    showLoading = false;
                  });
                  // _scaffoldKey.currentState
                  //     ?.showSnackBar(SnackBar(content: Text("as")));
                },
                codeSent: (verificationId, resendingToken) async {
                  setState(() {
                    showLoading = false;
                    currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Send",style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(width: 5,),
                    Icon(Icons.send,color: Colors.green,)
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  getOtpFormWidget(context) {
    return TicketWidget(
      width: 350,
      height: 450,
      isCornerRounded: true,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Spacer(),
          Icon(Icons.security,size: 100,color: Colors.green,),
          SizedBox(height: 50,),
          TextFormField(

            controller: otpController,
            decoration: InputDecoration(
              labelText: "OTP",
              border: OutlineInputBorder(),
              hintText: "Enter OTP",
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () async {
              PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: otpController.text);

              signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            child: Text("VERIFY"),
          ),
          Spacer(),
        ],
      ),
    );
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
        key: _scaffoldKey,
        body: Center(
          child: Container(
            child: showLoading
                ? Center(
              child: SpinKitSquareCircle(
                color: Colors.amber,
              ),
            )
                : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
            padding: const EdgeInsets.all(16),
          ),
        ));
  }
}
