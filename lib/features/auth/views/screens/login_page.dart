import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/utils/services/user_service.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {

  /// Api provider
  UserService provider = UserService();

  /// Checkbox
  bool isChecked = false;

  /// Password Visibility
  bool passwordObscurity = true;


  /// TextField Controller
  TextEditingController phoneNumberController = TextEditingController();
  bool isButtonDisabled = true;
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
                        color: const Color(0xffFF385C),
                        fontWeight: FontWeight.bold,
                        fontSize: 26
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Phone Number
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isEmpty ||
                        value.length <= 9) {
                      setState(() {
                        isButtonDisabled = true;
                      });
                    } else if(value.length>9) {
                      setState(() {
                        isButtonDisabled = false;
                      });
                    }
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                        padding:
                        EdgeInsets.only(left: 15, top: 15, bottom: 15),
                        child: Text(
                          '+7',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(45, 45, 45, 1)),
                        )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)),
                    hintText: "777-777-77-77",
                    counterText: ""
                  ),
                  maxLength: 10,
                ),
                const SizedBox(height: 10),

                /// Password
                TextField(
                  obscureText: passwordObscurity,
                  decoration: InputDecoration(
                    hintText: "Пароль",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordObscurity = !passwordObscurity;
                        });
                      },
                      icon: Icon(
                        passwordObscurity ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.redAccent,
                      )
                    )
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
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Colors.redAccent),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ),
                        Text(
                          "Запомнить меня",
                          style: GoogleFonts.inter(
                            fontSize: 12,
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
                              fontSize: 12,
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
                          errorStatusOpacity = false;
                          circularIndicatorOpacity = true;
                        });

                        try {
                          log("Phone number: " + phoneNumberController.text + ", Password: " + passwordController.text);
                          bool status = await provider.login("+7" + phoneNumberController.text, passwordController.text);
                          setState(() {
                            circularIndicatorOpacity = false;
                          });
                          if(status) {
                            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                          } else {
                            setState(() {
                              errorStatusOpacity = true;
                            });
                          }
                        } catch(e) {
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
