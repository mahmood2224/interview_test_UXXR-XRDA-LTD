import 'package:flutter/material.dart';
import 'package:interview_task/app/app_colors.dart';
import 'package:interview_task/app/app_helpers.dart';
import 'package:interview_task/presentaion/components/loading.dart';

class CustomButton extends StatelessWidget {
  String? text ;
  Function? onPressed ;
  double? width ;
  double ?height ;
  double? textSize ;
  BoxDecoration? decoration;
  Color? textColor ;
  bool loading ;
  Color? background ;
  Border? border ;
  Widget? icon ;
  double? borderRadius;
  BorderRadius? borderRadiusObject ;

  CustomButton(
      {this.borderRadius,
        this.borderRadiusObject,
        this.textSize = 16,
        this.text,
        this.icon,
        this.background ,
        this.border,this.onPressed, this.width, this.height ,this.decoration ,this.textColor,this.loading =false });

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():InkWell(
      onTap: (){
        hideKeyboard(context);
        if(onPressed!= null ){
          onPressed!();
        }

      },
      child: Container(
        width: width ??( getWidth(context) - 48 ),
        height: height ?? 51,
        decoration: decoration ?? BoxDecoration(
          color: background ?? AppColors.PRIMARY_COLOR,
          borderRadius:borderRadiusObject ??BorderRadius.circular(borderRadius ?? 12),
          border:  border
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon??Container(),
            icon!= null && (text?.isNotEmpty??false) ? const SizedBox(width: 8,) : Container(),
            Text(text??"" , style: TextStyle(color: textColor??Colors.white , fontSize: textSize , fontWeight: FontWeight.bold),)
          ],
        )
      ),
    );
  }
}
