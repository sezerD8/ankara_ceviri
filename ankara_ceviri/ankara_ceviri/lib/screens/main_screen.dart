import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../controller/translate_controller.dart';
import '../utils/constanst.dart';
import '../screens/translation_screen.dart';
import '../widget/rep_button.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Container(
          margin: EdgeInsets.all(10),
          width: w,
          height: h,
          child: Column(
            children: [
              MiddleLangs(),
              BottomText(),
              BottomButton(
                nextScreen: () {
                  Get.to(
                    () => TranslationScreen(),
                    transition: Transition.cupertino,
                  );
                },
                icon: Icons.arrow_forward_ios_outlined,
                color: Color(0xffFF865E),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Türkçe kutucuğu ve Çeviri kutucuğu
class MiddleLangs extends StatelessWidget {
  MiddleLangs({
    Key? key,
  }) : super(key: key);
  var _controller = Get.find<TranslateController>();
  var dropHintValue = 'Dil seçiniz';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: w,
          height: 240,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                delay: Duration(milliseconds: 300),
                child: Container(
                  margin: EdgeInsets.all(5),
                  width: w / 1.1,
                  height: h / 6,
                  decoration: BoxDecoration(
                    color: Color(0xff9785FF),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      "Türkçe",
                      style: GoogleFonts.cairo(color: Colors.white, fontSize: 31),
                    ),
                  ),
                ),
              ),
              FadeInDown(
                delay: Duration(milliseconds: 100),
                child: GetBuilder<TranslateController>(builder: (context) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    width: w / 1.1,
                    height: h / 6,
                    decoration: BoxDecoration(
                        color: Color(0xffA2D2FF),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: DropdownButton<String>(
                                icon: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 18.0,
                                    left: 10.0,
                                  ),
                                  child: Icon(
                                    Icons.arrow_downward_sharp,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                                style:
                                    TextStyle(color: Colors.black, fontSize: 20.0),
                                items: [
                                  "en - İngilizce",
                                  "it - İtalyanca",
                                  "ru - Rusça",
                                  "pt - Portekizce",
                                  "es - İspanyolca",
                                ].map((value) {
                                  if (_controller.to == value[0] + value[1])
                                    _controller.dropHintValue = value;
                                  return DropdownMenuItem(
                                    value: value[0] + value[1],
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _controller.dropDownFunc(value!);
                                  _controller.dropHintValue = value;
                                },
                                hint: Text(
                                  _controller.dropHintValue,
                                  style: GoogleFonts.cairo(
                                      color: Colors.white, fontSize: 31),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Slogan ve bilgi
class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 700),
      child: Container(margin: EdgeInsets.only(top: 10,),
        width: w,
        height: 120,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              child: Text("Çeviri şimdi\n senin elinde",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      height: 1,
                      fontWeight: FontWeight.w400)),
            ),
            new Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("Sezer Duman 20350041",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        height: 1,
                        fontWeight: FontWeight.w300)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// AppBar
class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: FadeInDown(
        child: RichText(
          text: TextSpan(
              text: "Ankara",
              style: GoogleFonts.rajdhani(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: " Çeviri",
                  style: GoogleFonts.rajdhani(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
