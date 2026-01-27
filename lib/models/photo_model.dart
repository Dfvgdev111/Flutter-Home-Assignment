class Photo {
  final String path;
  int rating;
  final String author;
  final String description;

  Photo({
    required this.path,
    required this.author,
    this.rating = 0,
    required this.description,
  });
}
