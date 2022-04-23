import 'package:flutter/material.dart';

Size gatSize(context) => MediaQuery.of(context).size;
double getWidth(context) => MediaQuery.of(context).size.width;
double getHeight(context) => MediaQuery.of(context).size.height;
Color primaryColor(context) => Theme.of(context).primaryColor;
const String globalUrl = 'https://csuot.herokuapp.com/v1/';

const String workingURL = globalUrl;
const String tokenEndPoint = 'auth/login/access-token';
const String stagesEndPoint = 'stages/';
const String periodsEndPoint = 'periods/';
gotoNamed(BuildContext context, String route) =>
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
pushNamed(BuildContext context, String route) =>
    Navigator.of(context).pushNamed(route);
