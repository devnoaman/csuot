import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

/*
----------------------
//! token
----------------------
*/

saveToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  return token;
}

removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  var token = prefs.getString('token');
  return token;
}

/*

//

save pagination for [PaginationProvider]; 

// 

*/

savePagination(pagination) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('pagination', pagination);
}

getPagination() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var pagination = prefs.getInt('pagination');
  return pagination;
}

removePagination() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('pagination');
  var pagination = prefs.getInt('pagination');
  return pagination;
}
