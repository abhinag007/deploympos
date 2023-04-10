import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpos/utilities/themeColors.dart';
import 'package:mpos/utilities/themeStyles.dart';

import '../screens/dashboard.dart';

class AmountDisplayCard extends StatefulWidget {
  const AmountDisplayCard({Key? key}) : super(key: key);

  @override
  _AmountDisplayCardState createState() => _AmountDisplayCardState();
}

class _AmountDisplayCardState extends State<AmountDisplayCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 200,
        width: 380,
        decoration: BoxDecoration(
          color: ThemeColors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${DashboardState.allTransaction?.walletBalance} CAD',
                        style: ThemeStyles.cardMoney),
                    SvgPicture.asset(
                      'assets/hide-icon.svg',
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      bottom: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unique ID', style: ThemeStyles.cardDetails),
                        /*Text('${DashboardState.newData.bank.bankName}',
                            style: ThemeStyles.cardDetails),*/
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Text('${DashboardState.newData?.uid}',
                                  style: ThemeStyles.cardDetails),
                            ),
                            /*Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: SvgPicture.asset('assets/card-dots.svg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0),
                              child: SvgPicture.asset('assets/card-dots.svg'),
                            ),*/
                            /* Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Text('9018', style: ThemeStyles.cardDetails),
                            ),*/
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
