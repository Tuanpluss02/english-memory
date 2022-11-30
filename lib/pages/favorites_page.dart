import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_memory/pages/landing_page.dart';
import 'package:english_memory/values/app_assets.dart';
import 'package:english_memory/values/app_colors.dart';
import 'package:english_memory/values/app_styles.dart';
import 'package:english_memory/values/share_keys.dart';
import 'package:flutter/material.dart';

class FavoriteWords extends StatefulWidget {
  final List<String> favoWords;
  const FavoriteWords({super.key, required this.favoWords});

  @override
  State<FavoriteWords> createState() => _FavoriteWordsState();
}

class _FavoriteWordsState extends State<FavoriteWords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText(
          'Your Favorite Words',
          style: AppStyles.h4.copyWith(color: AppColors.textColor),
          maxLines: 1,
        ),
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.favoWords.length,
          itemBuilder: (context, index) {
            String word = widget.favoWords[index].substring(0, 1);
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      AppAssets.heart,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: AutoSizeText(
                        word.toUpperCase() +
                            widget.favoWords[index].substring(1),
                        maxLines: 1,
                        // maxFontSize: 40,
                        style: AppStyles.h3.copyWith(
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 25),
                      // padding: const EdgeInsets.symmetric(vertical: 25),
                      alignment: Alignment.center,
                      child: InkWell(
                        child: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        onTap: () {
                          setState(() {
                            widget.favoWords.removeAt(index);
                            prefs.setStringList(
                                ShareKeys.favorite, widget.favoWords);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
