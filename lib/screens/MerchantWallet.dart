import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mpos/screens/payment_setup.dart';

import '../components/appbar.dart';
import '../components/appbar_back.dart';
import '../components/cards.dart';
import '../components/recentTransactions.dart';
import '../widgets/colors.dart';
import 'MerchantAccountSetup.dart';
import 'MerchantBusinessDetails.dart';
import 'dashboard.dart';

class MerchantWallet extends StatefulWidget {
  const MerchantWallet({Key? key}) : super(key: key);

  @override
  State<MerchantWallet> createState() => _MerchantWalletState();
}

class _MerchantWalletState extends State<MerchantWallet> {
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
                onTap: () => Get.to(MerchantAccountSetup()),
                child: Icon(
                  Icons.account_circle,
                  color: iconGreyColor,
                  size: 42,
                ),
              ),
              GestureDetector(
                onTap: () {
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
              Icon(
                Icons.account_balance_wallet_outlined,
                color: primaryColor,
                size: 40,
              ),
            ],
          ),
        ),
      ),
      appBar: appbarBack(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CardList(),
            RecentTransactions(),
          ],
        ),
      ),
    );
  }
}
