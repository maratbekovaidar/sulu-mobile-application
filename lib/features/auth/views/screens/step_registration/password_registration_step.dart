
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sulu_mobile_application/core/password_validation.dart';
import 'package:sulu_mobile_application/features/auth/views/ui/my_clipper.dart';
import 'package:sulu_mobile_application/utils/services/user_service.dart';

class PasswordRegistrationStep extends StatefulWidget {
  const PasswordRegistrationStep({Key? key, required this.firstName, required this.lastName, required this.phoneNumber}) : super(key: key);

  final String firstName;
  final String lastName;
  final String phoneNumber;


  @override
  State<PasswordRegistrationStep> createState() => _PasswordRegistrationStepState();
}

class _PasswordRegistrationStepState extends State<PasswordRegistrationStep> {

  /// Provider
  final UserService _userService = UserService();

  /// Text Field Controllers
  final _passwordFormKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  /// Obscurity state
  bool passwordObscurity = false;
  bool confirmPasswordObscurity = false;

  /// Password Validator
  final PasswordValidation _passwordValidation = PasswordValidation(
    // upperCaseValidate: true,
    // lowerCaseValidate: true,
    // digitCaseValidate: true,
    // symbolsCaseValidate: true,
  );

  bool loadingRegistration = false;

  @override
  Widget build(BuildContext context) {

    /// Sizes
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [

        /// Page
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.red,
          ),
          backgroundColor: Colors.redAccent,
          body: SingleChildScrollView(

            reverse: true,
            child: Stack(
              children: [

                /// Wave
                ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: 300,
                      color: Colors.white,
                    )
                ),

                /// Remove sized box with fixed height
                /// Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// Main Block
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          /// Illustration
                          SvgPicture.asset(
                            "assets/auth/auth_3.svg",
                            semanticsLabel: 'Acme Logo',
                            width: width,
                          ),

                          /// Labels and Inputs
                          SizedBox(
                            child: Column(
                              children: [

                                /// Title
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width * 0.85,
                                      child: const Text(
                                        "Придумайте пароль",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),

                                /// Step
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width * 0.85,
                                      child: const Text(
                                        "Шаг 3 из 3",
                                        style: TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),

                                /// Form
                                Form(
                                  key: _passwordFormKey,
                                  child: Column(
                                    children: [

                                      /// Password
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.85,
                                            child: TextFormField(
                                              controller: passwordController,
                                              keyboardType: TextInputType.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                              ),
                                              decoration: InputDecoration(
                                                fillColor: const Color(0xff570404),
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                disabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                hintText: "Пароль",
                                                hintStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white38
                                                ),
                                                errorStyle: const TextStyle(
                                                    color: Colors.yellow
                                                ),
                                                counterText: "",
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      passwordObscurity = !passwordObscurity;
                                                    });
                                                  },
                                                  icon: passwordObscurity ? const Icon(
                                                    Icons.visibility_off_rounded,
                                                    color: Colors.white,
                                                  ) : const Icon(
                                                    Icons.visibility_rounded,
                                                    color: Colors.white38,
                                                  ),
                                                )
                                              ),
                                              textInputAction: TextInputAction.next,
                                              obscureText: !passwordObscurity,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Без пароля никак :)';
                                                }
                                                return _passwordValidation.validatePassword(value);
                                              },
                                              // maxLength: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),

                                      /// Confirm Password
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.85,
                                            child: TextFormField(
                                              controller: confirmPasswordController,
                                              keyboardType: TextInputType.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                              ),
                                              decoration: InputDecoration(
                                                fillColor: const Color(0xff570404),
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                disabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(20)),
                                                hintText: "Повторите пароль",
                                                hintStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white38
                                                ),
                                                errorStyle: const TextStyle(
                                                    color: Colors.yellow
                                                ),
                                                counterText: "",
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      confirmPasswordObscurity = !confirmPasswordObscurity;
                                                    });
                                                  },
                                                  icon: confirmPasswordObscurity ? const Icon(
                                                    Icons.visibility_off_rounded,
                                                    color: Colors.white,
                                                  ) : const Icon(
                                                    Icons.visibility_rounded,
                                                    color: Colors.white38,
                                                  ),
                                              )
                                              ),
                                              textInputAction: TextInputAction.done,
                                              obscureText: !confirmPasswordObscurity,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Обезательное поле';
                                                }
                                                if (value != passwordController.text) {
                                                  return 'Пароли не совпадают';
                                                }
                                                return null;
                                              },
                                              // maxLength: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                    /// Button
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.85,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_passwordFormKey.currentState!.validate()) {
                                    setState(() {
                                      loadingRegistration = true;
                                    });
                                    int registerStatus = await _userService.register(
                                        widget.firstName,
                                        widget.lastName,
                                        "",
                                        "+7" + widget.phoneNumber,
                                        passwordController.text,
                                        1
                                    );

                                    if(registerStatus == 200) {
                                      bool loginStatus = await _userService.login("+7" + widget.phoneNumber, passwordController.text);
                                      if(loginStatus) {
                                        setState(() {
                                          loadingRegistration = false;
                                        });
                                        Navigator.pushNamed(context, '/');
                                      }
                                    } else {
                                      setState(() {
                                        loadingRegistration = false;
                                      });
                                    }
                                  }
                                },
                                child: const Text(
                                  "Зарегистрироваться",
                                  style: TextStyle(
                                      color: Colors.redAccent
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(true == true ? Colors.white : Colors.red[300]),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    )
                  ],
                )
              ],
            ),
          ),
        ),

        /// State
        loadingRegistration ? Container(
          width: width,
          height: height,
          color: Colors.black54,
          child: Center(
              child: Lottie.network("https://assets3.lottiefiles.com/datafiles/Vw1rVAqvuOsdNrv6RmbF2UyRovAs6AKqBOO76DSD/loader-success-failed.json")
          ),
        ) : Container(),
      ],
    );
  }
}
