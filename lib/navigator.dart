import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/navigator/navigator.dart';

class AppRouterDelegate extends RouterDelegate<MaterialPage>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MaterialPage> {
  final NavigatorBloc navigatorBloc;

  AppRouterDelegate(this.navigatorBloc);

  bool _initial = true;

  final navigatorKey = GlobalKey();

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);

    if (!didPop) return false;

    navigatorBloc.add(
      NavigatorPopPage(),
    );

    return true;
  }

  @override
  build(context) {
    return BlocBuilder<NavigatorBloc, NavigatorModel>(
      builder: (context, navigator) {
        return Navigator(
          key: navigatorKey,
          pages: navigator.pages,
          onPopPage: _handlePopPage,
        );
      },
    );
  }

  @override
  setNewRoutePath(page) async {
    if (_initial)
      _initial = false;
    else
      navigatorBloc.add(
        NavigatorAppendPage(
          page,
        ),
      );
  }
}

class AppRouteInformationParser extends RouteInformationParser<MaterialPage> {
  final NavigatorBloc navigatorBloc;

  const AppRouteInformationParser(this.navigatorBloc);

  @override
  parseRouteInformation(routeInformation) async {
    final uri = routeInformation.location;

    if (uri == null) return await createLandingPage();

    if (uri == "/") return await createLandingPage();
    // if (uri.contains("/article")) {
    //   final urls = uri.split("/");
    //   final articleTitle = urls[1];

    //   return await createArticlePage();
    // }

    return await createLandingPage();
  }

  @override
  restoreRouteInformation(page) {
    // return RouteInformation(location: page.name);
  }
}
