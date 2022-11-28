import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_memory/packages/quote/quote.dart';
import 'package:english_memory/packages/quote/quote_model.dart';
import 'package:english_memory/pages/control_page.dart';
import 'package:english_memory/values/app_assets.dart';
import 'package:english_memory/values/app_colors.dart';
import 'package:english_memory/values/app_styles.dart';
import 'package:english_memory/values/share_keys.dart';
import 'package:english_memory/widgets/app_button.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/generate_word.dart';
import 'all_word_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishWord> words = [];
  String randomQuote = Quotes().getRandom().content!;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<int> generateWords({int len = 1, int max = 150, int min = 1}) {
    if (len > max || len < min) return [];
    List<int> rans = [];
    int count = 1;
    Random random = Random();
    while (count <= len) {
      var val = random.nextInt(max);
      if (!rans.contains(val)) {
        rans.add(val);
      }
      count++;
    }
    return rans;
  }

  getEnglishWord() async {
    final prefs = await SharedPreferences.getInstance();
    int len = prefs.getInt(ShareKeys.counter) ?? 5;
    List<String> result = [];
    List<int> newList = generateWords(len: len, max: nouns.length);
    for (var element in newList) {
      result.add(nouns[element]);
    }
    setState(() {
      words = result.map((e) => getQuotes(e)).toList();
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
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishWord();
  }

  @override
  Widget build(BuildContext context) {
    // getEnglishWord();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          setState(() {
            getEnglishWord();
          });
        }
      },
      key: _globalKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'English Word Today',
          style:
              AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 35),
        ),
        leading: InkWell(
          onTap: () {
            _globalKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        margin: const EdgeInsets.all(30),
        width: double.infinity,
        child: Column(children: [
          // ignore: sized_box_for_whitespace
          Container(
            height: size.height * 1 / 10,
            alignment: Alignment.center,
            child: Text(
              '"$randomQuote"',
              style: AppStyles.h5.copyWith(
                color: AppColors.textColor,
              ),
            ),
          ),
          // ignore: sized_box_for_whitespace
          Container(
            height: size.height * 2 / 3,
            // color: AppColors.primaryColor,
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: words.length,
                // itemCount: 5,
                itemBuilder: (context, index) {
                  String word = words[index].word != null
                      ? words[index].word!
                      : 'Beautifull';
                  String firstLetter = word.substring(0, 1).toUpperCase();
                  String otherLetter = word.substring(1);
                  String defaultQuote =
                      "Think of all the beauty still left around you and be happy.";
                  String quote = words[index].quote != ''
                      ? words[index].quote!
                      : defaultQuote;
                  String defaultAuthor = 'Anne Frank';
                  String author = words[index].author != ''
                      ? words[index].author!
                      : defaultAuthor;
                  bool isFavo = words[index].isFavorite;
                  return Padding(
                    padding: const EdgeInsets.all(6),
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      elevation: 4,
                      color: AppColors.primaryColor,
                      child: InkWell(
                        splashColor: Colors.black26,
                        onDoubleTap: () {
                          setState(() {
                            words[index].isFavorite = !words[index].isFavorite;
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  child: Image.asset(
                                    AppAssets.heart,
                                    color: isFavo ? Colors.red : Colors.white,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: firstLetter,
                                        // text: 'B',
                                        style: const TextStyle(
                                            fontSize: 100,
                                            fontFamily: FontFamily.sen,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(3, 6),
                                                  blurRadius: 6)
                                            ]),
                                        children: [
                                          TextSpan(
                                            text: otherLetter,
                                            // text: 'eautiful',
                                            style: TextStyle(
                                                fontSize: otherLetter.length < 8
                                                    ? 60
                                                    : 50,
                                                fontFamily: FontFamily.sen,
                                                fontWeight: FontWeight.bold,
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(0, 0),
                                                  )
                                                ]),
                                          )
                                        ])),
                              ),
                              Container(
                                margin: const EdgeInsets.all(20),
                                padding: const EdgeInsets.all(40),
                                alignment: Alignment.center,
                                // child: Text(
                                //   '"Think of all the beauty still left around you and be happy."',
                                child: AutoSizeText(
                                  '"$quote"',
                                  maxFontSize: 26,
                                  overflow: TextOverflow.clip,
                                  // maxLines: 7,
                                  style: AppStyles.h3.copyWith(
                                      // fontSize: (quote.length < 60) ? 32 : 30,
                                      color: AppColors.textColor,
                                      letterSpacing: 1),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                padding: const EdgeInsets.only(right: 30),
                                // margin: const EdgeInsets.only(top: 20, right: 20),
                                child: Text('"$author"',
                                    style: AppStyles.h4.copyWith(
                                      fontSize: 30,
                                      color: AppColors.textColor,
                                    )),
                              )
                            ]),
                      ),
                    ),
                  );
                }),
          ),
          _currentIndex >= 5
              ? buildShowMore()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  height: 10,
                  alignment: Alignment.center,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return buildIndicator(index == _currentIndex, size);
                      }),
                )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getEnglishWord();
          });
        },
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(AppAssets.exchange),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lighBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20),
                child: Text(
                  'Your Mind',
                  style: AppStyles.h3.copyWith(color: AppColors.textColor),
                ),
              ),
              AppButton(label: 'Favorites', onTap: () {}),
              AppButton(
                  label: 'Your Control',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ControlPage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 16,
      width: isActive ? size.width * 1 / 4 : 26,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lighBlue : AppColors.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 6), blurRadius: 3)
          ]),
    );
  }

  Widget buildShowMore() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      // color: Colors.red,
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AllWordsPage()));
          },
          splashColor: AppColors.secondColor,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Show More',
              style: AppStyles.h4.copyWith(color: AppColors.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
