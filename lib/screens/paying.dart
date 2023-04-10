import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mpos/modal/api.dart';
import 'package:mpos/screens/dashboard.dart';
import 'package:mpos/screens/login.dart';
import 'package:mpos/screens/payment_setup.dart';
import 'package:mpos/widgets/colors.dart';
import 'package:http/http.dart' as https;
import 'Failed.dart';
import 'done.dart';

class Paying extends StatefulWidget {
  const Paying({Key? key}) : super(key: key);

  @override
  State<Paying> createState() => PayingState();
}

class PayingState extends State<Paying> {
  static late var response;
  String totalAmount = Get.arguments.toString();


/*  static const methodChannel = MethodChannel('com.nfc.transaction/method');

  @override
  void initState() {
    super.initState();
    startNfcService();
  }

  Future startNfcService() async {
    var i = await methodChannel.invokeMethod('changeNfcService',{"text":"123"});
    print("$i");
  }*/

  // void transNumber() async {
  //   var data = await https.post(
  //       Uri.parse("$urlPayment/${PaymentSetupState.transData.transactionId}"),
  //       headers: {
  //         'Authorization': 'Bearer ${LoginPage.token}'
  //       },
  //       body: {
  //         "cardNo": "98976767676",
  //         "bankName": "Republic Bank",
  //       });
  //   print(data.body);
  //   // DashboardState().getUserData();
  // }

  void responseData(bool status) async {
    response = await https.post(Uri.parse(urlResponse), headers: {
      'Authorization': 'Bearer ${LoginPage.token}'
    }, body: {
      "transactionId": PaymentSetupState.transData.transactionId,
      "status": status ? "success" : "failed"
    });
    print("Response: " + response.body);
    DashboardState().getTransactionsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onLongPress: () {
          responseData(false);
          Get.off(Failed());
        },
        onDoubleTap: () {
          // transNumber();
          responseData(true);
          Get.off(Done());
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Stack(
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  color: primaryColor,

                  // decoration: BoxDecoration(
                  //   color: primaryColor,
                  //   borderRadius: BorderRadius.vertical(
                  //       bottom: Radius.elliptical(
                  //           MediaQuery.of(context).size.width, 100.0)),
                  // ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    "CAD ${Get.arguments}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Tap Card on Device",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const SpinKitPulse(
                        color: Colors.white,
                        duration: Duration(seconds: 1),
                        size: 160.0,
                      ),
                      const SpinKitPulse(
                        color: Colors.white,
                        duration: Duration(seconds: 1),
                        size: 120.0,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.contactless_rounded,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/visa.png"),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset("assets/mastercard.png"),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset("assets/americanexpress.png"),
                        /*  SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Image.asset("assets/bank.png"),
                        ),*/
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    // color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: const SpinKitThreeInOut(
                      color: primaryColor,
                      // duration: Duration(milliseconds: 600),
                      // size: 100.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
