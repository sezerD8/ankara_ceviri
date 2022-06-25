import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:translator/translator.dart';

import '../controller/translate_controller.dart';
import '../utils/constanst.dart';
import '../widget/rep_button.dart';

class TranslationScreen extends StatelessWidget {
  var _controller = Get.find<TranslateController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: MyAppBar(),
          body: SingleChildScrollView(
          child:Container(
            margin: EdgeInsets.all(10),
            width: w,
            height: h,
            child: Column(
              children: [
                Column(
                  children: [

                    TopText(),
                    RepLang("Türkçe", 700),
                    FistTextField(),
                    MiddleText(),
                    RepLang(_controller.dropHintValue, 700),
                    TranslatedBox(),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BottomButton(
                            nextScreen: () {
                              Get.back();
                              Get.find<TranslateController>().clearTr();
                            },
                            icon: Icons.arrow_back_ios_new_outlined,
                            color: Color(0xffFF865E)),
                        BottomButton(
                          nextScreen: () {
                            Get.find<TranslateController>().clearTr();
                            print("Her şey silindi");
                          },
                          icon: Icons.clear_rounded,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    new Container(
                      margin: EdgeInsets.all(30),
                      width: w / 1.1,
                      height: 40,
                      child: Center(
                        child: Text(
                          "Sezer Duman 20350041",
                          style: GoogleFonts.cairo(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),),
        ),
      ),
    );
  }
}

class TranslatedBox extends StatelessWidget {
  const TranslatedBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 700),
      child: Container(
        width: w / 1.2,
        height: h / 7,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 224, 224, 224),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: GetBuilder<TranslateController>(builder: (context) {
            print("Çeviri kutusu güncellendi");
            return Text(
              Get.find<TranslateController>().tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            );
          }),
        ),
      ),
    );
  }
}

// Çeviri ve metin kutusu
class MiddleText extends StatelessWidget {
  const MiddleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }
}

// Metin kutusu
class FistTextField extends StatelessWidget {
  FistTextField({
    Key? key,
  }) : super(key: key);
  var _controller = Get.find<TranslateController>();
  var from = 'tr';
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: 700),
      child: Container(
        width: w / 1.2,
        height: h / 7,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 224, 224, 224),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
          child: GetBuilder<TranslateController>(builder: (context) {
            print("Metin kutusu güncellendi");
            return TextField(
              controller: _controller.textFieldController,
              onChanged: (text) async {
                _controller.letterCounter(text);
                final translation = await text.translate(
                  from: from,
                  to: _controller.to,
                );
                _controller.showTr(translation.text);
              },
              textAlign: TextAlign.center,
              cursorColor: Colors.black,
              style: TextStyle(fontSize: 30),
              maxLines: 6,
              cursorHeight: 30,
              decoration: InputDecoration(
                hintText: "Kelime giriniz",
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 141, 141, 141), fontSize: 25),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class RepLang extends StatelessWidget {
  final String text;
  final int delayAnime;

  RepLang(
    this.text,
    this.delayAnime,
  );

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: Duration(milliseconds: delayAnime),
      child: Container(
        height: h / 19,
        width: w / 2.6,
        child: Center(
          child: Text(
            "${text.toString()}",
            style: GoogleFonts.rajdhani(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 224, 224, 224),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            )),
      ),
    );
  }
}

// Hızlı çeviri
class TopText extends StatelessWidget {
  const TopText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      width: w / 1.7,
      height: h / 7,
      child: Center(

          child: FadeInDown(
        delay: Duration(milliseconds: 100),
        child: Text(
          "Hızlı\nÇeviri",
          textAlign: TextAlign.center,
          style:
              GoogleFonts.cairo(color: Colors.black, fontSize: 45, height: 1),
        ),
      )),
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
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: FadeInRight(
            child: Icon(
              LineIcons.user,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
