import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:get/get.dart';
import 'package:mpos/modal/api.dart';
import 'package:mpos/screens/dashboard.dart';
import 'package:mpos/screens/login.dart';
import 'package:mpos/widgets/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<Color> gradientColors = [primaryColor, secondaryColor];

  static TextEditingController emailController = TextEditingController();
  static TextEditingController mobileNumberController = TextEditingController();
  static TextEditingController organizationNameController =
      TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: -50,
                      // width: 350,
                      // height: 350,
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [primaryColor, secondaryColor]),
                            shape: BoxShape.circle),
                      ),
                    ),
                    Positioned(
                      left: -170,
                      bottom: 150,
                      // width: 350,
                      // height: 350,
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [primaryColor, secondaryColor]),
                            shape: BoxShape.circle),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          const Text(
                            "Signup",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Create your account",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                makeInput(
                                  organizationNameController,
                                  label: "Organization's Name",
                                ),
                                makeInput(mobileNumberController,
                                    label: "Phone Number", phoneNumber: true),
                                makeInput(emailController, label: "Email"),
                                makeInput(passwordController,
                                    label: "Password", obsecureText: true),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
                                    if (organizationNameController.text
                                            .toString()
                                            .isNotEmpty ||
                                        mobileNumberController.text
                                            .toString()
                                            .isNotEmpty ||
                                        emailController.text
                                            .toString()
                                            .isNotEmpty ||
                                        passwordController.text
                                            .toString()
                                            .isNotEmpty) {
                                      register(
                                          organizationNameController.text
                                              .toString(),
                                          mobileNumberController.text
                                              .toString(),
                                          emailController.text.toString(),
                                          passwordController.text.toString());
                                    } else {
                                      Get.snackbar(
                                          "Error", "Enter Value in all fields");
                                    }
                                    setState(() {});
                                    // Get.off(const Dashboard());
                                  },
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Text(
                                    "Signup",
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
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already Have an Account? "),
                              GestureDetector(
                                onTap: () => Get.offAll(LoginPage()),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput(TextEditingController myController,
      {label, obsecureText = false, phoneNumber = false}) {
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
          keyboardType: phoneNumber == true
              ? TextInputType.phone
              : TextInputType.emailAddress,
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

  Future<void> register(
      String orgName, String phoneNumber, String email, String password) async {
    try {
      var response = await https.post(Uri.parse(urlRegister), body: {
        "mobileNumber": phoneNumber,
        "email": email,
        "password": password,
        "businessName": orgName
      });

      if (response.statusCode == 200) {
        print(response.body);
        organizationNameController.clear();
        mobileNumberController.clear();
        emailController.clear();
        passwordController.clear();
        Get.offAll(const LoginPage());
      } else {
        print(response.body);
        Get.snackbar("Error", "Something Went Wrong!");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

// Landing Page -  Transaction, Amount, tax, tax amount, card wise breakup, DateWise Breakup, Canadian Dollar
// Request -> Proceed, American Express, Euro Pay, CAD, Merchant name and unique Id, And Unique Number For Transaction
