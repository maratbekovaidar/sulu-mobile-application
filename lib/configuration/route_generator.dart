import 'package:flutter/material.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/first_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/login_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/no_auth_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/otp_checking_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/register_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/reset_password/reset_password_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/step_registration/personal_registration_step.dart';
import 'package:sulu_mobile_application/features/establishment/views/screens/establishments_page.dart';
import 'package:sulu_mobile_application/features/favorite/views/screens/favorite_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/appbar/category_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/home_page.dart';
import 'package:sulu_mobile_application/features/profile/views/screens/profile_page.dart';
import 'package:sulu_mobile_application/features/unauth/unauth_home/views/screens/unauth_home.dart';

// Map<String, WidgetBuilder> routes = {
//   '/' : (context) => const HomePage(),
//   '/first_page' : (context) => const FirstPage(),
//   '/login' : (context) => const LoginPage(),
//   '/register' : (context) => const RegisterPage(),
//   '/salons' : (context) => const EstablishmentsPage(),
//   '/category' : (context) => const CategoryPage(),
//   '/favorite' : (context) => const FavoritePage(),
//   '/no_auth_page' : (context) => const NoAuthPage(),
//   '/check_otp' :(context) => const OtpCheckingPage()
// };

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settigns) {
    final args = settigns.arguments;
    switch (settigns.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/first_page':
        return MaterialPageRoute(builder: (_) => const FirstPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/salons':
        return MaterialPageRoute(builder: (_) => const EstablishmentsPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/category':
        return MaterialPageRoute(builder: (_) => const CategoryPage());
      case '/favorite':
        return MaterialPageRoute(builder: (_) => const FavoritePage());
      case '/un_auth/home':
        return MaterialPageRoute(builder: (_) => const UnAuthHomePage());
      case '/un_auth_page':
        return MaterialPageRoute(builder: (_) => const UnAuthHomePage());
      case '/step_registration':
        return _createRoute(const PersonalRegistrationStep());
      case '/reset_password':
        return _createRoute(const ResetPasswordPage());
        return MaterialPageRoute(builder: (_) => const PersonalRegistrationStep());
      case '/no_auth_page' :
        return MaterialPageRoute(builder: (_) => const NoAuthPage());
      case '/check_otp':
        if(args is OtpCheckingConstructor ){
        return MaterialPageRoute(builder: (_) => OtpCheckingPage(phoneNumber:args.phoneNumber,password: args.password,cityId: args.cityId,name: args.name,surname: args.surname, ));
        }
        return _errorRoute();

      // case '/restaurant_details':
      //   if (args is String && isLoggedIn == false) {
      //     return MaterialPageRoute(
      //         builder: (_) => Login(
      //           restaurantId: args,
      //         ));
      //   } else if (args is String && isLoggedIn == true) {
      //     return MaterialPageRoute(builder: (_) => RestaurantDetails(id: args));
      //   }
      //   return _errorRoute();
      //
      // case '/login':
      //   return MaterialPageRoute(builder: (_) => Login(route: '/'));
      // case '/instruction':
      //   return MaterialPageRoute(builder: (_) => Page1(stories: ['assets/images/Instruction/page1.png','assets/images/Instruction/page2.png','assets/images/Instruction/page3.png','assets/images/Instruction/page4.png','assets/images/Instruction/page5.png','assets/images/Instruction/page6.png','assets/images/Instruction/page7.png','assets/images/Instruction/page8.png','assets/images/Instruction/page9.png','assets/images/Instruction/page10.png','assets/images/Instruction/page11.png','assets/images/Instruction/page12.png']));
      // case '/menu':
      //   return MaterialPageRoute(builder: (_) => Menu());
      //

    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Что-то пошло не так",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    });
  }

  static Route _createRoute(StatefulWidget toPage) {

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => toPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutBack;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}
