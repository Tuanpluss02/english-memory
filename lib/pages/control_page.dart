import 'package:english_memory/values/app_assets.dart';
import 'package:english_memory/values/app_colors.dart';
import 'package:english_memory/values/app_styles.dart';
import 'package:english_memory/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'landing_page.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;

  @override
  void initState() {
    super.initState();
    initDefalutValue();
  }

  initDefalutValue() async {
    final prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Your Control',
          style: AppStyles.h3.copyWith(color: AppColors.textColor),
        ),
        leading: InkWell(
          onTap: () async {
            await prefs.setInt(ShareKeys.counter, sliderValue.toInt());
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            Text(
              'How much a number word at once',
              style: AppStyles.h4.copyWith(color: AppColors.lightGrey),
            ),
            const Spacer(),
            Text(
              '${sliderValue.toInt()}',
              style: AppStyles.h1.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 160),
            ),
            const Spacer(),
            Slider(
                value: sliderValue,
                min: 5,
                max: 100,
                divisions: 95,
                inactiveColor: AppColors.secondColor,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                }),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'Slide to set',
                style: AppStyles.h4.copyWith(color: AppColors.textColor),
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
