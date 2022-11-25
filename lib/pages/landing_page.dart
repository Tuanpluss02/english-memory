import 'package:english_memory/values/app_assets.dart';
import 'package:english_memory/values/app_colors.dart';
import 'package:english_memory/values/app_styles.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('English',
                        style: AppStyles.h2.copyWith(
                            color: AppColors.blackGrey,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(right: 110),
                      child: Text('Qoutes',
                          textAlign: TextAlign.right,
                          style:
                              AppStyles.h4.copyWith(fontSize: 32, height: 0.6)),
                    )
                  ],
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
