import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int rating;
  final Function(int) onRatingChanged;

  const RatingWidget({
    Key? key,
    required this.rating,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            onRatingChanged(index + 1);
          },
        );
      }),
    );
  }
}
