import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sulu_mobile_application/features/auth/views/screens/step_registration/otp_registration_step.dart';
import 'package:sulu_mobile_application/features/auth/views/ui/my_clipper.dart';
import 'package:sulu_mobile_application/utils/services/user_service.dart';

class PersonalRegistrationStep extends StatefulWidget {
  const PersonalRegistrationStep({Key? key}) : super(key: key);

  @override
  State<PersonalRegistrationStep> createState() => _PersonalRegistrationStepState();
}

class _PersonalRegistrationStepState extends State<PersonalRegistrationStep> {

  /// Provider
  final UserService _userProvider = UserService();

  /// Phone Controller
  TextEditingController phoneNumberController = TextEditingController();

  /// States
  String phoneNumberValidState = "null";

  /// Phone number formatter
  var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.eager
  );

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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

            /// Content
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// Main Block
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    /// Illustration
                    SvgPicture.asset(
                      "assets/auth/auth_1.svg",
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
                                  "Введите номер телефона",
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
                          const SizedBox(height: 30),

                          /// Phone Number
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width * 0.85,
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    maskFormatter
                                  ],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: const Color(0xff570404),
                                    filled: true,
                                    prefixIcon: const Padding(
                                        padding:
                                        EdgeInsets.only(left: 15, top: 15, bottom: 15),
                                        child: Text(
                                          '+7',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                    ),
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
                                    hintText: "(777) 777-77-77",
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white38
                                    ),
                                    errorText: phoneNumberValidState == "exist" ? "Такой номер уже существует" : null,
                                    errorStyle: const TextStyle(
                                      color: Colors.yellow
                                    ),

                                    /// Phone number valid indicator
                                    suffixIcon: maskFormatter.getUnmaskedText().length == 10 ? (
                                      phoneNumberValidState == "valid" ? const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ) : phoneNumberValidState == "exist" ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            phoneNumberController.clear();
                                            phoneNumberValidState = "null";
                                          });
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.redAccent,
                                        ),
                                      ) : phoneNumberValidState == "loading" ? Transform.scale(
                                        scale: 0.5,
                                        child: const CircularProgressIndicator(color: Colors.yellow),
                                      ) : null
                                    ) : null,
                                    counterText: "",
                                  ),
                                  onChanged: (value) async {
                                    if(maskFormatter.getUnmaskedText().length == 10) {
                                      setState(() {
                                        phoneNumberValidState = "loading";
                                      });
                                      int phoneNumberStatus = await _userProvider.verifyPhoneNumber("7" + maskFormatter.getUnmaskedText());
                                      if(phoneNumberStatus == 200) {
                                        setState(() {
                                          phoneNumberValidState = "valid";
                                        });
                                      } else {
                                        setState(() {
                                          phoneNumberValidState = "exist";
                                        });
                                      }
                                    }

                                    if(maskFormatter.getUnmaskedText().length == 9) {
                                      setState(() {
                                        phoneNumberValidState = "null";
                                      });
                                    }
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

                const SizedBox(height: 100),

                /// Button
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.85,
                          child: ElevatedButton(
                             onPressed: phoneNumberValidState == "valid" ? () async {
                               try {
                                 int otpStatus = await _userProvider.sendOtp("7"+maskFormatter.getUnmaskedText());
                                 if(otpStatus == 200) {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => OtpRegistrationStep(phoneNumber: maskFormatter.getUnmaskedText())));
                                 } else {
                                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                     content: Text("Не удалось отправить код подтверждение"),
                                   ));
                                 }
                               } catch(e) {
                                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                   content: Text("Не удалось отправить код подтверждение"),
                                 ));
                               }
                            } : () {},
                            child: const Text(
                              "Получить код подтверждение",
                              style: TextStyle(
                                color: Colors.redAccent
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(phoneNumberValidState == "valid" ? Colors.white : Colors.red[300]),
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
    );
  }
}
