
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {


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
              children: [
                const SizedBox(height: 30),

                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Данные клиента",
                      style: GoogleFonts.inter(
                          color: const Color(0xff95798a),
                          fontWeight: FontWeight.bold,
                          fontSize: 26
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                /// First Name
                const TextField(
                  decoration: InputDecoration(
                      hintText: "Имя"
                  ),
                ),
                const SizedBox(height: 10),

                /// Last Name
                const TextField(
                  decoration: InputDecoration(
                      hintText: "Фамилия"
                  ),
                ),
                const SizedBox(height: 10),

                /// Middle Name
                const TextField(
                  decoration: InputDecoration(
                      hintText: "Отчество"
                  ),
                ),
                const SizedBox(height: 50),


                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Изменение пароля",
                      style: GoogleFonts.inter(
                          color: const Color(0xff95798a),
                          fontWeight: FontWeight.bold,
                          fontSize: 26
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                /// Last Password
                const TextField(
                  decoration: InputDecoration(
                      hintText: "Старый пароль"
                  ),
                ),
                const SizedBox(height: 10),

                /// New Password
                const TextField(
                  decoration: InputDecoration(
                      hintText: "Новыый пароль"
                  ),
                ),
                const SizedBox(height: 10),

                /// Re New password
                const TextField(
                  decoration: InputDecoration(
                      hintText: "Повторите новый пароль"
                  ),
                ),
                const SizedBox(height: 30),

                /// Button
                SizedBox(
                  width: width * 0.95,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      }, child:
                  const Text("Сохранить изменение")
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
