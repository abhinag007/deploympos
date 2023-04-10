import 'package:flutter/material.dart';

AppBar appBar(String text) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    iconTheme: const IconThemeData(color: Colors.black),
    title: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
