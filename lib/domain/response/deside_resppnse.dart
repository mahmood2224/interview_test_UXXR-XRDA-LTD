class DecideResponse{
  bool? isEmail ;
  bool? isValid;
  String? formattedText ;
  String? countryCode ;

  DecideResponse({this.isEmail, this.formattedText, this.countryCode , this.isValid = false });
}