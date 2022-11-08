import 'dart:convert';

import 'package:flutter/material.dart';

import '/utils/assets.dart';
import '/widgets/user_image.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              const UserImage(
                width: 50,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  post.author,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Image.asset(Assets.icOpction),
            ],
          ),
        ),
        Image.memory(
          base64Decode(post.imageBase64),
          height: 302,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(Assets.icLove),
              const SizedBox(width: 8),
              Image.asset(Assets.icComment),
              const SizedBox(width: 8),
              Image.asset(Assets.icForward),
              const Spacer(),
              Image.asset(Assets.icAdd)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: Text(post.header),
        )
      ],
    );
  }
}
