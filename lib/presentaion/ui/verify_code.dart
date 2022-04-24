import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:interview_task/app/app_colors.dart';
import 'package:interview_task/app/app_helpers.dart';
import 'package:interview_task/domain/cubit/verify_token/verify_token_cubit.dart';
import 'package:interview_task/presentaion/components/custom_button.dart';
import 'package:interview_task/presentaion/ui/login_page.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class VerifyCode extends StatefulWidget {
  String verificationId ;


  VerifyCode(this.verificationId, {Key? key}) : super(key: key);

  @override
  _VerifyCodeState createState() {
    return _VerifyCodeState();
  }
}

class _VerifyCodeState extends State<VerifyCode> {

  final TextEditingController _code = TextEditingController();
  int sec = 60 ;
  Timer? _timer ;

  @override
  void initState() {
    super.initState();
    _lunchTimer();
  }

  _lunchTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (long){
      setState(()=>sec--);
      if(sec ==0) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: AppBar(
        title: const Text(
          "We’ve sent you a code",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.WHITE,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, size: 15, color: Colors.black),
        bottom: PreferredSize(
          child:    const  Text(
            "Enter the confirmation code below ",
            style: TextStyle(fontSize: 16),
          ),
          preferredSize: Size(getWidth(context) , 20),
        ),
      ),
      body: BlocConsumer<VerifyTokenCubit , VerifyTokenState>(
       listener: (BuildContext context, Object? state) {
         if(state is VerifySuccess){
           navigateTo(context, LoginPage() ,removeAll: true);
          showAlertMessage(context, message: "register Success" ,backgroundColor: Colors.green);
         }
         if(state is VerifyError){
           showAlertMessage(context, message: "invalid code" ,backgroundColor: Colors.red);
            _code.text = '' ;
         }
       },
        builder: (context ,state){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            width: getWidth(context),
            height: getHeight(context),
            child: SingleChildScrollView(
              child: Column(
                children:  [
                  SizedBox(height: getHeight(context)*0.3,),
                  PinInputTextFormField(
                    pinLength: 6,
                    decoration:  BoxLooseDecoration(
                      bgColorBuilder: PinListenColorBuilder(Colors.white, Colors.white),
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      strokeColorBuilder:
                      PinListenColorBuilder(Colors.black26, Colors.grey),
                      obscureStyle: ObscureStyle(
                        isTextObscure: true,
                      ),
                      // hintText: _kDefaultHint,
                    ),
                    controller: _code,
                    textInputAction: TextInputAction.go,
                    enabled: true,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.characters,
                    onSubmit: (pin) {
                      print("gtepin===$pin");
                      BlocProvider.of<VerifyTokenCubit>(context).verify(pin, widget.verificationId);
                    },
                    cursor: Cursor(
                      width: 2,
                      color: Colors.black,
                      radius: const Radius.circular(1),
                      enabled: true,
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children:  [
                      const Text("Didn't recieve the code ?" , style: TextStyle(fontSize: 12),),
                      const SizedBox(width: 5,),
                      Text("Wait for ${ sec > 9 ? sec : "0$sec"} sec" , style: TextStyle(fontSize: 12 , fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
