import 'package:english_memory/values/app_assets.dart';
import 'package:english_memory/values/app_colors.dart';
import 'package:english_memory/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'English Word Today',
          style:
              AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 32),
        ),
        leading: InkWell(
          onTap: () {},
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
              '"It is amazing how complete is the delusion that beauty is goodness"',
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            alignment: Alignment.topRight,
                            child: Image.asset(AppAssets.heart),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: const TextSpan(
                                    text: 'B',
                                    style: TextStyle(
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
                                        text: 'eautifull',
                                        style: TextStyle(
                                            fontSize: 60,
                                            fontFamily: FontFamily.sen,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
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
                            child: Text(
                              '"Think of all the beauty still left around you and be happy."',
                              style: AppStyles.h3.copyWith(
                                  color: AppColors.textColor, letterSpacing: 1),
                            ),
                          )
                        ]),
                  );
                }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
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
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        child: Image.asset(AppAssets.exchange),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 12,
      width: isActive ? size.width * 1 / 4 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lighBlue : AppColors.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(3, 8), blurRadius: 3)
          ]),
    );
  }
}
