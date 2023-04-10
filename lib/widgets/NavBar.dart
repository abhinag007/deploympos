import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpos/widgets/colors.dart';

import '../screens/MerchantBusinessDetails.dart';
import '../screens/MerchantAccountSetup.dart';
import '../screens/MerchantWallet.dart';
import '../screens/payment_setup.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Business Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/profile.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: primaryColor,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Merchant Account Setup'),
            onTap: () => Get.to(const MerchantAccountSetup()),
          ),
          ListTile(
            leading: const Icon(Icons.business_outlined),
            title: const Text('Merchant Business Details'),
            onTap: () => Get.to(const BusinessDetails()),
          ),
          ListTile(
            leading: const Icon(Icons.payment_rounded),
            title: const Text('Payment Setup'),
            onTap: () => Get.to(const PaymentSetup()),
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text('Merchant Wallet'),
            onTap: () => Get.to(const MerchantWallet()),
          ),
          ListTile(
            leading: const Icon(Icons.mobile_friendly_outlined),
            title: const Text('Mobile Device'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.connect_without_contact_outlined),
            title: const Text('Payment Gateway'),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
