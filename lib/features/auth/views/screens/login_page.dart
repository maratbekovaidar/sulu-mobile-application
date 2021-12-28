import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {

  bool isChecked = false;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Вход",
                  style: GoogleFonts.inter(
                    color: const Color(0xff95798a),
                    fontWeight: FontWeight.bold,
                    fontSize: 26
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 10),

            /// Username
            const TextField(
              decoration: InputDecoration(
                hintText: "Номер телефона"
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

            /// Reset password and check box
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// CheckBox
                Row(
                  children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (isChecked) {
                          setState(() {
                            isChecked = !isChecked!;
                          });
                        }
                      ),
                    ),
                    Text(
                      "Запномнить меня",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),

                /// Reset Password
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Забыли пароль?",
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.underline
                      ),
                    )
                ),
              ],
            ),
            const SizedBox(height: 10),

            /// Button
            SizedBox(
              width: width * 0.9,
              child: ElevatedButton(
                  onPressed: () {

                  }, child:
              const Text("Войти")
              ),
            ),

          ],
        ),
      ),
    );
  }
}
