import 'dart:io';

import 'package:csuot/app.dart';
import 'package:csuot/data/constants.dart';
import 'package:csuot/http.dart';
import 'package:csuot/providers/container.dart';
import 'package:csuot/router/router.dart';
import 'package:csuot/shared/http/httpoverrides.dart';
// import 'package:csuot/http/httpoverrides.dart';
import 'package:csuot/shared/utils/logger.dart';
import 'package:csuot/shared/utils/platform_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  setPathUrlStrategy();

  Routes.initRoutes();

// Set default configs
  dio.options.baseUrl = workingURL;
  dio.options.connectTimeout = 10000; //5s
  dio.options.receiveTimeout = 3000;
  dio.interceptors.add(PrettyDioLogger());
// customization
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final platformType = detectPlatformType();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}
