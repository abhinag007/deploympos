// @dart=2.9

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mpos/screens/Failed.dart';
import 'package:mpos/screens/done.dart';
import 'screens/login.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

/*  static const methodChannel = MethodChannel('com.nfc.transaction/method');

  @override
  void initState() {
    startNfcService();
    print("Test android init");
  }

  Future startNfcService() async {
    await methodChannel.invokeMethod('startNfcService');
  }*/

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MPOS Transaction App',

      routes: {
    '/done': (context) => Done(),
    '/failed': (context) => Failed(),
    },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Paying(),
      // home: TransactionDetails(),
      home: LoginPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
