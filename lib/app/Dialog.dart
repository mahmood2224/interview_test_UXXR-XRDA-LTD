import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_task/app/app_colors.dart';
import 'package:interview_task/presentaion/components/custom_button.dart';


// ignore: non_constant_identifier_names
ShowDialog(
    {required BuildContext context,
      required Widget child,
      double opacity = 0.5,
      double? height,
      EdgeInsets? margin,
      bool dismiss = true ,
      BorderRadius? radius,
      Alignment? alignment}) {
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: dismiss,
    barrierColor: Colors.black.withOpacity(opacity),
    transitionDuration: Duration(milliseconds: 100),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return child;
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(anim1),
        child: Align(
          alignment: alignment ?? Alignment.center,
          child: Container(
            height: height,
            color: Colors.transparent,
            child: Material(
              color: Colors.transparent,
              borderRadius: radius ?? BorderRadius.circular(0),
              child: ClipRRect(
                  borderRadius: radius ?? BorderRadius.circular(0),
                  child: child),
            ),
            margin: margin ?? EdgeInsets.only(bottom: 16, left: 12, right: 12),
          ),
        ),
      );
    },
  );
}

showNotificationDialog(BuildContext context ,{required String title , required String desc, String? imageUrl }){
  double width = MediaQuery.of(context).size.width ;
  double height = MediaQuery.of(context).size.height ;
  ShowDialog(context: context , alignment:Alignment.center , radius:BorderRadius.circular(13) , child: Container(
    color: Colors.white,
    padding: EdgeInsets.all(16),
    width: width-32-32,
    constraints: BoxConstraints(
        maxHeight: height-100
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16,),
          Center(child: Text(title , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold  ),)),
          SizedBox(height: 16,),
          Text(desc , style: TextStyle(fontSize: 14 ) ,textAlign: TextAlign.center,),
          SizedBox(height: 16,),
          Center(
            child: CustomButton(
              width: 100,
              height: 45,
              background: Colors.white,
              textColor: AppColors.PRIMARY_COLOR,
              text: "Confirm",
              onPressed: ()=> Navigator.pop(context),
            ),
          )
        ],
      ),
    ),
  )  );
}
