import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:csuot/data/constants.dart';
import 'package:csuot/data/storage.dart';
import 'package:csuot/gen/auth_response.dart';
import 'package:csuot/http.dart';
import 'package:csuot/providers/container.dart';
import 'package:csuot/providers/token_provider.dart';
import 'package:csuot/ui/auth/state/state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  StateNotifierProviderRef<AuthNotifier, AuthState> ref;
  AuthNotifier(this.ref) : super(const AuthState.initial()) {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      log(state.toString());
      state = AuthState.loaded();
      log(state.toString());
    });
  }
  login(username, password) async {
    log('login fun hitted');
    state = const AuthState.loading();
    try {
      await dio
          .post(
        tokenEndPoint,
        data: {"username": username, "password": password},
        options: Options(
          // sendTimeout: 1000,
          contentType: Headers.formUrlEncodedContentType,
        ),
      )
          .then((value) {
        if (value.statusCode == 200) {
          final AuthResponse auth =
              AuthResponse.fromJson(jsonEncode(value.data));
          saveToken(auth.toJson());

          state = const AuthState.loaded();
        }
      });
    } catch (e) {
      state = AuthState.error(e.toString());
      log(e.toString());
    }
  }
}
