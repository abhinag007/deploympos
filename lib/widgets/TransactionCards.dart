import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpos/screens/transaction_details_pay.dart';
import 'package:mpos/utilities/themeStyles.dart';
import 'package:mpos/widgets/colors.dart';

import '../screens/transaction_recent_details.dart';

class TransactionCard extends StatefulWidget {
  final int index;
  final String title;
  final String subTitle;
  final String price;
  final IconData icon;
  final Color color;
  TransactionCard({
    required this.color,
    required this.index,
    required this.icon,
    required this.price,
    required this.subTitle,
    required this.title,
  });
  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Get.to(TransactionRecentDetails(
            index: widget.index,
          ));
        },
        child: Container(
          height: 62.0,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 44.0,
                        width: 44.0,
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: Center(
                          /*child: Text(
                            widget.letter,
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),*/
                          child: Icon(
                            widget.icon,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.title,
                              style: ThemeStyles.otherDetailsPrimary),
                          Text(widget.subTitle,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: greyColor,
                              )),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          widget.title == "Pending"
                              ? widget.price.substring(2)
                              : widget.price,
                          style: TextStyle(
                              color: widget.title == "Successful"
                                  ? Colors.green
                                  : widget.title == "Pending"
                                      ? iconColor
                                      : Colors.redAccent)),
                      const SizedBox(width: 4.0),
                      const Icon(Icons.keyboard_arrow_right),
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.grey.withOpacity(0.5),
                thickness: 0.5,
                endIndent: 16.0,
                indent: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
