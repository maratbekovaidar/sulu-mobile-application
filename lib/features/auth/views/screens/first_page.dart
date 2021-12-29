
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


    return Scaffold(
      body: Stack(
        children: [

          /// Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/background/first_page_background.jpg')
              ),
            ),
          ),

          /// Color and Content
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(12, 12, 12, 0.33)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset('assets/logo/sulu_logo.png'),
                    ),
                  ],
                ),

                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
          )
        ],
      ),
    );
  }
}
