import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

navigateTo(BuildContext context, Widget page,
    {bool removeAll = false, Function? onResult}) async {
  if (removeAll) {
    var result = await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page), (route) => false);
    if (onResult != null) onResult(result);
  } else {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => page));
    if (onResult != null) onResult();
  }
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

hideKeyboard(BuildContext context) {
  FocusScopeNode scope = FocusScope.of(context);
  if (!scope.hasPrimaryFocus) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

bool isEmailValid(String input){
  RegExp regExp = RegExp(
    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
    caseSensitive: false,
    multiLine: false,
  );
  print(regExp.firstMatch(input));
  return regExp.firstMatch(input) != null ;
}
bool isNotNumeric(String s) {
  if(s.replaceAll("+", "").isEmpty) return  false ;
  return double.tryParse(s.replaceAll("+", "")) == null ;
}

enum MessageType { SUCCESS, ERROR }
void showInSnackBar(
    { required String value,
      required BuildContext context ,
      Color? color}) {
  Flushbar(
    message: value,
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: color??Colors.green,
    isDismissible: true,
    duration: Duration(seconds: 2),
  ).show(context);
}
showAlertMessage(BuildContext context,{required String message ,Color? backgroundColor }){
  showInSnackBar(value: message, context: context , color: backgroundColor);
}




