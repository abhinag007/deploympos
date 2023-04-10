import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mpos/modal/api.dart';
import 'package:mpos/screens/dashboard.dart';
import 'package:http/http.dart' as https;
import 'package:mpos/screens/login.dart';
import 'package:mpos/screens/payment_setup.dart';
import 'package:mpos/widgets/colors.dart';

import '../components/appbar_back.dart';
import 'MerchantAccountSetup.dart';
import 'MerchantWallet.dart';

class BusinessDetails extends StatefulWidget {
  const BusinessDetails({Key? key}) : super(key: key);

  @override
  _BusinessDetailsState createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  static const dropdownItem = <String>[
    'ROYAL BANK',
    'Bank of Montreal ',
    'Toronto-Dominion Bank',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    intializeData();
  }

  final List<DropdownMenuItem<String>> _dropDownMenuItem = dropdownItem
      .map((String e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();

  String? selectedVal = DashboardState.newData?.bank.bankName == ""
      ? null
      : DashboardState.newData?.bank.bankName;

  static TextEditingController businessNameController = TextEditingController();
  static TextEditingController businessAddressController =
      TextEditingController();
  static TextEditingController phoneNumberController = TextEditingController();
  static TextEditingController emailAddressController = TextEditingController();
  static TextEditingController tinController = TextEditingController();
  static TextEditingController accountNumberController =
      TextEditingController();

  void intializeData() {
    businessNameController.text = DashboardState.newData!.businessName;
    businessAddressController.text = DashboardState.newData!.address;
    phoneNumberController.text = DashboardState.newData!.mobileNumber;
    emailAddressController.text = DashboardState.newData!.email;
    tinController.text = DashboardState.newData!.tin;
    accountNumberController.text = DashboardState.newData!.bank.accountNo;
  }

  void updateUser() async {
    await https.post(Uri.parse(urlUser), headers: {
      'Authorization': 'Bearer ${LoginPage.token}'
    }, body: {
      // "businessName": businessNameController.text,
      // "tin": tinController.text,
      // "address": businessAddressController.text,
      // "bank": {
      // "accountNo": accountNumberController.text,
      // "bankName": selectedVal,
      // },
      "email": emailAddressController.text
    });
    print(emailAddressController.text);
    await DashboardState().update();
  }

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
              GestureDetector(
                onTap: () => Get.to(const MerchantAccountSetup()),
                child: const Icon(
                  Icons.account_circle,
                  color: iconGreyColor,
                  size: 42,
                ),
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
              const Icon(
                Icons.business_outlined,
                color: primaryColor,
                size: 40,
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
      appBar: appbarBack(),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Business Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                enabled: false,
                controller: businessNameController,
                cursorColor: primaryColor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Business Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter Business Name",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ), // Business Name
              const SizedBox(
                height: 30,
              ),
              TextField(
                enabled: false,
                controller: businessAddressController,
                cursorColor: primaryColor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Business Address",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter Your Address",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ), // Business Address
              const SizedBox(
                height: 30,
              ),
              TextField(
                enabled: false,
                controller: phoneNumberController,
                cursorColor: primaryColor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter Phone Number",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ), // Phone Number
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailAddressController,
                cursorColor: primaryColor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter Email Address",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ), // Email
              const SizedBox(
                height: 30,
              ),
              TextField(
                enabled: false,
                controller: tinController,
                cursorColor: primaryColor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Tax Identification Number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter TIN Number",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ), // Business/Tax Identification Number
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Business Account",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  "Bank Name: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                trailing: DropdownButton<String>(
                  hint: const Text("Choose Bank Name"),
                  value: selectedVal,
                  // onChanged: (value) {
                  //   setState(() {
                  //     selectedVal = value!;
                  //   });
                  // },
                  onChanged: null,
                  items: _dropDownMenuItem,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                enabled: false,
                controller: accountNumberController,
                keyboardType: TextInputType.number,
                cursorColor: primaryColor,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Account Number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter Account Number",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ), // Bank Account
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    // color: primaryColor,
                    onPressed: () {
                      updateUser();
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
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
