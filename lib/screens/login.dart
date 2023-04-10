import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mpos/modal/api.dart';
import 'package:mpos/screens/dashboard.dart';
import 'package:mpos/screens/signup.dart';
import 'package:http/http.dart' as https;
import 'package:mpos/widgets/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static late String token;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  List<Color> gradientColors = [primaryColor, secondaryColor];
  static bool isLoading = false;

  static TextEditingController usernameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();


/*  static const methodChannel = MethodChannel('com.nfc.transaction/method');

  @override
  void initState() {
    startNfcService();
    print("Test android init");
  }

  Future startNfcService() async {
    await methodChannel.invokeMethod('startNfcService');
  }*/

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: secondaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Loading",
                  style: TextStyle(color: primaryColor),
                ),
              ],
            )),
          )
        : GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: 90,
                          ),
                          const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Login to your account",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                makeInput(usernameController,
                                    label: "Email / Phone Number"),
                                makeInput(passwordController,
                                    label: "Password", obsecureText: true),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              padding: const EdgeInsets.only(top: 3, left: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: const Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                ),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: gradientColors,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: () {
                                    // isLoading = true;
                                    if (usernameController.text
                                            .toString()
                                            .isNotEmpty ||
                                        passwordController.text
                                            .toString()
                                            .isNotEmpty) {
                                      login(usernameController.text.toString(),
                                          passwordController.text.toString());
                                    } else {
                                      Get.snackbar("Empty Field",
                                          "Please Enter All Fields");
                                    }
                                    // Get.off(const Dashboard());
                                  },
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already Have an Account? "),
                              GestureDetector(
                                onTap: () => Get.offAll(const SignUp()),
                                child: const Text(
                                  "Signup",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 220,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/img.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   height: MediaQuery.of(context).size.height / 3,
                      //   decoration: const BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/illustrate.jpg'),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget makeInput(TextEditingController myController,
      {label, obsecureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: myController,
          obscureText: obsecureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Future<void> login(String emailOrPhone, String password) async {
    try {
      print(emailOrPhone + "  " + password);
      var response = await https.post(Uri.parse(urlLogin),
          body: {"username": emailOrPhone, "password": password});
      print(response.statusCode);

      if (response.statusCode == 200) {
        setState(() {
          // isLoading = true;
          var data = jsonDecode(response.body);
          LoginPage.token = data["accessToken"];
        });
        await DashboardState().update();

        print("Token: " + LoginPage.token);
        // const CircularProgressIndicator(
        //   color: primaryColor,
        // );
        // await Future.delayed(Duration(seconds: 1));

        usernameController.clear();
        passwordController.clear();
        // Future.delayed(const Duration(seconds: 2), () {

        Get.off(Get.offAll(const Dashboard()));
        // });
      } else if (response.statusCode == 404) {
        print(response.body);
        Get.snackbar("Error", "Something Went Wrong");
      } else {
        Get.snackbar("Error", "Please check your field");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
