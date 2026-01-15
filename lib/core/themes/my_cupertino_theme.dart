import 'package:flutter/cupertino.dart';

CupertinoThemeData myCupertinoAppTheme(brightness) {
  return CupertinoThemeData(
    brightness: brightness,
    primaryColor: CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.activeBlue,
      darkColor: CupertinoColors.activeBlue,
    ),
    scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.white,
      darkColor: CupertinoColors.black,
    ),
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: CupertinoColors.black,
        darkColor: CupertinoColors.white,
      ),
    ),
  );
}
