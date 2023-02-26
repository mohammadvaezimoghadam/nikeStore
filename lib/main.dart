import 'package:flutter/material.dart';
import 'package:nikestore/data/repo/auth_repository.dart';
import 'package:nikestore/data/repo/product_repo.dart';
import 'package:nikestore/theme.dart';
import 'package:nikestore/ui/auth/auth.dart';
import 'package:nikestore/ui/home/home.dart';
import 'package:nikestore/ui/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const defaultTextStyle =
        TextStyle(fontFamily: "Vazir", color: LighThemeColors.primaryTextColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        appBarTheme: AppBarTheme(backgroundColor: Colors.white,foregroundColor: LighThemeColors.primaryTextColor,elevation: 0),
        textTheme: TextTheme(
          subtitle1:
              defaultTextStyle.apply(color: LighThemeColors.secondaryTextColor),
          bodyText2: defaultTextStyle,
          button: defaultTextStyle,
          headline6: defaultTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 18),
          caption:
              defaultTextStyle.apply(color: LighThemeColors.secondaryTextColor),
        ),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: defaultTextStyle.apply(color: Colors.white)),
        colorScheme: ColorScheme.light(
          primary: LighThemeColors.primaryColor,
          secondary: LighThemeColors.secondaryColor,
          onSecondary: Colors.white,
        ),
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: const RootScren()),
    );
  }
}
