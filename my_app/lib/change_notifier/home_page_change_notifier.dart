import 'package:flutter/material.dart';
import 'package:my_app/data/repository.dart';

import '../models/post.dart';
import '../utils/status.dart';

class HomePageChangeNotifier extends ChangeNotifier {
  final Repository _repository;

  HomePageChangeNotifier(this._repository) {
    getPosts();
  }

  Status status = Status.loaded;
  List<Post> posts = [];

  Future<void> getPosts() async {
    status = Status.loading;
    notifyListeners();

    try {
      posts = await _repository.getPosts();
    } catch (exception) {
      print('ERROR: $exception');
    }
    status = Status.success;
    notifyListeners();
  }
}
