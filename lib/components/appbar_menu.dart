import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpos/widgets/colors.dart';

AppBar appbarMenu() {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15, left: 18),
      child: SvgPicture.asset(
        'assets/icons/menu.svg',
      ),
    ),
    backgroundColor: secondaryColor,
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Container(
          width: 40,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 8,
                child: const Icon(
                  Icons.people_outline,
                  size: 30,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                ),
                constraints: const BoxConstraints(
                  minWidth: 15,
                  minHeight: 15,
                ),
                child: const Text(
                  '+',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.only(right: 12.0, top: 12, bottom: 12, left: 8),
        child: Stack(
          children: <Widget>[
            Icon(
              Icons.notifications_none_outlined,
              size: 30,
              color: primaryColor,
            ),
            Positioned(
              left: 0,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                ),
                constraints: const BoxConstraints(
                  minWidth: 17,
                  minHeight: 17,
                ),
                child: Text(
                  '2',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
