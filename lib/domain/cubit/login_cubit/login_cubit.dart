import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:interview_task/domain/requests/login_requests.dart';
import 'package:interview_task/domain/response/deside_resppnse.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInit());

  decide(String text) {
    LoginRequests.decide(text, (response) {
      if(response != null ) {
        print("from cubit ${response.countryCode}");
        emit(LoginDecide(response));
      }else{
        emit(LoginDecideError());
      }
    });
  }

  loginWithPhone(String phoneNumber) {
    emit(LoginLoading());
    LoginRequests.loginWithPhone(phoneNumber,
        onSuccess: (verificationId) => emit(LoginSuccess(verificationId)),
        onError: (error) => emit(LoginError(error)));
  }
}
