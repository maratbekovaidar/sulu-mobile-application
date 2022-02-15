import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/utils/model/city_model.dart';
import 'package:sulu_mobile_application/utils/services/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  /// Provider
  final UserProvider _userProvider = UserProvider();

  /// Cities
  List<CityModel> cities = [];
  void getCities(BuildContext context) async {
    cities = await _userProvider.getCities();
    city = cities[0];
    setState(() {

    });
  }

  /// Input Controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  CityModel city = CityModel(id: 1, name: "Алма-ата");
  
  /// Validate
  bool _firstNameValidate = true;
  bool _lastNameValidate = true;
  bool _phoneNumberValidate = true;
  bool _passwordValidate = true;
  bool _confirmPasswordValidate = true;
  bool agree = true;

  /// Validator
  void registerValidator() {
    if (firstNameController.text.isNotEmpty) {
      setState(() {
        _firstNameValidate = true;
      });
    } else {
      setState(() {
        _firstNameValidate = false;
      });
    }
    if (lastNameController.text.isNotEmpty) {
      setState(() {
        _lastNameValidate = true;
      });
    } else {
      setState(() {
        _lastNameValidate = false;
      });
    }
    if (phoneNumberController.text.isNotEmpty) {
      setState(() {
        _phoneNumberValidate = true;
      });
    } else {
      setState(() {
        _phoneNumberValidate = false;
      });
    }
    if (passwordController.text.isNotEmpty) {
      setState(() {
        _passwordValidate = true;
      });
    } else {
      setState(() {
        _passwordValidate = false;
      });
    }
    if (confirmPasswordController.text == passwordController.text &&
        confirmPasswordController.text.isNotEmpty) {
      setState(() {
        _confirmPasswordValidate = true;
      });
    } else {
      setState(() {
        _confirmPasswordValidate = false;
      });
    }
  }

  /// Opacity
  bool circularBarIndicatorOpacity = false;
  bool errorTextOpacity = false;
  bool isButtonDisabled = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => getCities(context));
  }

  @override
  Widget build(BuildContext context) {

    /// Size
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Регистрация клиента",
                      style: GoogleFonts.inter(
                          color: const Color(0xffFF385C),
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                /// First Name
                TextField(
                  decoration: InputDecoration(
                      hintText: "Имя",
                      errorText: _firstNameValidate ? null : "Введите имя"),
                  controller: firstNameController,
                ),
                const SizedBox(height: 10),

                /// Last Name
                TextField(
                  decoration: InputDecoration(
                      hintText: "Фамилия",
                      errorText: _lastNameValidate ? null : "Введите фамилию"),
                  controller: lastNameController,
                ),
                const SizedBox(height: 10),

                /// Phone Number
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isEmpty || value.length <= 9) {
                      setState(() {
                        isButtonDisabled = true;
                      });
                    } else if (value.length > 9) {
                      setState(() {
                        isButtonDisabled = false;
                      });
                    }
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
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
                  ),
                ),
                const SizedBox(height: 10),

                /// Select City
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  width: width - 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.red)
                  ),
                  child: DropdownButton<CityModel>(
                    isExpanded: true,
                    value: city,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (CityModel? newValue) {
                      setState(() {
                        city = newValue!;
                      });
                    },
                    items: cities.map<DropdownMenuItem<CityModel>>((CityModel value) {
                      return DropdownMenuItem<CityModel>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),

                /// Password
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Пароль",
                      errorText:
                          _passwordValidate == true ? null : "Введите пароль"),
                  controller: passwordController,
                ),
                const SizedBox(height: 10),

                /// Confirm Password
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Повторите пароль",
                      errorText: _confirmPasswordValidate == false
                          ? "Пароли не совпадают"
                          : null),
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 25),

                /// Agree
                Row(children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          agree = !agree;
                        });
                      },
                      child: !agree
                          ? const Icon(Icons.check_box_outline_blank, color: Colors.redAccent,)
                          : const Icon(
                              Icons.check_box,
                              color: Colors.red,
                            )),
                  const SizedBox(
                    width: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Согласен с ',
                      style: const TextStyle(
                          fontFamily: 'Montserrat', color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: "условиями пользования",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch('https://docs.google.com/document/d/1cvtTj-5tUHDFv1saAIVjJSNTYa5UlIq3/edit?usp=sharing&ouid=105666820019597166004&rtpof=true&sd=true');
                            },
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.redAccent),
                        ),
                        const TextSpan(text: ' и \n'),
                        TextSpan(
                          text: "политикой конфиденциальности",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch('https://docs.google.com/document/d/1cvtTj-5tUHDFv1saAIVjJSNTYa5UlIq3/edit?usp=sharing&ouid=105666820019597166004&rtpof=true&sd=true');
                            },
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.redAccent),
                        ),
                      ],
                    ),
                  )
                ]),
                const SizedBox(height: 25),


                /// Button
                SizedBox(
                  width: width * 0.95,
                  child: agree ? ElevatedButton(
                      onPressed: () async {
                        registerValidator();
                        if (_confirmPasswordValidate &&
                            _passwordValidate &&
                            _phoneNumberValidate &&
                            _lastNameValidate &&
                            _firstNameValidate) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            setState(() {
                              circularBarIndicatorOpacity = true;
                            });

                            log("Phone number: " + phoneNumberController.text + ", Password: " + passwordController.text);

                            int status = await _userProvider.register(
                                firstNameController.text,
                                lastNameController.text,
                                "",
                                "+7" + phoneNumberController.text,
                                passwordController.text,
                                city.id
                            );
                            if (status == 200) {
                              setState(() {
                                circularBarIndicatorOpacity = false;
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return CupertinoAlertDialog(
                                        content: const Text(
                                          "Регистрация \n прошла успешлно!",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/login');
                                              },
                                              child: const Text("Ok"))
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
                        }
                      },
                      child: const Text("Регистрация")) : ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black12)
                    ),
                    child: const Text("Регистрация"),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    circularBarIndicatorOpacity
                        ? const CircularProgressIndicator()
                        : Container()
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    errorTextOpacity
                        ? const Text(
                            "Такой пользователь уже существует!",
                            style: TextStyle(color: Colors.red),
                          )
                        : Container()
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
