import 'package:english_memory/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/generate_word.dart';

class FavoritePage extends StatelessWidget {
  final List<String> favoWors;
  const FavoritePage({super.key, required this.favoWors});

  @override
  Widget build(BuildContext context) {
    final pref = SharedPreferences.getInstance();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Your Favorite Words',
          style: AppStyles.h3,
        ),
      ),
    );
  }
}
