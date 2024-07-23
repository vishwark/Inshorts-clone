// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  String imgUrl;
  String label;
  bool isSelected;
  String tag;
  CategoryTile(
      {Key? key,
      required this.imgUrl,
      required this.label,
      required this.tag,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          duration: Duration(milliseconds: 300), // Adjust duration as needed
          opacity: isSelected
              ? 1.0
              : 0.5, // Specify opacity values based on isSelected
          child: Padding(
            padding: EdgeInsets.fromLTRB(32, 0, 32, 16),
            child: Image.asset(
              imgUrl,
              height: 42,
            ),
          ),
        ),
        Text(
          this.label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey),
        ),
      ],
    );
  }
}
