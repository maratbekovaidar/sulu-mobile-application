import 'package:flutter/material.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/first_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/login_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/register_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

Map<String, WidgetBuilder> routes = {
  '/' : (context) => const HomePage(),
  '/first_page' : (context) => const FirstPage(),
  '/login' : (context) => const LoginPage(),
  '/register' : (context) => const RegisterPage()
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff95798a),

        /// AppBar Theme
        appBarTheme: const AppBarTheme(
          color: Color(0xff95798a),
          shadowColor: Colors.transparent
        ),

        /// Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            primary: const Color(0xff95798a),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
            )
          ).merge(
            ButtonStyle(elevation: MaterialStateProperty.all(0)),
          )
        ),

        /// TextField Theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color:  Color(0xff95798a))
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color:  Color(0xff95798a))
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color:  Color(0xff95798a))
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color:  Color(0xff95798a))
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.red)
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          hintStyle: const TextStyle(
            color: Color(0xffBBBBBB)
          )
        ),

        /// Text Style Theme
        textTheme: TextTheme(
          headline1: GoogleFonts.inter(
            color: const Color(0xff95798A),
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
          headline2: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400
          ),
          bodyText1: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal
          ),
          bodyText2: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal
          ),
          button: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        )


      ),
      title: 'Sulu',
      routes: routes,
      initialRoute: '/',
    );
  }
}

