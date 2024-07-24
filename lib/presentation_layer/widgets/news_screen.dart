import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inshorts_clone/data_layer/data_model/news_data.dart';
import 'package:share_plus/share_plus.dart';

class NewsScreen extends StatefulWidget {
  final NewsData newsData;
  const NewsScreen({super.key, required this.newsData});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool showTopBar = false;
  bool showBottomBar = false;
  handleContentTap() {
    setState(() {
      showTopBar = true;
      showBottomBar = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        showTopBar = false;
        showBottomBar = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: screenHeight * 0.40, // 40% of screen height
                width: double.infinity,
                child: Image.network(
                  widget.newsData.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              if (showTopBar)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    leading: Icon(Icons.arrow_back, color: Colors.black),
                    title: Text(
                      "My feed",
                      style: TextStyle(color: Colors.black),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    actions: [
                      Icon(Icons.replay_outlined, color: Colors.black),
                      SizedBox(
                        width: 20,
                      )
                    ],
                    elevation: 0,
                  ),
                )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.newsData.title,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: handleContentTap,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Text(
                widget.newsData.content,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.newsData.byline1,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFFC7C7C7),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: showBottomBar
          ? Container(
              height: 60, // Set the desired height for your bottom bar
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey, // Set the color of the border
                    width: .5, // Set the width of the border
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Share.shareUri(Uri.parse(widget.newsData.shortenedUrl));
                    },
                    child: IconButton(
                      icon: Icon(Icons.share, color: Colors.black),
                      onPressed: () {
                        // Implement share functionality here
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark, color: Colors.black),
                    onPressed: () {
                      // Implement bookmark functionality here
                    },
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.newsData.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60, // Set the desired height for your bottom bar
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        widget.newsData.bottomHeadline,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        widget.newsData.bottomText,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
