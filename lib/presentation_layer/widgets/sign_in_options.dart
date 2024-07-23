// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInOptions extends StatefulWidget {
  const SignInOptions({super.key});

  @override
  State<SignInOptions> createState() => _SignInOptionsState();
}

class SignInOption {
  String ctaText;
  IconData iconData;
  Color color;
  Color backgroundColor;
  String tag;
  SignInOption({
    required this.ctaText,
    required this.iconData,
    required this.color,
    required this.backgroundColor,
    required this.tag,
  });
}

// 'facebook': FontAwesomeIcons.facebook,
// 'google': FontAwesomeIcons.google,
// 'twitter': FontAwesomeIcons.twitter,
// 'phone': FontAwesomeIcons.phone,
class _SignInOptionsState extends State<SignInOptions> {
  List<SignInOption> signInOptions = [
    SignInOption(
        ctaText: 'Sign in with Facebook',
        iconData: FontAwesomeIcons.facebook,
        color: Colors.white,
        backgroundColor: const Color.fromARGB(255, 3, 51, 90),
        tag: 'facebook'),
    SignInOption(
        ctaText: 'Sign in with Google',
        iconData: FontAwesomeIcons.google,
        color: Colors.black,
        backgroundColor: Colors.white,
        tag: 'google'),
    SignInOption(
        ctaText: 'Sign in with Twitter',
        iconData: FontAwesomeIcons.twitter,
        color: Colors.white,
        backgroundColor: Colors.blueAccent,
        tag: 'twitter'),
    SignInOption(
        ctaText: 'Sign in with phone',
        iconData: FontAwesomeIcons.phone,
        color: Colors.white,
        backgroundColor: Color.fromARGB(255, 100, 121, 130),
        tag: 'phone'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('inshorts'),
      // ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            SvgPicture.asset('lib/assets/imgs/inshorts_icon.svg',
                semanticsLabel: 'inshorts Logo'),
            Spacer(),
            ...List.generate(signInOptions.length, (index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: signInOptions[index].backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.zero, // Remove default padding
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Aligns items to the start
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0), // Add left padding
                            child: FaIcon(
                              signInOptions[index].iconData,
                              color: signInOptions[index].color,
                            ),
                          ),
                          SizedBox(
                              width: 8), // Space between the icon and the label
                          Text(
                            signInOptions[index].ctaText,
                            style: TextStyle(color: signInOptions[index].color),
                          ),
                        ],
                      ),
                    ),
                  ));
            }),
            SizedBox(
              height: 36,
            )
          ],
        ),
      ),
    );
  }
}
