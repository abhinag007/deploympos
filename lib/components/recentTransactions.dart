import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mpos/screens/transaction_details_pay.dart';
import 'package:mpos/utilities/themeStyles.dart';
import 'package:mpos/widgets/TransactionCards.dart';

import '../screens/dashboard.dart';
import '../widgets/colors.dart';

class RecentTransactions extends StatefulWidget {
  @override
  _RecentTransactionsState createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 16.0,
              top: 32.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions', style: ThemeStyles.primaryTitle),
              ],
            ),
          ),
          DashboardState.allTransaction!.totalTransaction! > 0
              ? Flexible(
                  flex: 1,
                  child: ListView.builder(
                      itemCount:
                          DashboardState.allTransaction?.totalTransaction,
                      itemBuilder: _buildItemsForListView),
                )
              : Flexible(
                  child: Container(
                  child: Center(
                    child: Text(
                      "No Transaction",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ))
        ],
      ),
    );
  }

  TransactionCard _buildItemsForListView(BuildContext context, int index) {
    return TransactionCard(
      index: index,
      color: DashboardState.allTransaction?.transactions![index].status ==
              "success"
          ? primaryColor
          : DashboardState.allTransaction?.transactions![index].status ==
                  "pending"
              ? iconColor
              : Colors.redAccent,
      icon: DashboardState.allTransaction?.transactions![index].status ==
              "success"
          ? Icons.check
          : DashboardState.allTransaction?.transactions![index].status ==
                  "pending"
              ? Icons.hourglass_full_outlined
              : Icons.close_rounded,
      title: DashboardState.allTransaction?.transactions![index].status ==
              "success"
          ? 'Successful'
          : DashboardState.allTransaction?.transactions![index].status ==
                  "pending"
              ? 'Pending'
              : 'Failed',
      subTitle: DashboardState.allTransaction!.transactions![index].createdAt
          .toString()
          .substring(
              0,
              DashboardState.allTransaction?.transactions![index].createdAt
                  .toString()
                  .indexOf('T')),
      price:
          '+ ${DashboardState.allTransaction?.transactions![index].amount} C\$',
    );
  }
}
