import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:interview_task/app/app_colors.dart';
import 'package:interview_task/app/app_helpers.dart';
import 'package:interview_task/domain/cubit/login_cubit/login_cubit.dart';
import 'package:interview_task/domain/cubit/verify_token/verify_token_cubit.dart';
import 'package:interview_task/domain/cubit/verify_token/verify_token_cubit.dart';
import 'package:interview_task/presentaion/ui/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterLibphonenumber().init();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),

        BlocProvider<VerifyTokenCubit>(
          create: (BuildContext context) => VerifyTokenCubit()
        ),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder:(context,widget){
          return Directionality(textDirection: TextDirection.ltr, child: widget!);
        },
        theme: ThemeData(
          fontFamily: "Regular",
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.transparent
          ),
        ),
        home: LoginPage(),
      )
    );
  }
}
