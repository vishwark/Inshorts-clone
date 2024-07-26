import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Image.asset(
              'lib/assets/imgs/happy-cloud.png',
            ),
            Image.asset(
              'lib/assets/imgs/fetching.png',
            ),
            Image.asset(
              'lib/assets/imgs/mob.png',
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Loading Shorts...',
              style: TextStyle(fontSize: 26),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
