import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:interview_task/domain/requests/login_requests.dart';

part 'verify_token_states.dart';

class VerifyTokenCubit extends Cubit<VerifyTokenState> {
  VerifyTokenCubit() : super(VerifyTokenInit());

  verify(String code , String validationId)async  {
    FirebaseAuth _auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: validationId, smsCode: code);
    _auth.signInWithCredential(credential).catchError((error){
      print(error);
      emit(VerifyError());
    }).then((value) => emit(VerifySuccess()));


  }

}
