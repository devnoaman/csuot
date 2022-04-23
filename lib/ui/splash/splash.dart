import 'dart:async';

import 'package:csuot/data/constants.dart';
import 'package:csuot/data/storage.dart';
import 'package:csuot/gen/auth_response.dart';
import 'package:csuot/ui/auth/auth_router.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  static const String route = '/splash';
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      var auth = await getToken();
      if (auth != null) {
        gotoNamed(context, '/home');
      } else {
        gotoNamed(context, AuthRouter.login);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final translator = AppLocalizations.of(context)!;

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 250,
                height: 250,
                child: FlutterLogo(
                  size: 200,
                ))
          ],
        ),
      ),
    );
  }
}
