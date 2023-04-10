import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpos/screens/paying.dart';
import 'package:mpos/screens/payment_setup.dart';
import 'package:mpos/screens/transaction_details_pay.dart';

class Failed extends StatefulWidget {
  const Failed({Key? key}) : super(key: key);

  @override
  State<Failed> createState() => _FailedState();
}

class _FailedState extends State<Failed> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Get.off(
        TransactionDetails(status: "Failed"),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: const Icon(
                Icons.cancel,
                size: 120,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Payment Failed",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
