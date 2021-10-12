import 'package:flutter/material.dart';

class RowStars extends StatelessWidget {
  final num count;
  const RowStars({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: 0.5 < count ? Colors.deepOrange : Colors.grey[200],
        ),
        Icon(Icons.star,
            size: 15, color: 1.5 < count ? Colors.deepOrange : Colors.grey[200]),
        Icon(Icons.star,
            size: 15, color: 2.5 < count ? Colors.deepOrange : Colors.grey[200]),
        Icon(Icons.star,
            size: 15, color: 3.5 < count ? Colors.deepOrange : Colors.grey[200]),
        Icon(Icons.star,
            size: 15, color: 4.5 < count ? Colors.deepOrange : Colors.grey[200])
      ],
    );
  }
}