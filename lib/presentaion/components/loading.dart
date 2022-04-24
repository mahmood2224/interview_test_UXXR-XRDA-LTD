import 'package:flutter/material.dart';
import '/app/app_colors.dart';

class Loading extends StatelessWidget {
  double height ;
  double width ;
  bool isBackground ;

  Loading({Key? key, this.height = 50, this.width = 50 , this.isBackground = true }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: height,
        height: width,
        padding:const EdgeInsets.all(8),
        decoration:const BoxDecoration(
          color: AppColors.PRIMARY_COLOR,
          shape: BoxShape.circle
        ),
        child: CircularProgressIndicator(
          valueColor:  AlwaysStoppedAnimation<Color>(isBackground ? Colors.white : AppColors.PRIMARY_COLOR),
        ),
      ),
    );
  }
}
