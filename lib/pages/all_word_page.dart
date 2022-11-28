import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_memory/models/generate_word.dart';
import 'package:english_memory/values/app_assets.dart';
import 'package:english_memory/values/app_colors.dart';
import 'package:english_memory/values/app_styles.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import '../packages/quote/quote.dart';
import '../packages/quote/quote_model.dart';

class AllWordsPage extends StatefulWidget {
  const AllWordsPage({super.key});

  @override
  State<AllWordsPage> createState() => _AllWordsPageState();
}

class _AllWordsPageState extends State<AllWordsPage> {
  late List<EnglishWord> words;

  getAllWords() {
    setState(() {
      words = nouns.map((e) => getQuotes(e)).toList();
    });
  }

  EnglishWord getQuotes(String word) {
    Quote? quote;
    quote = Quotes().getByWord(word);
    return EnglishWord(
        word: word,
        quote: quote?.getContent() ?? '',
        id: quote?.getId(),
        author: quote?.getAuthor() ?? '');
  }

  @override
  void initState() {
    super.initState();
    getAllWords();
  }

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
          itemCount: words.length,
          itemBuilder: (context, index) {
            // String word = words[index].word!.substring(0, 1);
            // word.toUpperCase();
            // word = word + words[index].word!.substring(1);
            bool isFavo = words[index].isFavorite;
            return Material(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              color: (index % 2 == 0)
                  ? AppColors.primaryColor
                  : AppColors.secondColor,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                onDoubleTap: () {
                  setState(() {
                    words[index].isFavorite = words[index].isFavorite;
                  });
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  title: Text(
                    words[index].word!,
                    style: AppStyles.h3.copyWith(color: AppColors.textColor),
                  ),
                  subtitle: AutoSizeText(
                    words[index].quote != ''
                        ? words[index].quote!
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
