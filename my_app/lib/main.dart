import 'package:flutter/material.dart';
import 'package:my_app/change_notifier/home_page_change_notifier.dart';
import 'package:my_app/change_notifier/login_change_notifier.dart';
import 'package:my_app/data/repository.dart';
import 'package:my_app/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _repository = Repository();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => LoginChangeNotifier(_repository)),
          ChangeNotifierProvider(
              create: (_) => HomePageChangeNotifier(_repository))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginPage(),
        ));
  }
}
