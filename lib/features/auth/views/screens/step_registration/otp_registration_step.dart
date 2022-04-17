
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sulu_mobile_application/features/auth/views/ui/my_clipper.dart';
import 'package:sulu_mobile_application/utils/services/user_service.dart';

class OtpRegistrationStep extends StatefulWidget {
  const OtpRegistrationStep({Key? key}) : super(key: key);

  @override
  State<OtpRegistrationStep> createState() => _OtpRegistrationStepState();
}

class _OtpRegistrationStepState extends State<OtpRegistrationStep> {
  /// Provider
  final UserService _userProvider = UserService();

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

  bool isRepeatSmsDisabled = true;


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
                                      "Шаг 1 из 3",
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
                                child: PinPut(
                                  onChanged: (value) {},
                                  textStyle:
                                  GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
                                  fieldsCount: 6,
                                  eachFieldHeight: 44,
                                  eachFieldWidth: 44,
                                  focusNode: _pinPutFocusNode,
                                  controller: _pinPutController,
                                  submittedFieldDecoration: _pinPutDecoration,
                                  selectedFieldDecoration: _pinPutDecoration,
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
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                onPressed: () {},
                                child: const Text(
                                  "Получить код подтверждение",
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
