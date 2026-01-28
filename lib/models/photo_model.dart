class Photo {
  final String path;
  int rating;
  final String title;
  final String description;

  Photo({
    required this.path,
    required this.title,
    this.rating = 0,
    required this.description,
  });
}
