/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mpos/screens/MerchantAccountSetup.dart';
import 'package:mpos/screens/MerchantBusinessDetails.dart';
import 'package:mpos/screens/MerchantWallet.dart';
import 'package:mpos/screens/payment_setup.dart';

import '../modal/AccountModels.dart';
import '../modal/api.dart';
import '../widgets/NavBar.dart';
import '../widgets/colors.dart';
import 'MainScreen.dart';
import 'login.dart';
import 'nfc_devices.dart';
import 'package:http/http.dart' as https;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  bool isLoading = false;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    isLoading = false;
  }

  static late AccountModels newData;

  void getUserData() async {
    // setState(() {
    isLoading = true;
    // });
    var response = await https.get(Uri.parse(urlUser), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${LoginPage.token}'
    });

    var decodeResponse = jsonDecode(response.body);
    Map<String, dynamic> userData = decodeResponse;
    newData = AccountModels.fromJson(userData);
    print("Work");
  }

  Widget container() {
    if (_selectedIndex == 0) {
      return const MainScreen();
    } else if (_selectedIndex == 1) {
      return const MerchantAccountSetup();
    } else if (_selectedIndex == 2) {
      return const PaymentSetup();
    } else if (_selectedIndex == 3) {
      return const BusinessDetails();
    } else if (_selectedIndex == 4) {
      return const MerchantWallet();
    } else if (_selectedIndex == 5) {
      return const NfcEnabledDevices();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: primaryColor,
        backgroundColor: Colors.white10,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pay',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_outlined),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
          ),
        ],
      ),
      */
/* floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 8,
        onPressed: () {
          setState(() {});
          // getUserData();
          _selectedIndex = 2;
        },
        child: const Icon(Icons.payment),
      ),*/ /*

      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: container(),
      ),
    );
  }
}
*/

import 'dart:ui';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpos/screens/MerchantAccountSetup.dart';
import 'package:mpos/screens/MerchantBusinessDetails.dart';
import 'package:mpos/screens/MerchantWallet.dart';
import 'package:mpos/screens/payment_setup.dart';

import '../modal/AccountModels.dart';
import '../modal/AllTransactionsModel.dart';
import '../modal/api.dart';
import '../widgets/colors.dart';
import 'login.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_svg/svg.dart';
import 'package:mpos/components/curve_clipper.dart';
import 'package:mpos/modal/AccountModels.dart';
import 'package:mpos/widgets/colors.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../components/appbar_menu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final items = ['Weekly Volume', 'Daily Volume'];
  String selectedValue = 'Weekly Volume';
  SuperTooltip? tooltip;

  int _selectedIndex = 0;
  bool isLoading = false;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // LoginPageState.isLoading = true;
    // setState(() {
    //   isLoading = true;
    // });
    // getUserData();
    // getTransactionsData();
    update();
  }

  Future update() async {
    getUserData();
    await getTransactionsData();
  }

  static AccountModels? newData;
  static AllTransactionsModel? allTransaction;

  Future getUserData() async {
    // setState(() {
    // isLoading = true;
    // });
    var response = await https.get(Uri.parse(urlUser), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${LoginPage.token}'
    });
    var decodeResponse = jsonDecode(response.body);
    Map<String, dynamic> userData = decodeResponse;
    newData = AccountModels.fromJson(userData);
    print("Work");
    // setState(() {
    //   isLoading = false;
    // });
    print(newData?.email);
  }

  Future getTransactionsData() async {
    // setState(() {
    // isLoading = true;
    // });
    // print(isLoading);
    var response = await https.get(Uri.parse(urlTransactions), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${LoginPage.token}'
    });
    var decodeResponse = jsonDecode(response.body);
    Map<String, dynamic> userTransactions = decodeResponse;
    allTransaction = AllTransactionsModel.fromJson(userTransactions);
    print("Work transaction");
    // setState(() {
    // isLoading = false;
    // });
    // print(isLoading);
    print(allTransaction?.walletBalance);
  }

  // Future<bool> _willPopCallback() async {
  //   // If the tooltip is open we don't pop the page on a backbutton press
  //   // but close the ToolTip
  //   if (tooltip!.isOpen) {
  //     tooltip!.close();
  //     return false;
  //   }
  //   return true;
  // }

  void onTap() {
    if (tooltip != null && tooltip!.isOpen) {
      tooltip!.close();
      return;
    }

    var renderBox = context.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox?;

    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.left,
      arrowTipDistance: 5.0,
      arrowBaseWidth: 15.0,
      arrowLength: 15.0,
      borderWidth: 0,
      snapsFarAwayVertically: true,
      showCloseButton: ShowCloseButton.none,
      hasShadow: false,
      touchThrougArea:
          new Rect.fromCircle(center: targetGlobalCenter, radius: 40.0),

      // touchThrougArea: Rect.fromLTWH(
      //     targetGlobalCenter.dx - 100, targetGlobalCenter.dy - 0, 200.0, 160.0),
      touchThroughAreaShape: ClipAreaShape.oval,
      content: const Material(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
            "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
            "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
            softWrap: true,
          ),
        ),
      ),
    );

    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.up,
      top: 0.0,
      minimumOutSidePadding: 0,
      // right: 5.0,
      // left: 100.0,
      // bottom: 10,
      // minWidth: 12,
      // maxWidth: double.infinity,
      arrowTipDistance: 5.0,
      arrowBaseWidth: 15.0,
      arrowLength: 15.0,
      borderWidth: 0,
      hasShadow: false,
      /*content: new Material(
          child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Text(
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
          "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
          "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
          softWrap: true,
        ),
      )),*/
      content: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: secondaryColor),
      ),
    );
    tooltip!.show(context);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      LoginPageState.isLoading = false;
    });

    return
        // isLoading
        //   ? Scaffold(
        //       body: Center(child: CircularProgressIndicator()),
        //     )
        //   :
        Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bagroundColor,
      bottomNavigationBar: Material(
        elevation: 20,
        child: SizedBox(
          width: double.infinity,
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.asset(
                'assets/icons/home.svg',
                width: 34,
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
                onTap: () {
                  update();
                  Get.to(PaymentSetup());
                },
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
      appBar: appbarMenu(),
      body: Stack(
        children: [
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 325,
              color: secondaryColor,

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
                height: 20,
              ), // for space
              Center(
                child: Text(
                  "Welcome ${newData?.businessName}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ), // this is text
              const SizedBox(
                height: 23,
              ), // for Space
              Container(
                height: 33,
                width: 173,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: selectedValue,
                  onChanged: (String? newValue) =>
                      setState(() => selectedValue = newValue!),
                  items: items
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      color: greyColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ))
                      .toList(),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  iconSize: 22,
                  iconEnabledColor: primaryColor,
                  underline: const SizedBox(),
                ),
              ), // dropdown text
              const SizedBox(height: 25),
              Text(
                "CAD ${allTransaction?.walletBalance}",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 42),
              ), // Money Text
              const SizedBox(height: 12),
              const Text(
                "May 9 - May 15, 2022",
                style: TextStyle(
                    color: greyColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(const PaymentSetup()),
                    child: Container(
                      width: 100,
                      height: 96,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffDCDBDB), offset: Offset(0, 1))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/tap.svg',
                          ),
                          Text(
                            "Tap",
                            style: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 96,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xffDCDBDB), offset: Offset(0, 1))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/person.svg',
                        ),
                        Text(
                          "In Person",
                          style: TextStyle(
                              color: blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 96,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xffDCDBDB), offset: Offset(0, 1))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/link.svg',
                        ),
                        const Text(
                          "Link",
                          style: TextStyle(
                              color: blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Quick Charge",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: primaryColor,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 177,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 24,
                    bottom: 0,
                    child: SvgPicture.asset("assets/images/img.svg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Invite & Earn USD 50",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Text(
                          "Invite a business to use",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: const [
                            Text("PayMB and "),
                            Text(
                              "earn USD 50",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        OutlinedButton(
                          onPressed: null,
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                  BorderSide(color: primaryColor)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 15))),
                          child: const Text(
                            "Invite Friend",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
