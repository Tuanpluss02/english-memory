import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_memory/values/app_assets.dart';
import 'package:english_memory/values/app_colors.dart';
import 'package:english_memory/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/generate_word.dart';
import 'home_page.dart';

late List<EnglishWord> allWords;
late List<String> favoWords;
// ignore: prefer_typing_uninitialized_variables
late SharedPreferences prefs;

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  getPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Welcome to',
                    style: AppStyles.h3,
                  ),
                ),
              ),
              Expanded(
                // flex: 2,
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: AppColors.secondColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('English',
                          style: AppStyles.h2.copyWith(
                              color: AppColors.blackGrey,
                              fontWeight: FontWeight.bold)),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 30),
                        // width: (1 / 2) * MediaQuery.of(context).size.width,
                        child: AutoSizeText('Memory',
                            textAlign: TextAlign.right,
                            style: AppStyles.h4.copyWith(
                                fontSize: 32,
                                height: 0.6,
                                color: AppColors.textColor,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false);
                  },
                  fillColor: AppColors.lighBlue,
                  shape: const CircleBorder(),
                  child: Image.asset(AppAssets.rightArrow),
                ),
              )),
            ],
          ),
        ));
  }
}
