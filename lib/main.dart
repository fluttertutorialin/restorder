import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restorder/ui/pages/splash/splash_screen_page.dart';
import 'di/dependency_injection.dart';
import 'logic/bloc/dashboard_bloc.dart';
import 'logic/bloc/shopping_bloc.dart';
import 'logic/blocprovider/bloc_provider.dart';
import 'ui/pages/contact/contact_page.dart';
import 'ui/pages/dashboard/dashboard_page.dart';
import 'ui/pages/favourite/favourite_page.dart';
import 'ui/pages/forgotpassword/forgot_password_page.dart';
import 'ui/pages/login/login_page.dart';
import 'ui/pages/order/my_order_page.dart';
import 'ui/pages/orderhistory/order_history_page.dart';
import 'ui/pages/profile/profile_page.dart';
import 'ui/pages/signup/signup_page.dart';
import 'utils/translations.dart';
import 'utils/uidata.dart';

void main() {
  Injector.configure(Flavor.Testing);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );

    return BlocProvider<ShoppingBloc>(
        bloc: ShoppingBloc(),
        child: BlocProvider<DashboardBloc>(
        bloc: DashboardBloc(),
        child: MaterialApp(
            theme: ThemeData(
                //buttonColor: Colors.white,
                brightness: Brightness.light,
                accentColor: Colors.orange,
                primaryColor: Colors.orangeAccent,
                primarySwatch: Colors.orange,
                fontFamily: UIData.quickFont),
            title: "",
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              const TranslationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale("en", "US"),
              const Locale("hi", "IN"),
            ],
            localeResolutionCallback:
                (Locale locale, Iterable<Locale> supportedLocales) {
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode ||
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            routes: <String, WidgetBuilder>{
              '/': (context) => SplashScreenPage(),
              UIData.SplashScreenRoute: (BuildContext context) =>
                  SplashScreenPage(),
              UIData.loginRoute: (BuildContext context) => LoginPage(),
              UIData.signUpRoute: (BuildContext context) => SignUpPage(),
              UIData.forgotPasswordRoute: (BuildContext context) => ForgotPasswordPage(),
              UIData.dashBoardRoute: (BuildContext context) => DashboardPage(),
              UIData.orderRoute: (BuildContext context) => MyOrderPage(),
              UIData.favouriteRoute: (BuildContext context) => FavouritePage(),
              UIData.orderHistoryRoute: (BuildContext context) => OrderHistoryPage(),
              UIData.profileRoute: (BuildContext context) => ProfilePage(),
              UIData.contactRoute: (BuildContext context) => ContactPage(),
            })));
  }
}
