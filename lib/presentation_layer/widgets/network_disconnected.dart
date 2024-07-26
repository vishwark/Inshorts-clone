import 'package:flutter/material.dart';

class NetworkDisconnected extends StatelessWidget {
  const NetworkDisconnected({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Image.asset(
              'lib/assets/imgs/sad-cloud.png',
            ),
            Image.asset(
              'lib/assets/imgs/disconnected.png',
            ),
            Image.asset(
              'lib/assets/imgs/mob.png',
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'No Internet',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Please check your internet settings',
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'SETTINGS',
                  style: TextStyle(fontSize: 24, color: Colors.blueAccent),
                ),
                SizedBox(width: 48),
                Text(
                  'TRY AGAIN',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
