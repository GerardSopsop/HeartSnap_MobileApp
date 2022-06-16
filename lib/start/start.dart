import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/start/login.dart';
import 'package:heartsnap_monorepo/start/signup.dart';
import 'package:image_fade/image_fade.dart';

import '../util/button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool start = true;

  late Image logo;
  late Image logo1;
  late Image logo2;
  late AssetImage info1;
  late AssetImage info2;
  late AssetImage info3;
  late AssetImage info4;
  late Image infobg;
  late Image menubg;
  late Image cambg1;
  late Image cambg2;
  late Image listbg;
  late AssetImage menu1;
  late AssetImage menu2;
  late AssetImage menu3;
  late AssetImage item1;
  late AssetImage item2;

  @override
  void initState() {
    logo = Image.asset("images/logo/logo_textpic.png");
    logo1 = Image.asset("images/logo/logo_text.png");
    logo2 = Image.asset("images/logo/logo_pic.png");
    info1 = const AssetImage("images/infographic/1.png");
    info2 = const AssetImage("images/infographic/2.png");
    info3 = const AssetImage("images/infographic/3.png");
    info4 = const AssetImage("images/infographic/4.png");
    infobg = Image.asset(
      "images/bg/infographics.png",
      width: 350,
    );
    menubg = Image.asset(
      "images/bg/menu.png",
      width: 100,
    );
    cambg1 = Image.asset(
      "images/bg/cam1.png",
      width: 150,
    );
    cambg2 = Image.asset("images/bg/cam2.png", width: 150);
    listbg = Image.asset("images/bg/foodlist.png", width: 150);
    menu1 = const AssetImage("images/menu/1.png");
    menu2 = const AssetImage("images/menu/2.png");
    menu3 = const AssetImage("images/menu/3.png");
    item1 = const AssetImage("images/menu/item1.png");
    item2 = const AssetImage("images/menu/item2.png");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(logo.image, context);
    precacheImage(logo1.image, context);
    precacheImage(logo2.image, context);
    precacheImage(info1, context);
    precacheImage(info2, context);
    precacheImage(info3, context);
    precacheImage(info4, context);
    precacheImage(infobg.image, context);
    precacheImage(menubg.image, context);
    precacheImage(cambg1.image, context);
    precacheImage(cambg2.image, context);
    precacheImage(listbg.image, context);
    precacheImage(menu1, context);
    precacheImage(menu2, context);
    precacheImage(menu3, context);
    precacheImage(item1, context);
    precacheImage(item2, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> img = {
      "logo": logo,
      "logo1": logo1,
      "logo2": logo2,
      "info1": info1,
      "info2": info2,
      "info3": info3,
      "info4": info4,
      "infobg": infobg,
      "menubg": menubg,
      "cambg1": cambg1,
      "cambg2": cambg2,
      "listbg": listbg,
      "menu1": menu1,
      "menu2": menu2,
      "menu3": menu3,
      "item1": item1,
      "item2": item2,
    };
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ImageFade(
            image: const AssetImage("images/logo/logo_textpic.png"),
            duration: Duration(milliseconds: start ? 500 : 0),
            alignment: Alignment.center,
            fit: BoxFit.cover,
            placeholder: Container(
              alignment: Alignment.center,
              child: Image.asset("images/logo/logo_transparent.png"),
            ),
            loadingBuilder: (context, progress, chunkEvent) =>
                Center(child: CircularProgressIndicator(value: progress)),
            errorBuilder: (context, error) => Container(
              color: const Color(0xFF6F6D6A),
              alignment: Alignment.center,
              child:
                  const Icon(Icons.warning, color: Colors.black26, size: 128.0),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 50)),
          FutureBuilder(
              future: Future.delayed(Duration(seconds: start ? 2 : 0)),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  start = false;
                  return SizedBox(
                    height: 100,
                    child: Column(children: [
                      Button(
                        text: "Create Account",
                        page: SignUp(img: img),
                        enabled: true,
                      ),
                      Button(
                        text: "Already have an account",
                        page: LogIn(img: img),
                        enabled: true,
                      )
                    ]),
                  );
                }
                return const SizedBox(
                  height: 100,
                );
              })
        ]),
      ),
    );
  }
}
