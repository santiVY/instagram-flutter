import 'package:flutter/material.dart';
import 'package:my_app/utils/assets.dart';

class MyAppBar extends AppBar {
  MyAppBar({super.key})
      : super(
            backgroundColor: const Color(0xFF212121),
            title: Image.asset(Assets.icInstagramTitle),
            centerTitle: false);
}
