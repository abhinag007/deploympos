import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mpos/components/appbar.dart';
import 'package:mpos/components/appbar_back.dart';
import 'package:mpos/screens/MerchantWallet.dart';
import 'package:mpos/screens/dashboard.dart';
import 'package:mpos/screens/login.dart';
import 'package:mpos/screens/paying.dart';
import 'package:http/http.dart' as https;

import 'package:mpos/widgets/colors.dart';

import '../modal/TransactionModel.dart';
import '../modal/api.dart';
import 'MerchantAccountSetup.dart';
import 'MerchantBusinessDetails.dart';

class PaymentSetup extends StatefulWidget {
  const PaymentSetup({Key? key}) : super(key: key);

  @override
  PaymentSetupState createState() => PaymentSetupState();
}

class PaymentSetupState extends State<PaymentSetup> {
  static late TransactionModel transData;

  static TextEditingController amountController = TextEditingController();
  static TextEditingController taxController = TextEditingController();
  late double amount = 0.0, tax = 0.0;
  static double totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    amountController.clear();
    taxController.clear();
    super.dispose();
  }

  void doPayment() async {
    var response = await https.post(Uri.parse(urlPayment), headers: {
      'Authorization': 'Bearer ${LoginPage.token}'
    }, body: {
      "amount": amountController.text,
      "tax": taxController.text,
    });
    var decodeResponse = jsonDecode(response.body);
    Map<String, dynamic> userData = decodeResponse;
    transData = TransactionModel.fromJson(userData);
    print("ID: " + transData.transactionId);
    // DashboardState().getUserData();
    makePayment();
  }

  void makePayment() async {
    var response = await https.post(
        Uri.parse(urlPayment + "/${transData.transactionId}"),
        headers: {'Authorization': 'Bearer ${LoginPage.token}'},
        body: {"cardNo": "12345", "bankName": "RBI"});
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Material(
          elevation: 20,
          child: SizedBox(
            width: double.infinity,
            height: 72,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Get.offAll(Dashboard()),
                  child: SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: 34,
                    color: iconGreyColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(MerchantAccountSetup()),
                  child: Icon(
                    Icons.account_circle,
                    color: iconGreyColor,
                    size: 42,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  // onTap: onTap,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                            colors: [secondaryColor, primaryColor])),
                    child: Center(
                      child: const Text(
                        "PayMB",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(BusinessDetails()),
                  child: Icon(
                    Icons.business_outlined,
                    color: iconGreyColor,
                    size: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(MerchantWallet()),
                  child: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: iconGreyColor,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: appbarBack(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    height: 80.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Center(
                      child: Text(
                        DashboardState.newData!.businessName[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "${DashboardState.newData?.businessName}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Enter Amount",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 52,
                    color: Color(0xffF0F1F9)),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  children: [
                    const Text(
                      "Amount:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: TextField(
                        controller: amountController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        // textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (a) {
                          print(amount);
                          setState(() {
                            amount = a == "" ? 0.0 : double.parse(a);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  children: [
                    const Text(
                      "Tax % :   ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: TextField(
                        controller: taxController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        // textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onChanged: (a) {
                          print(a);
                          setState(() {
                            tax = a == "" ? 0.0 : double.parse(a);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount to receive: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "CAD ${double.parse((amount + amount * tax / 100).toStringAsFixed(2))}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: ElevatedButton(
                // color: primaryColor,
                onPressed: () {
                  // double totalAmount = amount + amount * tax / 100;

                  setState(() {
                    totalAmount = double.parse(
                        (amount + amount * tax / 100).toStringAsFixed(2));
                  });
                  // totalAmount == 0
                  //     ? null
                  //     : Get.to(const Paying(), arguments: totalAmount);
                  doPayment();

                  setState(() {
                    amountController.clear();
                    taxController.clear();
                    amount = 0;
                    tax = 0;
                  });
                  totalAmount != 0.0
                      ? Get.to(const Paying(), arguments: totalAmount)
                      : null;
                },
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(70),
                // ),
                child: const Text(
                  "Proceed",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 1.2, color: textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
