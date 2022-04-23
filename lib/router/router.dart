import 'package:csuot/router/i_router.dart';
import 'package:csuot/router/not_found_page.dart';
import 'package:csuot/ui/auth/auth_router.dart';
import 'package:csuot/ui/home/home.dart';
import 'package:csuot/ui/periods/periods_router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static String home = '/home';
  // static String webViewPage = '/webView';

  static final List<IRouterProvider> _listRouter = [];

  static final FluroRouter router = FluroRouter();

  static void initRoutes() {
    /// Specify route jump error return page
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      debugPrint('init router');
      return const NotFoundPage();
    });

    router.define(home,
        transitionType: TransitionType.fadeIn,
        handler: Handler(
            handlerFunc:
                (BuildContext? context, Map<String, List<String>> params) =>
                    Home()));

    // router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
    //   final String title = params['title']?.first ?? '';
    //   final String url = params['url']?.first ?? '';
    //   return WebViewPage(title: title, url: url);
    // }));

    _listRouter.clear();

    _listRouter.add(AuthRouter());
    _listRouter.add(PeriodsRouter());

    void initRouter(IRouterProvider routerProvider) {
      routerProvider.initRouter(router);
    }

    _listRouter.forEach(initRouter);
  }
}
