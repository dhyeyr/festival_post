


import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../util.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double price = 0;
  // Uint8List? asUint8List;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dowloaded",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),

        ),
        actions: [
          IconButton(
              onPressed: () async {
                var quotesModel;
                Share.share(festival.asUint8List as String);
               await Share.shareWithResult(festival.asUint8List as String);
                // print("res ${res.raw}");
                // print("res ${res.status}");
              },
              icon: Icon(Icons.share),color: Colors.black,),

        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: cardList.map((e) {

                  return Column(
                    children: [
                      if (festival.asUint8List != null) Image.memory(festival.asUint8List!),
                    ],
                  );
                }).toList(),



              ),
            ),
          ),

        ],
      ),
    );
  }


}