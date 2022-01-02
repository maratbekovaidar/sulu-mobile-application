import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/utils/services/rest_api_provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {

  /// Api provider
  RestApiProvider provider = RestApiProvider();

  /// Checkbox
  bool isChecked = false;

  /// TextField Controller
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Error Status opacity
  bool errorStatusOpacity = false;

  /// Loading opacity
  bool circularIndicatorOpacity = false;



  @override
  Widget build(BuildContext context) {

    /// Size
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 80),
          Padding(
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
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Номер телефона"
                  ),
                  controller: phoneNumberController,
                ),
                const SizedBox(height: 10),

                /// Password
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Пароль"
                  ),
                  controller: passwordController,
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
                      onPressed: () async {
                        setState(() {
                          circularIndicatorOpacity = true;
                        });
                        bool status = await provider.login(phoneNumberController.text, passwordController.text);
                        if(status == true) {
                          setState(() {
                            circularIndicatorOpacity = false;
                          });
                          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                        } else {
                          setState(() {
                            circularIndicatorOpacity = false;
                            errorStatusOpacity = true;
                          });
                        }
                      }, child:
                  const Text("Войти")
                  ),
                ),

                const SizedBox(height: 30),

                /// Error Status
                errorStatusOpacity ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Номер или пароль набран не правильно!",
                      style: GoogleFonts.inter(
                        color: Colors.red
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ) : Container(),

                /// Loading Status
                circularIndicatorOpacity ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator()
                  ],
                ) : Container(),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
