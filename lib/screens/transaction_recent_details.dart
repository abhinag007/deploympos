import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mpos/screens/payment_setup.dart';

import '../components/curve_clipper.dart';
import '../widgets/colors.dart';
import 'MerchantAccountSetup.dart';
import 'MerchantBusinessDetails.dart';
import 'MerchantWallet.dart';
import 'dashboard.dart';

class TransactionRecentDetails extends StatefulWidget {
  int index;
  TransactionRecentDetails({Key? key, required this.index}) : super(key: key);

  @override
  State<TransactionRecentDetails> createState() =>
      _TransactionRecentDetailsState();
}

class _TransactionRecentDetailsState extends State<TransactionRecentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          DashboardState.allTransaction?.transactions![widget.index].status ==
                  "success"
              ? bagroundColor
              : Colors.red[50],
      bottomNavigationBar: Material(
        elevation: 20,
        child: SizedBox(
          width: double.infinity,
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => Get.to(Dashboard()),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 385,
                    color: DashboardState.allTransaction
                                ?.transactions![widget.index].status ==
                            "success"
                        ? secondaryColor
                        : Colors.red[100],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 25),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Transaction Details",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                height: 84.0,
                                width: 84.0,
                                decoration: BoxDecoration(
                                  color: DashboardState
                                              .allTransaction
                                              ?.transactions![widget.index]
                                              .status ==
                                          "success"
                                      ? primaryColor
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(220.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    DashboardState
                                                .allTransaction
                                                ?.transactions![widget.index]
                                                .status ==
                                            "success"
                                        ? Icons.check
                                        : Icons.close_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DashboardState.allTransaction
                                        ?.transactions![widget.index].status ==
                                    "success"
                                ? Center(
                                    child: Text(
                                      "Success",
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      "Failed",
                                      style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Date: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Text(
                        DashboardState.allTransaction!
                            .transactions![widget.index].createdAt
                            .toString()
                            .substring(
                                0,
                                DashboardState.allTransaction
                                    ?.transactions![widget.index].createdAt
                                    .toString()
                                    .indexOf('T')),
                        style: TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ],
                  ), // Date
                  const SizedBox(
                    height: 6,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    "Transaction ID:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    DashboardState
                        .allTransaction!.transactions![widget.index].id
                        .toString(),
                    // PaymentSetupState.transData.transactionId,
                    style: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Transaction: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                      Text(
                        "CAD ${DashboardState.allTransaction?.transactions![widget.index].amount?.toDouble()}",
                        // "CAD ${PaymentSetupState.transData}",
                        // "CAD 51.00",
                        style: const TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ElevatedButton(
                      // color: primaryColor,
                      onPressed: () {
                        Get.off(const MerchantWallet());
                      },
                      // padding: const EdgeInsets.symmetric(vertical: 18),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(200),
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Transaction History",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1.2,
                                color: textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
