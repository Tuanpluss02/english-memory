import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_memory/models/generate_word.dart';
import 'package:english_memory/values/app_assets.dart';
import 'package:english_memory/values/app_colors.dart';
import 'package:english_memory/values/app_styles.dart';
import 'package:flutter/material.dart';

import '../values/share_keys.dart';
import 'landing_page.dart';

class AllWordsPage extends StatefulWidget {
  final List<EnglishWord> allWords;
  const AllWordsPage({super.key, required this.allWords});

  @override
  State<AllWordsPage> createState() => _AllWordsPageState();
}

class _AllWordsPageState extends State<AllWordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'All Words',
          style:
              AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 32),
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
          itemCount: widget.allWords.length,
          itemBuilder: (context, index) {
            String word = widget.allWords[index].word!.substring(0, 1);
            // word = word + widget.allWords[index].word!.substring(1);
            bool isFavo = widget.allWords[index].isFavorite;
            return Material(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              color: (index % 2 == 0)
                  ? AppColors.primaryColor
                  : AppColors.secondColor,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                onDoubleTap: () {
                  setState(() {
                    widget.allWords[index].isFavorite =
                        !widget.allWords[index].isFavorite;
                    if (widget.allWords[index].isFavorite &&
                        !favoWords.contains(widget.allWords[index].word)) {
                      favoWords.add(widget.allWords[index].word!);
                      prefs.setStringList(ShareKeys.favorite, favoWords);
                    }
                  });
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  title: Text(
                    word.toUpperCase() +
                        widget.allWords[index].word!.substring(1),
                    // widget.allWords[index].word!,
                    style: AppStyles.h3.copyWith(color: AppColors.textColor),
                  ),
                  subtitle: AutoSizeText(
                    widget.allWords[index].quote != ''
                        ? widget.allWords[index].quote!
                        : '"Think of all the beauty still left around you and be happy."',
                    maxLines: 3,
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: isFavo ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
