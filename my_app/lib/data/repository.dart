import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class Repository {
  String token = '';

  Future<bool> validateUser(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCXo4VVDGqt0GmuklBvuYHPD3y72LVG4cg');

    final response = await http.post(url, body: {
      'email': email,
      'password': password,
      'returnSecureToken': 'true',
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      token = data['idToken'];
      return true;
    }

    return false;
  }

  Future<List<Post>> getPosts() async {
    final url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/fir-sandbox2-e7601/databases/(default)/documents/Post');

    final response = await http.get(
      url,
      headers: _getHeaders(),
    );

    final List<Post> posts = [];
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final documents = jsonResponse['documents'] as List<dynamic>;
      for (Map postMap in documents) {
        posts.add(_getPost(postMap));
      }
    }

    return posts;
  }

  Post _getPost(Map data) {
    Post post = Post(
      author: data['fields']['author']['stringValue'],
      imageBase64: data['fields']['imageBase64']['stringValue'],
      header: data['fields']['header']['stringValue'],
    );
    return post;
  }

  Map<String, String> _getHeaders() {
    Map<String, String> headers = {};
    headers['Authorization'] = 'Bearer $token';
    return headers;
  }
}
