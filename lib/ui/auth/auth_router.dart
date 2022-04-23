import 'package:csuot/router/i_router.dart';
import 'package:csuot/ui/auth/login.dart';

import 'package:fluro/fluro.dart';

class AuthRouter implements IRouterProvider {
  static String login = '/auth/signin';
  static String smshomePage = '/auth/signup';

  @override
  void initRouter(FluroRouter router) {
    router.define(login,
        transitionType: TransitionType.fadeIn,
        handler: Handler(handlerFunc: (_, __) => Login()));
  }
}
