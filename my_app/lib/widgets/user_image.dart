import 'dart:math';

import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final double width;
  const UserImage({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFFA11B93),
              Color(0xFFD2164E),
              Color(0xFFF79B4A)
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
            borderRadius: BorderRadius.all(
              Radius.circular(37.5),
            ),
          ),
          width: width,
          height: width,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(34)),
          ),
          width: width - 3,
          height: width - 3,
        ),
        CircleAvatar(
          radius: width / 2.2,
          backgroundImage: Image.network(
                  'https://picsum.photos/id/${Random().nextInt(20)}/300')
              .image,
        ),
      ],
    );
  }
}
