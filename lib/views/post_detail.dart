import 'dart:io';
import 'dart:ui';

import 'package:festival_post/constent.dart';
import 'package:festival_post/util.dart';
import 'package:festival_post/views/download_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../model/post_model.dart';

class QuotesDetail extends StatefulWidget {
  String? name;
  String? img;
  Map map = {};

  QuotesDetail({Key? key, this.name, this.img, required this.map})
      : super(key: key);

  @override
  State<QuotesDetail> createState() => _QuotesDetailState();
}

class _QuotesDetailState extends State<QuotesDetail> {
  Color color = Colors.black;

  // bool isFirst = true;
  int index = 0;

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.cyan,
    Colors.brown,
    Colors.orange,
    Colors.black,
    Colors.white
  ];

  List<TextStyle> fonts = [
    GoogleFonts.lato(),
    GoogleFonts.dancingScript(),
    GoogleFonts.freehand(),
    GoogleFonts.megrim(),
    GoogleFonts.moul(),
  ];

  List<String> img = [
    "assets/Daco_4599778.png",
    "assets/i1.jpg",
    "assets/pngwing.com.png",
    "assets/red-wall-with-white-spray-background.jpg",
    "assets/pexels.jpg"
  ];

  int cIndex = 0;
  int fIndex = 0;
  int? iIndex;
  String  text = "";
  String text1 = "";
  double textSize = 12;
  bool isBold = false;
  Alignment textTopPos = Alignment(0.5, 0.5);
  double sliderVal = 0;
  double sliderVal1 = 0;
  double rotate = 0;

  TextEditingController controller = TextEditingController();
  GlobalKey key = GlobalKey();

  Uint8List? asUint8List;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Text"),
        actions: [
          IconButton(
              onPressed: () {
                cIndex = 0;
                fIndex = 0;
                iIndex = null;
                text = "";
                textSize = 12;
                isBold = false;
                controller.clear();
                setState(() {});
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () async {
                // To get byte data
                RenderRepaintBoundary renderObject = key.currentContext
                    ?.findRenderObject() as RenderRepaintBoundary;
                var image = await renderObject.toImage();
                ByteData? byteData =
                    await image.toByteData(format: ImageByteFormat.png);
                festival.asUint8List = byteData?.buffer.asUint8List();

                /// To save file
                var applicationDocumentsDirectory =
                    await getApplicationDocumentsDirectory();
                var date = DateTime.now().toString();
                String filePath =
                    "${applicationDocumentsDirectory.path}/${date}_img.jpg";
                File file = File(filePath);
                await file.writeAsBytes(festival.asUint8List?.toList() ?? []);
                Navigator.pushNamed(
                  context,
                  dwn,
                );

                // if (arguments != null) {
                cardList.add(arguments!);
                // }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                      child: Text("Download Successfully",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  duration: Duration(seconds: 5),
                  backgroundColor: Colors.black,
                ));
                setState(() {});

                print("Downlaod");
              },
              icon: Icon(Icons.save_alt)),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: RepaintBoundary(
              key: key,
              child: Container(
                color: Colors.black12,
                child: Stack(
                  children: [
                    Center(
                        child: Image.asset(
                      arguments?["image"] ?? "",

                    )),
                    Center(
                      child: Align(
                        alignment: textTopPos,
                        child: Transform.rotate(
                          angle: rotate,
                          child: SelectableText(
                            text,
                            style: fonts[fIndex].copyWith(
                                color: colors[cIndex],
                                fontSize: textSize,
                                fontWeight: isBold
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                            // style: TextStyle(fontFamily: "Schyler",fontSize: textSize,fontWeight: isBold ? FontWeight.bold:FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: textTopPos,
                      child: SelectableText(
                        text,
                        style: fonts[fIndex].copyWith(
                            color: colors[cIndex],
                            fontSize: textSize,
                            fontWeight:
                                isBold ? FontWeight.bold : FontWeight.normal),
                        // style: TextStyle(fontFamily: "Schyler",fontSize: textSize,fontWeight: isBold ? FontWeight.bold:FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),



          IndexedStack(

              index: index,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 40,left: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter Text",
                            fillColor: Colors.grey,
                            filled: true,
                            // border: OutlineInputBorder.none
                          ),
                          onChanged: (value) {
                            text = value;
                            setState(() {});
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            var data = await Clipboard.getData("text/plain");
                            controller.text = data?.text ?? "";
                            print(data?.text);
                          },
                          icon: Icon(Icons.paste))
                    ],
                  ),
                ),

                Center(
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.all(20),
                    color: Colors.black12,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colors.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            cIndex = index;
                            setState(() {});
                          },
                          child: Container(
                          //  height: 40,
                            width: 90,
                            color: colors[index],
                            margin: EdgeInsets.all(10),
                          ),
                        );
                      },
                    ),
                  ),
                ),


                Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  color: Colors.black12,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          fIndex = index;
                          setState(() {});
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "Aa",
                              style: fonts[index].copyWith(fontSize: 40),
                            )),
                      );
                    },
                    itemCount: fonts.length,
                  ),
                ),





                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Slider(
                        value: sliderVal,
                        min: -1,
                        max: 1,
                        onChanged: (value) {
                          sliderVal = value;
                          textTopPos = Alignment(value, 0.5);
                          setState(() {});
                        },
                      ),
                      Slider(
                        value: sliderVal1,
                        min: -1,
                        max: 1,
                        onChanged: (value) {
                          sliderVal1 = value;
                          textTopPos = Alignment(sliderVal, sliderVal1);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40,left: 10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            textSize++;
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.format_size,
                            size: 28,
                          )),
                      IconButton(
                          onPressed: () {
                            textSize--;
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.format_size,
                            size: 20,
                          )),
                      IconButton(
                          onPressed: () {
                            isBold = !isBold;
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.format_bold,
                            size: 20,
                          )),
                      IconButton(
                          onPressed: () {
                            rotate = 0;
                            setState(() {});
                          },
                          icon: Icon(Icons.restart_alt_sharp)),
                      IconButton(
                          onPressed: () {
                            rotate = rotate + 35;
                            setState(() {});
                          },
                          icon: Icon(Icons.rotate_90_degrees_ccw)),
                    ],
                  ),
                ),


              ]),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    // isFirst = true;
                    index = 0;
                    setState(() {});
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 10, bottom: 20),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.type_specimen_outlined)),
                ),
                InkWell(
                  onTap: () {
                    // isFirst = true;
                    index = 1;
                    setState(() {});
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 10, bottom: 20),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.border_color_sharp)),
                ),
                InkWell(
                  onTap: () {
                    //isFirst = false;
                    index = 2;
                    setState(() {});
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 10, bottom: 20),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.font_download_sharp)),
                ),

                InkWell(
                  onTap: () {
                    index = 3;
                    setState(() {});
                    // isFirst = true;
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 10, bottom: 20),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.close_fullscreen)),
                ),
                InkWell(
                  onTap: () {
                    // isFirst = true;
                    index = 4;
                    setState(() {});
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 10, bottom: 20),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.rotate_90_degrees_ccw)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
