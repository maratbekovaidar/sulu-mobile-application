
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {

    /// Size
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Title
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Регистрация клиента",
                  style: GoogleFonts.inter(
                      color: const Color(0xff95798a),
                      fontWeight: FontWeight.bold,
                      fontSize: 26
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(height: 15),

            /// First Name
            const TextField(
              decoration: InputDecoration(
                  hintText: "Имя"
              ),
            ),
            const SizedBox(height: 10),

            /// Last Name
            const TextField(
              decoration: InputDecoration(
                  hintText: "Фамилия"
              ),
            ),
            const SizedBox(height: 10),

            /// Middle Name
            const TextField(
              decoration: InputDecoration(
                  hintText: "Отчество"
              ),
            ),
            const SizedBox(height: 10),

            /// Password
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Пароль"
              ),
            ),
            const SizedBox(height: 10),

            /// Confirm Password
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Повторите пароль"
              ),
            ),
            const SizedBox(height: 25),

            /// Button
            SizedBox(
              width: width * 0.95,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  }, child:
              const Text("Регистрация")
              ),
            ),

          ],
        ),
      ),
    );
  }
}
