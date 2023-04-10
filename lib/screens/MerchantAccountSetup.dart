import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mpos/modal/api.dart';
import 'package:mpos/screens/dashboard.dart';
import 'package:http/http.dart' as https;
import 'package:mpos/screens/login.dart';
import 'package:mpos/screens/payment_setup.dart';
import 'package:mpos/widgets/colors.dart';

import '../components/appbar_back.dart';
import 'MerchantBusinessDetails.dart';
import 'MerchantWallet.dart';

class MerchantAccountSetup extends StatefulWidget {
  const MerchantAccountSetup({Key? key}) : super(key: key);

  @override
  _MerchantAccountSetupState createState() => _MerchantAccountSetupState();
}

class _MerchantAccountSetupState extends State<MerchantAccountSetup> {
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool isLoading = false;
  bool email = DashboardState.newData!.receipt.email ? true : false;
  bool phone = false, print = false;

  int val = DashboardState.newData?.businessType == "organization" ? 1 : 2;

  static const dropdownItem = <String>[
    'Canadian Dollar',
    'Euro',
    'Rupees',
    'US Dollar'
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItem = dropdownItem
      .map((String e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();

  String selectedVal = 'Canadian Dollar';
  static String? currency = "CAD";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (DashboardState.newData?.settings.currency == "CAD") {
      setState(() {
        selectedVal = "Canadian Dollar";
      });
    } else if (DashboardState.newData?.settings.currency == "EUR") {
      setState(() {
        selectedVal = "Euro";
      });
    } else if (DashboardState.newData?.settings.currency == "RS") {
      setState(() {
        selectedVal = "Rupees";
      });
    } else if (DashboardState.newData?.settings.currency == "USD") {
      setState(() {
        selectedVal = "US Dollar";
      });
    }
  }

  void updateUser() async {
    await https.post(Uri.parse(urlUser), headers: {
      'Authorization': 'Bearer ${LoginPage.token}'
    }, body: {
      // "businessType": val == 1 ? "organization" : "individual",
      // "currency": currency.toString(),
      // "receipt": {"email": email}
      "receiptEmail": email.toString()
    });
    await DashboardState().getUserData();
    setState(() {
      email = DashboardState.newData?.receipt.email ?? false;
    });
  }

  /* void _onLoading() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 20,
        child: SizedBox(
          width: double.infinity,
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => Get.offAll(const Dashboard()),
                child: SvgPicture.asset(
                  'assets/icons/home.svg',
                  width: 34,
                  color: iconGreyColor,
                ),
              ),
              const Icon(
                Icons.account_circle,
                color: primaryColor,
                size: 42,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const PaymentSetup());
                },
                // onTap: onTap,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                          colors: [secondaryColor, primaryColor])),
                  child: const Center(
                    child: Text(
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
                onTap: () => Get.to(const BusinessDetails()),
                child: const Icon(
                  Icons.business_outlined,
                  color: iconGreyColor,
                  size: 40,
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(const MerchantWallet()),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: iconGreyColor,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
/*
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Merchant Account",
            style: TextStyle(color: Colors.black),
          )),
*/
      appBar: appbarBack(),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Stack(
                    children: [
                      /*Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 10),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/profile.jpg'),
                          ),
                        ),
                      ),*/
                      Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Center(
                          child: Text(
                            DashboardState.newData!.businessName[0]
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      /*Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: primaryColor,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    DashboardState.newData?.businessName ?? "Loading",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  enabled: false,
                  cursorColor: secondaryColor,
                  decoration: InputDecoration(
                    labelText: "Unique ID",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "${DashboardState.newData?.uid}",
                    hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Business Type :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                val = 1;
                              });
                            },
                            child: Row(
                              children: [
                                Radio(
                                  activeColor: primaryColor,
                                  value: 1,
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     val = 1;
                                  //   });
                                  // },
                                  onChanged: null,
                                  groupValue: val,
                                ),
                                const Text(
                                  "Organization",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            // onTap: () {
                            //   setState(() {
                            //     val = 2;
                            //   });
                            // },
                            child: Row(
                              children: [
                                Radio(
                                  activeColor: primaryColor,
                                  value: 2,
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     val = 2;
                                  //   });
                                  // },
                                  onChanged: null,

                                  groupValue: val,
                                ),
                                const Text(
                                  "Individual",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Send Payment Receipt :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              setState(() {
                                email = !email;
                              })
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: primaryColor,
                                  // checkColor: Color(0xfff66666),
                                  value: email,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      email = value!;
                                    });
                                  },
                                  // onChanged: (value) => value = false,
                                ),
                                const Text(
                                  "Email",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            // onTap: () => {
                            //   setState(() {
                            //     phone = !phone;
                            //   })
                            // },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: primaryColor,
                                  value: phone,
                                  // onChanged: (bool? value) {
                                  //   setState(() {
                                  //     phone = !phone;
                                  //   });
                                  // },
                                  onChanged: null,
                                ),
                                const Text(
                                  "Phone / SMS",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            // onTap: () => {
                            //   setState(() {
                            //     print = !print;
                            //   })
                            // },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: primaryColor,
                                  value: print,
                                  // onChanged: (bool? value) {
                                  //   setState(() {
                                  //     print = value!;
                                  //   });
                                  // },
                                  onChanged: null,
                                ),
                                const Text(
                                  "External Printer",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Currency : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      flex: 3,
                      child: DropdownButton<String>(
                        value: selectedVal,
                        // onChanged: (value) {
                        //   setState(() {
                        //     selectedVal = value!;
                        //   });
                        // },
                        onChanged: null,

                        items: _dropDownMenuItem,
                        underline: const SizedBox(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      // color: primaryColor,
                      onPressed: () {
                        // _onLoading();
                        // if (selectedVal == "Canadian Dollar") {
                        //   setState(() {
                        //     currency = "CAD";
                        //   });
                        // } else if (selectedVal == "Euro") {
                        //   setState(() {
                        //     currency = "EUR";
                        //   });
                        // } else if (selectedVal == "Rupees") {
                        //   setState(() {
                        //     currency = "RS";
                        //   });
                        // } else if (selectedVal == "US Dollar") {
                        //   setState(() {
                        //     currency = "USD";
                        //   });
                        // }
                        setState(() {
                          isLoading = true;
                        });
                        updateUser();
                        setState(() {
                          isLoading = false;
                        });
                        Get.snackbar('Successfully Updated', '');
                      },
                      // padding: const EdgeInsets.symmetric(horizontal: 40),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      child: const Text(
                        "Update",
                        style: TextStyle(
                            fontSize: 14, letterSpacing: 1.2, color: textColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Do you want to ',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAll(const LoginPage()),
                      child: Text(
                        'Logout?',
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
