
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/first_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/login_page.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/register_page.dart';
import 'package:sulu_mobile_application/features/favorite/views/screens/favorite_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/appbar/category_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/profile/views/screens/profile_edit_page.dart';
import 'package:sulu_mobile_application/features/establishment/views/screens/establishments_page.dart';

String? token;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  try {
    const storage = FlutterSecureStorage();
    token = await storage.read(key: 'token');
    debugPrint("Token: " + token.toString());
  } catch(e) {
    debugPrint("Has exception in getting token " + e.toString());
  }


  runApp(const MyApp());
}


Map<String, WidgetBuilder> routes = {
  '/' : (context) => const HomePage(),
  '/first_page' : (context) => const FirstPage(),
  '/login' : (context) => const LoginPage(),
  '/register' : (context) => const RegisterPage(),
  '/edit_profile' : (context) => const ProfileEditPage(),
  '/salons' : (context) => const EstablishmentsPage(),
  '/category' : (context) => const CategoryPage(),
  '/favorite' : (context) => const FavoritePage()
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: const Color(0xffFF385C),

            /// AppBar Theme
            appBarTheme: const AppBarTheme(
                color: Color(0xffFF385C),
                shadowColor: Colors.transparent
            ),

            /// Elevated Button Theme
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    primary: const Color(0xffFF385C),
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
                    borderSide: const BorderSide(color:  Color(0xffFF385C))
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color:  Color(0xffFF385C))
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color:  Color(0xffFF385C))
                ),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color:  Color(0xffFF385C))
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
              // headline1: GoogleFonts.inter(
              //     color: const Color(0xffFF385C),
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold
              // ),
              // headline2: GoogleFonts.inter(
              //     color: Colors.black,
              //     fontSize: 18,
              //     fontWeight: FontWeight.w400
              // ),
              // bodyText1: GoogleFonts.inter(
              //     color: Colors.black,
              //     fontSize: 18,
              //     fontWeight: FontWeight.normal
              // ),
              // bodyText2: GoogleFonts.inter(
              //     color: Colors.black,
              //     fontSize: 18,
              //     fontWeight: FontWeight.normal
              // ),
              button: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),

            indicatorColor: const Color(0xffFF385C),

            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: Color(0xffFF385C),
            )


        ),
        title: 'Sulu',
        routes: routes,
        initialRoute: token != null ? '/' : '/first_page',
      );
  }
}

