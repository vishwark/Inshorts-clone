// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inshorts_clone/business_layer/bloc/settings/settings_bloc.dart';

import 'package:inshorts_clone/data_layer/data_model/toggle_data.dart';
import 'package:inshorts_clone/presentation_layer/widgets/sign_in_options.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class LanguageOptions {
  String language;
  bool selected;
  LanguageOptions({
    required this.language,
    required this.selected,
  });
}

class _SettingsState extends State<Settings> {
  static const loginOptions = ['facebook', 'google', 'twitter', 'phone'];
  List<ToggleData> toggleData = [
    ToggleData(
        tag: 'notifications',
        iconData: Icons.notifications,
        title: 'Notification',
        subTitle: null,
        value: false),
    ToggleData(
        tag: 'hd_images',
        iconData: Icons.trip_origin,
        title: 'HD Images',
        subTitle: null,
        value: false),
    ToggleData(
      tag: 'night_mode',
      iconData: Icons.mode_night,
      title: 'Night Mode',
      subTitle: 'For better readability at night',
      value: false,
    ),
  ];

  final tapOptions = [
    'Share this app',
    'Rate this app',
    'Feedback',
    'Terms & conditions',
    'Privacy'
  ];

  List<LanguageOptions> languageOptions = [
    LanguageOptions(language: 'English', selected: false),
    LanguageOptions(language: 'हिंदी', selected: false)
  ];

  bool notification = true;
  final Map<String, IconData> iconMap = {
    'facebook': FontAwesomeIcons.facebook,
    'google': FontAwesomeIcons.google,
    'twitter': FontAwesomeIcons.twitter,
    'phone': FontAwesomeIcons.phone,
  };
  void showBottoSheet(BuildContext context, String selected) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(languageOptions.length, (index) {
            return GestureDetector(
              onTap: () {
                languageOptions.forEach((item) {
                  item.selected = false;
                });
                var selectedLanguage = languageOptions[index].language;
                BlocProvider.of<SettingsBloc>(context).add(UpdateLanguage(
                    selectedLanguage == 'English' ? 'en' : 'hi'));
                setState(() {
                  languageOptions[index].selected = true;
                });
                Navigator.pop(context);
              },
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (selected == languageOptions[index].language)
                          Icon(
                            Icons.done,
                            color: Colors.blueAccent,
                          ),
                        Text(
                          languageOptions[index].language,
                          style: TextStyle(
                              fontSize: 20,
                              color: selected == languageOptions[index].language
                                  ? Colors.blueAccent
                                  : Colors.black),
                        )
                      ],
                    ),
                  ),
                  if (index + 1 < languageOptions.length) Divider()
                ],
              ),
            );
          }),
        );
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Options'),
        actions: [SizedBox.shrink()],
      ),
      endDrawer: SignInOptions(),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          bool isDarkTheme = false;
          bool notificationsEnabled = true;
          String selectedLanguage = 'English';
          String language = 'en';

          if (state is SettingsLoaded) {
            isDarkTheme = state.isDarkTheme;
            notificationsEnabled = state.notificationsEnabled;
            language = state.language;
            toggleData[2].value = isDarkTheme; // Night Mode
            toggleData[0].value = notificationsEnabled; // Notifications
            print('$language ----1111111111111111-lan');
            selectedLanguage = language == 'en' ? 'English' : 'हिंदी';
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                  padding: EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Save Your Preferences",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Sign in to save your Likes\nand Bookmarks.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _scaffoldKey.currentState?.openEndDrawer();
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              )),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:
                                  List.generate(loginOptions.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: CircleAvatar(
                                    child: FaIcon(iconMap[loginOptions[index]]),
                                  ),
                                );
                              }))
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 24, 24, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auto Start',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Please enable to receive notifications',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Aa',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 32, 32, 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Language',
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                GestureDetector(
                                  onTap: () =>
                                      showBottoSheet(context, selectedLanguage),
                                  child: Row(
                                    children: [
                                      Text(selectedLanguage),
                                      Icon(Icons.arrow_drop_down)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ...List.generate(toggleData.length, (index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 0),
                        child: Icon(toggleData[index].iconData),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 32, 32, 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        toggleData[index].title,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      if (toggleData[index].subTitle != null)
                                        Text(
                                          '${toggleData[index].subTitle!}',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Switch(
                                        value: toggleData[index].value,
                                        activeColor: Colors.blueAccent,
                                        onChanged: (bool value) {
                                          if (toggleData[index].tag ==
                                              'notifications') {
                                            BlocProvider.of<SettingsBloc>(
                                                    context)
                                                .add(
                                              UpdateNotifications(value),
                                            );
                                          } else if (toggleData[index].tag ==
                                              'night_mode') {
                                            BlocProvider.of<SettingsBloc>(
                                                    context)
                                                .add(
                                              UpdateTheme(value),
                                            );
                                          } else {
                                            setState(() {
                                              toggleData[index].value = value;
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
                Divider(
                  height: 0,
                ),
                ...List.generate(tapOptions.length, (index) {
                  return Padding(
                      padding: EdgeInsets.fromLTRB(32, 16, 24, 32),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tapOptions[index],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ));
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
