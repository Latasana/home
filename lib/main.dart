import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeserviceprovider/Screens/DetailsPage/details_page.dart';
import 'package:homeserviceprovider/Screens/HomeScreen/HomeScreen.dart';
import 'package:homeserviceprovider/Screens/Login/loginPhone.dart';
import 'package:homeserviceprovider/Screens/UnknownRoute.dart';
import 'package:homeserviceprovider/second/sdetails.dart';
import 'package:homeserviceprovider/second/second.dart';
import 'package:homeserviceprovider/second/workerdetails.dart';
import 'package:homeserviceprovider/workwithus/workwithus.dart';
import 'package:homeserviceprovider/workwithus/workwithusdetails.dart';
import 'package:homeserviceprovider/workwithus/wwuadminscreen.dart';
import 'Screens/DetailsPage/workers_details.dart';
import 'Screens/Login/LoginScreen.dart';
import 'Screens/LoginADMIN/loginadmin.dart';
import 'adminsecond/admin_adddetails.dart';
import 'firet/add_student_page.dart';
import 'firet/list_student_page.dart';
import 'firet/update_student_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoute()),
      initialRoute: '/loginscreen',
      getPages: [
        GetPage(
            name: '/loginscreen',
            page: () => LoginScreen(),
            transition: Transition.zoom),
        GetPage(
            name: '/Home',
            page: () => RealTimeDB(),
            transition: Transition.zoom),
        GetPage(
            name: "/loginphone",
            page: () => LoginPhone(),
            transition: Transition.zoom),
        GetPage(
            name: "/homescreen",
            page: () => HomeScreen(),
            transition: Transition.zoom),
        GetPage(
            name: "/detailspage",
            page: () => DetailsPage(),
            transition: Transition.zoom),
        GetPage(
            name: "/workersdetails",
            page: () => WorkersDetails(),
            transition: Transition.zoom),
        GetPage(
            name: "/addpage",
            page: () => AddStudentPage(),
            transition: Transition.zoom),
        GetPage(
            name: "/updatepage",
            page: () => UpdateStudentPage(),
            transition: Transition.zoom),
        GetPage(
            name: "/sdetails",
            page: () => Sdetails(),
            transition: Transition.zoom),
        GetPage(
            name: "/workerdetails",
            page: () => WorkerDetails(),
            transition: Transition.zoom),
        GetPage(
            name: "/workwithusdetails",
            page: () => WorkWithUsDetails(),
            transition: Transition.zoom),
        GetPage(
            name: "/loginadmin",
            page: () => LoginPhoneADMIN(),
            transition: Transition.zoom),
        GetPage(
            name: "/adminadddetails",
            page: () => AdminAddDetails(),
            transition: Transition.zoom),
        GetPage(
            name: "/workwithus",
            page: () => WorkWithUs(),
            transition: Transition.zoom),
        GetPage(
            name: "/wwuadminscreen",
            page: () => WWUAdminScreen(),
            transition: Transition.zoom),
        GetPage(
            name: "/add",
            page: () => AddStudentPage(),
            transition: Transition.zoom)
      ],
    );
  }
}
