import 'package:dodo/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      child: Dodo(),
      providers: [
        BlocProvider<ArticleBloc>(
          create: (context) => ArticleBloc(),
        ),
        BlocProvider<DrawerBloc>(
          create: (context) => DrawerBloc(),
        ),
        BlocProvider<NavigatorBloc>(
          create: (context) => NavigatorBloc(),
        ),
      ],
    ),
  );
}

const MaterialColor primaryBlack = MaterialColor(
  0xFF000000,
  {
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

const MaterialColor primaryWhite = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

class Dodo extends StatelessWidget {
  const Dodo();

  static const Color darkThemeBackground = Color.fromRGBO(48, 48, 48, 1);

  @override
  Widget build(BuildContext context) {
    final navigatorBloc = context.read<NavigatorBloc>();

    return MaterialApp.router(
      title: 'Dodo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: primaryBlack,
        primaryColor: Colors.black,
        primaryColorDark: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        accentColor: Colors.black,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 32,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          headline2: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          headline6: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w300,
          ),
          bodyText1: TextStyle(
            color: Colors.grey.shade900,
          ),
          subtitle2: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w400,
          ),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: false,
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarDividerColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
        ),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith(
            (states) => Colors.grey.shade400,
          ),
          thumbColor: MaterialStateProperty.resolveWith(
            (states) => Colors.grey.shade700,
          ),
        ),
        indicatorColor: Colors.black,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: primaryWhite,
        primaryColor: Colors.black,
        primaryColorDark: Colors.white,
        backgroundColor: darkThemeBackground,
        scaffoldBackgroundColor: darkThemeBackground,
        accentColor: Colors.grey.shade400,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          headline2: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          headline6: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade300,
            fontWeight: FontWeight.w300,
          ),
          bodyText1: TextStyle(
            color: Colors.grey.shade100,
          ),
          subtitle2: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w400,
          ),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          centerTitle: false,
          foregroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: darkThemeBackground,
            systemNavigationBarDividerColor: darkThemeBackground,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
        ),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.resolveWith(
            (states) => Colors.grey.shade700,
          ),
          thumbColor: MaterialStateProperty.resolveWith(
            (states) => Colors.grey.shade400,
          ),
        ),
        indicatorColor: Colors.white,
      ),
      routerDelegate: AppRouterDelegate(navigatorBloc),
      routeInformationParser: AppRouteInformationParser(navigatorBloc),
    );
  }
}
