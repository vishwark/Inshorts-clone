import 'package:flutter/material.dart';

class SuggestedTopicsTile extends StatelessWidget {
  String imgUrl;
  String label;
  String nightModeImgUrl;
  String tag;
  SuggestedTopicsTile(
      {super.key,
      required this.nightModeImgUrl,
      required this.label,
      required this.imgUrl,
      required this.tag});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shadowColor: Color(0xFF369AF8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                imgUrl,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Color(0xFF8DC8FF), width: 0.5)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0x00FFFFFF),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 4,
              left: 4,
              child: Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  maxLines: 2, // Allows text to wrap to the next line
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
