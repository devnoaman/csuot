// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:ui';
// import 'package:csuot/shared/widgets/form_widget.dart';
import 'package:csuot/data/constants.dart';
import 'package:csuot/providers/app_provider.dart';
import 'package:csuot/shared/widgets/form_widget.dart';
import 'package:csuot/ui/auth/auth_provider.dart';
import 'package:csuot/ui/auth/state/state.dart';
import 'package:csuot/ui/widgets/error.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login extends HookConsumerWidget {
  static const String route = '/login';

  const Login({Key? key}) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('rebuilded login');
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController portController = TextEditingController();

    final theme = Theme.of(context);

    TextEditingController _userName = useTextEditingController();
    TextEditingController _password = useTextEditingController();
    FocusNode _focus = useFocusNode();
    var _auth = ref.watch(authProvider);
    ref.listen(authProvider, (previous, next) {
      if (previous == const AuthState.loading() &&
          next == const AuthState.loaded()) {
        gotoNamed(context, '/home');
      }
    });

    return Scaffold(
      // resizeToAvoidBottomInset: true,

      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const FlutterLogo(
                      size: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'CS UOT'
                      // Add this line
                      ,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      MyFormFeild(
                        controller: _userName,
                        title: 'User name',
                      ),
                      MyFormFeild(
                        controller: _password,
                        title: 'Password',
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          _auth.maybeWhen(
                              initial: () {
                                log('initial');
                              },
                              loaded: () {
                                // log('loaded');
                                ref
                                    .read(authProvider.notifier)
                                    .login(_userName.text, _password.text);
                              },
                              loading: () {
                                log('still loading');
                              },
                              orElse: () => log('error'));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: SizedBox(
                            height: 25,
                            // width: 25,
                            child: _auth.when(
                                initial: () => const Text(
                                      '...',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                loading: () => const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                loaded: () => const Text(
                                      'login',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                error: (error) => MyErrorWidget(error: error)
                                // orElse: () => Text('data'),
                                ),
                          ),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: const BorderSide(
                                          color: Colors.transparent))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
