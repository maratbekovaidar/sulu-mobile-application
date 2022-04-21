
import 'package:flutter/material.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/reset_password/password_confirm_reset_password_page.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/step_registration/info_registration_step.dart';
import 'package:sulu_mobile_application/features/auth/views/ui/my_clipper.dart';
import 'package:sulu_mobile_application/features/auth/views/ui/shake_animation/shake_widget.dart';
import 'package:sulu_mobile_application/utils/services/user_service.dart';
import 'package:timer_count_down/timer_count_down.dart';


class OtpResetPasswordPage extends StatefulWidget {
  const OtpResetPasswordPage({Key? key, required this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  State<OtpResetPasswordPage> createState() => _OtpResetPasswordPageState();
}

class _OtpResetPasswordPageState extends State<OtpResetPasswordPage> {

  /// Provider
  final UserService _userProvider = UserService();

  /// Global animation key
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  /// Phone Controller
  TextEditingController phoneNumberController = TextEditingController();

  /// States
  String phoneNumberValidState = "loading";

  /// Phone number formatter
  var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.eager
  );

  /// OTP code Controllers
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 20),
              color: Color.fromRGBO(2, 32, 44, 0.05),
              spreadRadius: 10,
              blurRadius: 15)
        ]
    );
  }

  BoxDecoration get _pinPutSelectedDecoration {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 20),
              color: Color.fromRGBO(2, 32, 44, 0.05),
              spreadRadius: 10,
              blurRadius: 15)
        ]
    );
  }

  /// Send OTP again
  bool sendOtpAgain = false;
  final CountdownController _controller = CountdownController(autoStart: true);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.red,
      ),
      backgroundColor: Colors.redAccent,
      body: ListView(
        children: [
          Stack(
            children: [

              /// Wave
              ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 300,
                    color: Colors.white,
                  )
              ),

              /// Content
              SizedBox(
                height: height - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// Main Block
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        /// Illustration
                        SvgPicture.asset(
                          "assets/auth/auth_2.svg",
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
                                      "Код подтверждение",
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
                                      "Шаг 1 из 2",
                                      style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              /// Otp PinPut
                              SizedBox(
                                width: width * 0.85,
                                child: ShakeWidget(
                                  key: _shakeKey,
                                  // 5. configure the animation parameters
                                  shakeCount: 3,
                                  shakeOffset: 10,
                                  shakeDuration: const Duration(milliseconds: 400),
                                  child: PinPut(
                                    onChanged: (value) {},
                                    textStyle:
                                    GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
                                    fieldsCount: 6,
                                    eachFieldHeight: 44,
                                    eachFieldWidth: 44,
                                    animationCurve: Curves.ease,
                                    focusNode: _pinPutFocusNode,
                                    controller: _pinPutController,
                                    submittedFieldDecoration: _pinPutDecoration,
                                    selectedFieldDecoration: _pinPutSelectedDecoration,
                                    disabledDecoration: _pinPutDecoration,
                                    followingFieldDecoration: _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    inputDecoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent)
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent)
                                      ),
                                      counterText: "",
                                    ),
                                    onSubmit: (value) async {
                                      int verifyStatus = await _userProvider.confirmOtp("7" + widget.phoneNumber, value);
                                      if(verifyStatus == 200) {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordConfirmResetPasswordPage(phoneNumber: widget.phoneNumber)));
                                      } else {
                                        _shakeKey.currentState?.shake();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        /// Send OTP again
                        SizedBox(
                          width: width * 0.85,
                          child: Row(
                            children: [

                              /// Label
                              GestureDetector(
                                onTap: sendOtpAgain ? () async {
                                  _controller.restart();
                                  setState(() {
                                    sendOtpAgain = false;
                                  });
                                  await _userProvider.sendOtp("7"+maskFormatter.getUnmaskedText());
                                } : () {},
                                child: Text(
                                  "Отправить код повторно ",
                                  style: TextStyle(
                                      color: sendOtpAgain ? Colors.white :Colors.white38
                                  ),
                                ),
                              ),

                              /// Timer
                              Countdown(
                                controller: _controller,
                                seconds: 30,
                                build: (_, double time) => Text(
                                  time.round().toString(),
                                  style: const TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                                interval: const Duration(milliseconds: 100),
                                onFinished: () {
                                  setState(() {
                                    sendOtpAgain = true;
                                  });
                                },
                              ),

                            ],
                          ),
                        )
                      ],
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
                                  int otpStatus = await _userProvider.confirmOtp(
                                      "7" + widget.phoneNumber, _pinPutController.text);
                                  if(otpStatus == 200) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordConfirmResetPasswordPage(phoneNumber: widget.phoneNumber)));
                                  } else {
                                    _shakeKey.currentState?.shake();
                                  }
                                },
                                child: const Text(
                                  "Подтвердить",
                                  style: TextStyle(
                                      color: Colors.redAccent
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        )
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
