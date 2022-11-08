import 'package:flutter/material.dart';
import 'package:my_app/utils/status.dart';
import 'package:provider/provider.dart';

import '../change_notifier/home_page_change_notifier.dart';
import '/widgets/my_app_bar.dart';
import '/widgets/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      appBar: MyAppBar(),
      body: Consumer<HomePageChangeNotifier>(builder: (_, changeNotifier, __) {
        if (changeNotifier.status.isLoading()) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            itemBuilder: (_, index) {
              return PostCard(
                post: changeNotifier.posts[index],
              );
            },
            itemCount: changeNotifier.posts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          );
        }
      }),
    );
  }
}
