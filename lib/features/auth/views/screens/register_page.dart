
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/utils/services/rest_api_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  /// Input Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  /// Opacity
  bool circularBarIndicatorOpacity = false;
  bool errorTextOpacity = false;

  @override
  Widget build(BuildContext context) {
    /// Size
    double width = MediaQuery
        .of(context)
        .size
        .width;


    /// Provider
    final RestApiProvider provider = RestApiProvider();


    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
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
                          fontSize: 26),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                /// First Name
                TextField(
                  decoration: const InputDecoration(hintText: "Имя"),
                  controller: firstNameController,
                ),
                const SizedBox(height: 10),

                /// Last Name
                TextField(
                  decoration: const InputDecoration(hintText: "Фамилия"),
                  controller: lastNameController,
                ),
                const SizedBox(height: 10),

                /// Middle Name
                TextField(
                  decoration: const InputDecoration(hintText: "Отчество"),
                  controller: patronymicController,
                ),
                const SizedBox(height: 10),

                /// Phone NUmber
                TextField(
                  decoration: const InputDecoration(hintText: "Номер телефона"),
                  controller: phoneNumberController,
                ),
                const SizedBox(height: 10),

                /// Password
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Пароль"),
                  controller: passwordController,
                ),
                const SizedBox(height: 10),

                /// Confirm Password
                TextField(
                  obscureText: true,
                  decoration:
                  const InputDecoration(hintText: "Повторите пароль"),
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 25),

                /// Button
                SizedBox(
                  width: width * 0.95,
                  child: ElevatedButton(
                      onPressed: () async {

                        // yield ("Yield");

                        if(passwordController.text == confirmPasswordController.text) {
                          setState(() {
                            circularBarIndicatorOpacity = true;
                          });
                          int status = await provider.register(
                              firstNameController.text,
                              lastNameController.text,
                              patronymicController.text,
                              phoneNumberController.text,
                              passwordController.text);
                          if(status == 200) {
                            setState(() {
                              circularBarIndicatorOpacity = false;
                              showDialog(context: context, builder: (_) {
                                return CupertinoAlertDialog(
                                  content: const Text("Регистрация \n прошла успешлно!", style: TextStyle(
                                    color: Colors.green
                                  ),),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.pushNamed(context, '/login');
                                      }, child: const Text("Ok"))
                                  ],
                                );
                              });
                            });
                          } else {
                            setState(() {
                              errorTextOpacity = true;
                            });
                          }
                        }
                      },
                      child: const Text("Регистрация")),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    circularBarIndicatorOpacity ? const CircularProgressIndicator() : Container()
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    errorTextOpacity ? const Text("Такой пользователь уже существует!", style: TextStyle(color: Colors.red),) : Container()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
