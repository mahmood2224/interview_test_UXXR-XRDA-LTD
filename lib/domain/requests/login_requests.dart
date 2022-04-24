import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:interview_task/domain/response/deside_resppnse.dart';

import '../../app/app_helpers.dart';

class LoginRequests {
  static decide(
      String input, Function(DecideResponse? response) onReturn) async {
    if (isNotNumeric(input)) {
      //this text should be email
      print("this should be email");
      // countryCode = '' ;
      if (isEmailValid(input)) {
        //valid email address
        print("this is a valid email");
        // isEmail = 1;
        onReturn(DecideResponse(
            isEmail: true, countryCode: '', formattedText: input));
        return;
      }
      onReturn(null);
      return;
    }
    CountryWithPhoneCode? phoneCountry;
    try {
      try {
        List<CountryWithPhoneCode> countries = CountryManager().countries;
        phoneCountry = countries.firstWhere(
            (element) => element.phoneCode == input.replaceAll("+", ""));
        print("country code ${phoneCountry.countryCode}");
        onReturn(DecideResponse(
            isEmail: false,
            formattedText: input,
            countryCode: phoneCountry.countryCode));
        return;
        // setState(() => countryCode = phoneCountry.countryCode);
      } catch (e) {
        print("error while getting country code $e");
        onReturn(null);
      }

      String formattedText =
          (await FlutterLibphonenumber().parse(input))['international'];

      onReturn(DecideResponse(
          isEmail: false,
          formattedText: formattedText,
          countryCode: phoneCountry?.countryCode));
    } catch (e) {
      print("there is an error $e");
      onReturn(null);
    }
  }

  static loginWithPhone(String phone,
      {required Function(String? verificationID) onSuccess,
      required Function(String? error) onError }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          onError("this phone number is invalid");
        }
        // Handle other errors
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        onSuccess(verificationId);
      },
    );
  }
}
