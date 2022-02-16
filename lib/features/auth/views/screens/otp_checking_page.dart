import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sulu_mobile_application/utils/services/user_provider.dart';

class OtpCheckingPage extends StatefulWidget {

  const OtpCheckingPage({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;


  @override
  _OtpCheckingPageState createState() => _OtpCheckingPageState();
}

class _OtpCheckingPageState extends State<OtpCheckingPage> {
  UserProvider _userProvider = UserProvider();


  double opacity = 0;
  bool isButtonDisabled = true;
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
        ]);
  }

  bool isRepeatSmsDisabled = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: ListView(
          children: [

             Padding(
              padding: EdgeInsets.only(top:60.0),
              child: Text("Код подтверждения", style: GoogleFonts.inter(
              color: const Color(0xffFF385C),
          fontWeight: FontWeight.w700,
          fontSize: 22),),
            ),
            const SizedBox(height: 15,),
            Text("Чтобы потвердить, что вы являетесь влдельцом номера, пожалуйста, введите последние 6 цифры номера, с которого поступит звонок-сброс",
            style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.w400,fontSize: 13),),

            const SizedBox(height: 35,),

            PinPut(
              onChanged: (value) {

              },
              textStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 18
              ),
              fieldsCount: 6,
              eachFieldHeight: 55,
              eachFieldWidth: 55,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: _pinPutDecoration,
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration:
              _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
            ),
            const SizedBox(height: 35,),
            ElevatedButton(
                onPressed: () async {

                  int otpStatus= await _userProvider.confirmOtp("+7"+widget.phoneNumber, _pinPutController.text);
                  if(otpStatus==200){
                    Navigator.pushNamed(context, '/login');
                  }else if(await _userProvider.confirmOtp("+7"+widget.phoneNumber, _pinPutController.text)==403){
                  }


                },
                child: const Text("Зарегестрироваться"))




          ],
        ),
      ),
    );
  }
}
