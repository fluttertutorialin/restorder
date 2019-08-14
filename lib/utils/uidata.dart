import 'dart:ui';
import 'package:flutter/material.dart';

class UIData {

  //routes
  static const String SplashScreenRoute = '/splash_screen';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signup';
  static const String forgotPasswordRoute = '/forgot_password';
  static const String dashBoardRoute = '/dashboard';
  static const String orderRoute = '/order';
  static const String favouriteRoute = '/favourite';
  static const String orderHistoryRoute = '/order_history';
  static const String profileRoute = '/profile';
  static const String contactRoute = '/contact';

  static const String UrlMobex = '';

  //NETWORK
  static const String msgLogin404 = 'Invalid mobile or password';
  static const String msgNoData = 'Data not available';
  static const String msg500 = 'Internal server error';

  static const int resCode404 = 404;
  static const int resCode200 = 200;
  static const int resCode400 = 400;
  static const int resCode300 = 300;
  static const int resCode500 = 500;

  static const String labelForgotPassword = 'Forgot Password?';
  static const String labelDoNotAccount = "You don't have account?";
  static const String labelSignUp = 'Sign up';
  static const String labelContact = 'Contact';

  static const String forgot_password = 'Forgot Password?';
  static const String something_went_wrong = 'Something went wrong';
  static const String coming_soon = 'Coming Soon';
  static const String get_data = 'get data';

  //login
  static const String enter_code_label = 'Phone Number';
  static const String enter_code_hint = '10 Digit Phone Number';
  static const String enter_otp_label = 'OTP';
  static const String enter_otp_hint = '4 Digit OTP';
  static const String get_otp = 'Get OTP';
  static const String resend_otp = 'Resend OTP';
  static const String login = 'Login';
  static const String enter_valid_number = 'Enter 10 digit phone number';
  static const String enter_valid_otp = 'Enter 4 digit otp';

  //generic
  static const String networkNotAvailable = 'Internet not available';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String ok = 'OK';

  //Hint
  static const String inputHintMobile = 'Mobile';
  static const String inputLabelMobile = 'Mobile';
  static const String inputHintPassword = 'Password';
  static const String inputLabelPassword = 'Password';
  static const String inputHintEmail = 'Email';
  static const String inputLabelEmail = 'Email';


  static const String msgLoginSuccessfully = 'Login successfully';
  static const String msgLoginError = 'Mobile or password invalid';
  static const String msgPickUpSuccessfully = 'Pickup done successfully';

  //fonts
  static const String quickFont = 'Quicksand';
  static const String ralewayFont = 'Raleway';
  static const String quickBoldFont = 'quicksand_bold.otf';
  static const String quickNormalFont = 'quicksand_book.otf';
  static const String quickLightFont = 'quicksand_light.otf';

  //TAB
  static const String tabPickUp = 'Pick up';
  static const String tabDispatch = 'Dispatch';
  static const String tabPostpone = 'Postpone';

  //BUTTON
  static const String btnDone = 'DONE';
  static const String btnPostpone = 'POSTPONE';
  static const String btnCancel = 'CANCEL';
  static const String btnUndelivered = 'UNDELIVERED';
  static const String btnSubmit = 'SUBMIT';

  //IMAGE
  static const String imageProfile = 'assets/images/user_profile.png';
  static const String imageSlider = 'assets/images/fastfood.jpg';


  static Color colorRoundText = Colors.grey;
  static Color colorRoundTextBg = Colors.grey.withOpacity(0.1);
  static Color colorIconCall =Colors.orange.shade200;
  static Color colorIconMap =  Colors.blue.shade200;

  static Color colorInquiryNo =  Colors.lightBlue;
  static Color colorDate=  Colors.black26;
  static Color colorRs =  Colors.lightBlue;
  static Color colorName =  Colors.black;
  static Color colorModel =  Colors.black45;
  static Color colorMobile =  Colors.grey;
  static Color colorAddress =  Colors.black87;
  static Color colorReason =  Colors.deepOrangeAccent;
  static const MaterialColor ui_kit_color = Colors.grey;

  static Color colorAppTitle =  Colors.orange;


 //colors
  static List<Color> drawerArrowGradients = [
    Colors.white,
    Colors.orangeAccent.shade400,
  ];

  static List<Color> kitGradients = [
    Colors.grey.shade200,
    Colors.white,
  ];

  static List<Color> gradientsFloatingActionButton = [
    Colors.grey.shade200,
    Colors.orange.shade100,
  ];

  static List<Color> kitGradients2 = [Colors.white, Colors.white];

  static String validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.replaceAll(" ", "").isEmpty) {
      return 'Mobile is required';
    } else if (value.replaceAll(" ", "").length != 10) {
      return 'Mobile number must 10 digits';
    } else if (!regExp.hasMatch(value.replaceAll(" ", ""))) {
      return 'Mobile number must be digits';
    }
    return null;
  }

  static String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Name is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Name must be a-z and A-Z';
    }
    return null;
  }

  static String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
}
