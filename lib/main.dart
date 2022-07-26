import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_grocery_app/theme/theme.dart';
import 'package:shop_grocery_app/views/home/home_view.dart';

import 'core/locator.dart';



void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await LocatorInjector.setupLocator();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: QuizOlympicsTheme.themeColor.primaryColorLight,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    runZonedGuarded(() => runApp(MainApplication()), (error, trace) {
      throw error;
    });
  } catch (error) {
    Fluttertoast.showToast(msg: error.toString());
  }
}

class MainApplication extends StatelessWidget {
  const MainApplication({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: QuizOlympicsTheme.themeColor.primaryColorLight,
        primaryColorDark: QuizOlympicsTheme.themeColor.primaryColorDark,
        backgroundColor: QuizOlympicsTheme.themeColor.backgroundColorDark,
        canvasColor: QuizOlympicsTheme.themeColor.backgroundColorDark,
        cardColor:
            QuizOlympicsTheme.themeColor.primaryColorLight.withAlpha(160),
        appBarTheme: AppBarTheme(
          color: QuizOlympicsTheme.themeColor.primaryColorDark,
        ),
        buttonTheme: ButtonThemeData().copyWith(
          buttonColor: QuizOlympicsTheme.themeColor.primaryColorLight,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme().copyWith(
          headline1: TextStyle(color: Colors.black),
          headline2: TextStyle(color: Colors.black),
          headline3: TextStyle(color: Colors.black),
          headline4: TextStyle(color: Colors.black),
          headline5: TextStyle(color: Colors.black),
          headline6: TextStyle(color: Colors.black),
          subtitle1: TextStyle(color: Colors.black),
          subtitle2: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
          overline: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black),
          caption: TextStyle(color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: QuizOlympicsTheme.themeColor.accentColor),
      ),
      home: HomeView(),
    );
  }
}
