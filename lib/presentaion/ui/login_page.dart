import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:interview_task/app/Dialog.dart';
import 'package:interview_task/app/app_colors.dart';
import 'package:interview_task/app/app_helpers.dart';
import 'package:interview_task/domain/cubit/login_cubit/login_cubit.dart';
import 'package:interview_task/presentaion/components/custom_button.dart';
import 'package:interview_task/presentaion/ui/verify_code.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneOrEmail = TextEditingController();
  FocusNode focusNode = FocusNode();

  String countryCode = '' ;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: AppBar(
        title: const Text(
          "Connect your wallet",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.WHITE,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, size: 15, color: Colors.black),
      ),
      body: SizedBox(
        width: getWidth(context),
        height: getHeight(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                "We’ll send you a confirmation code",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BlocConsumer<LoginCubit , LoginState>(
        listener: (context, state) {

          if(state is LoginDecide){
              // _phoneOrEmail.text = (state).response?.formattedText??_phoneOrEmail.text;
              print("${state.response?.countryCode }  from bloc listener  ");
              if(state.response?.countryCode != null ) {
                print("code not null");
                countryCode = state.response?.countryCode??"" ;
                setState((){});
              }

          }

          if(state is LoginError){
            showAlertMessage(context, message: state.error??"" , backgroundColor: Colors.red);
          }

          if(state is LoginSuccess){
            navigateTo(context, VerifyCode(state.verificationId!));
            showAlertMessage(context, message: "Login Success" , backgroundColor: Colors.green);
          }
        },
        builder: (context, state){
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadiusDirectional.circular(8)),
                      child: TextField(
                        controller: _phoneOrEmail,
                        focusNode: focusNode,
                        maxLines: 1,
                        onChanged: BlocProvider.of<LoginCubit>(context).decide,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                          labelText: "Phone number or email",
                          focusColor: Colors.black,
                          labelStyle:
                          const TextStyle(fontSize: 12, color: Colors.black),
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: (countryCode.isEmpty || _phoneOrEmail.text.isEmpty) ? Container(width: 1,height: 1,):Image.asset(
                              'icons/flags/png/${countryCode.toLowerCase()}.png',
                              package: 'country_icons',
                              width: 16,
                              height: 12,
                            )  ,
                          ),
                        ),
                      ),
                    ),
                    state is LoginDecideError && _phoneOrEmail.text.isNotEmpty? Text("please enter valid email or phone" , style: TextStyle(fontSize: 12 , color: Colors.red),) : Container()

                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                  loading: state is LoginLoading,
                  onPressed: (){
                    if(state is LoginDecide){
                      if(!(state.response?.isEmail??false)) {
                        BlocProvider.of<LoginCubit>(context).loginWithPhone(
                            _phoneOrEmail.text);
                      }else{
                        showNotificationDialog(context, title: "can't sign without password", desc: "i searched in all official docs provided by google for how to authinticate users using just email without password and i fond out that no way i can do it just throw email link and this required a verified domain to make the dynamic link please see the full work");
                      }
                    }
                  },
                  text: "continue",
                ),
                const SizedBox(
                  height: 21,
                ),
                RichText(
                  text: const TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: "By signing up I agree to Zëdfi’s "),
                        TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        TextSpan(text: " and"),
                        TextSpan(
                            text: " Terms of Use",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text:
                          " and allow Zedfi to use your information for future",
                        ),
                        TextSpan(
                            text: " Marketing purposes.",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ]),
                )
              ],
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
