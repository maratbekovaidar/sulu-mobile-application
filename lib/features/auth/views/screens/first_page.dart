

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {

    /// Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [


            /// Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background/background_image.jpg')
                ),
              ),
            ),
            


            /// Color and Content
            Container(
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.9),
                    Color.fromRGBO(255, 255, 255, 0.2),
                    Colors.transparent,
                    Colors.transparent,
                  ]
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 100),
                          Image.asset(
                            'assets/logo/red_logo.png',
                            width: 80,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ],
                  ),

                  /// Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Добро пожаловать! \n Мы рады видеть вас \n с нами",
                            style: GoogleFonts.inter(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 150),
                        ],
                      )
                    ],
                  ),


                  /// Button of register and login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [

                          /// Button
                          SizedBox(
                            width: width * 0.9,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              }, child:
                              const Text("Войти")
                            ),
                          ),
                          const SizedBox(height: 15),

                          /// Button
                          SizedBox(
                            width: width * 0.9,
                            child: ElevatedButton(
                              onPressed: () {
                                  Navigator.pushNamed(context, '/un_auth_page');
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.white
                                )
                              ),
                              child: const Text(
                                "Пропустить",
                                style: TextStyle(
                                  color: Colors.redAccent
                                ),
                              )
                            ),
                          ),
                          const SizedBox(height: 5),

                          /// Register
                          Row(
                            children: [
                              Text(
                                "У вас нет аккаунта?",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text(
                                  "Зарегистрироваться",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.underline
                                  ),
                                )
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),

           
          ],
        ),
      ),
    );
  }
}
