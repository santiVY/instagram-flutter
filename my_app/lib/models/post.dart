class Post {
  final String? id;
  final String author;
  final String imageBase64;
  final String header;

  Post(
      {this.id,
      required this.author,
      required this.imageBase64,
      required this.header});
}
