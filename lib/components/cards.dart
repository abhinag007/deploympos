import 'package:flutter/material.dart';
import 'package:mpos/widgets/AmountDisplayCard.dart';

import '../utilities/themeStyles.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32, left: 15, right: 15, bottom: 16),
            child: Text(
              "Your Wallet Balance",
              style: ThemeStyles.primaryTitle,
            ),
          ),
          AmountDisplayCard(),
        ],
      ),
    );
  }
}
