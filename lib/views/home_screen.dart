import 'package:flutter/material.dart';
import '../constent.dart';
import '../util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? dropDownSelection;
  double slideValue = 0;
  RangeValues rangeValues = RangeValues(0.0, 0.0);

  String selCat = "";
  double min = 0;
  double max = 1;
  List<Map<String, dynamic>> fList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (dropDownSelection != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "From\n\$ ${rangeValues.start.toInt()}",
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: RangeSlider(
                      values: rangeValues,
                      min: min,
                      max: max,
                      onChanged: (value) {
                        rangeValues = value;

                        setState(() {});
                        print(value);
                      },
                    ),
                  ),
                  Text("To\n\$ ${rangeValues.end.toInt()}", textAlign: TextAlign.center),
                ],
              ),
            ),
          if (dropDownSelection != null)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$selCat",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: (fList).map((e) {
                        return ProductWidget(
                          data: e,
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          if (dropDownSelection == null)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: productList.map((e) {
                    String n = e["name"];
                    List<Map>? pl = e["product_list"] as List<Map>?;
                    print(pl?.length);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            n,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: (pl ?? []).map((e) {
                              return ProductWidget(
                                data: e,
                              );
                            }).toList(),
                          ),
                        )
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

class ProductWidget extends StatelessWidget {
  Map? data;

  ProductWidget({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {

        Navigator.pushNamed(context, quotepage, arguments: data);
      },
      child: Container(
        height: 220,
        width: 150,
        margin: EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.5, 0.5), blurRadius: 2)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    data?["image"] ?? "",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?["name"] ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductModel {
  String? name;
  int? price;
}
