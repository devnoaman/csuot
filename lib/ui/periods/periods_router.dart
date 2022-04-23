import 'package:csuot/router/i_router.dart';
import 'package:csuot/ui/auth/login.dart';
import 'package:csuot/ui/periods/periods.dart';

import 'package:fluro/fluro.dart';

class PeriodsRouter implements IRouterProvider {
  static String periods = '/periods';

  @override
  void initRouter(FluroRouter router) {
    router.define(periods,
        transitionType: TransitionType.fadeIn,
        handler: Handler(handlerFunc: (_, __) => Periods()));
  }
}
