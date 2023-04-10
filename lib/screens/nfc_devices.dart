import 'package:flutter/material.dart';
import 'package:mpos/widgets/colors.dart';

import '../utilities/mobiles.dart';

class NfcEnabledDevices extends StatefulWidget {
  const NfcEnabledDevices({Key? key}) : super(key: key);

  @override
  State<NfcEnabledDevices> createState() => _NfcEnabledDevicesState();
}

class _NfcEnabledDevicesState extends State<NfcEnabledDevices> {
  List<Mobiles> mobiles = allMobiles;

  @override
  Widget build(BuildContext context) {
    var controller;
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NFC Devices",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Device',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 550,
                    width: double.infinity,
                    // child: Text('${mobiles.length}'),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: mobiles.length,
                        itemBuilder: (context, index) {
                          final mobile = mobiles[index];

                          return ListTile(
                            title: Text("Mobile: ${mobile.name}"),
                            subtitle: Text("Model: ${mobile.model}"),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
