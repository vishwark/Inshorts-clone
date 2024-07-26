import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/settings/settings_bloc.dart';

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
    return BlocSelector<SettingsBloc, SettingsState, bool>(
      selector: (state) {
        if (state is SettingsLoaded) {
          return state.isDarkTheme; // Select the language property
        }
        return false; // Default value if state is not SettingsLoaded
      },
      builder: (context, isDarkTheme) {
        // Whenever the language changes, only the Text widget is rebuilt
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
                    isDarkTheme ? nightModeImgUrl : imgUrl,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Color(0xFF8DC8FF), width: 0.5)),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDarkTheme
                            ? [
                                Color(0x80000000), // Semi-transparent black
                                Color(0x00FFFFFF), // Fully transparent white
                              ]
                            : [
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      maxLines: 2, // Allows text to wrap to the next line
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
