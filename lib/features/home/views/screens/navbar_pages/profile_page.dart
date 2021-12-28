
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    /// Sizes
    double width = MediaQuery.of(context).size.width;

    return ListView(
      children: [
        const SizedBox(height: 50),

        /// Avatar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              child: Stack(
                children: const [

                  /// Image
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage("https://sun9-5.userapi.com/impg/oZ3XputBBgRTCFrfuZGS9oM0RaehoA0BqPpV9g/oCkA5645n-k.jpg?size=1620x2160&quality=96&sign=d17ab50ecaf7a3c364fe524dd060a026&type=album"),
                  ),

                  /// Edit Button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff95798A),
                      radius: 20,
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),

        /// User name, surname
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aidar Maratbekov \n Aidynuly",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 25),


        /// Edit data of user
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Button action
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/edit_profile');
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  // shape: BoxShape.circle
                  border: Border.all(
                    color: const Color(0xff95798A)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// Icon and Title
                    Row(
                      children: [
                        const Icon(Icons.person_outline_outlined, color: Color(0xff95798A)),
                        const SizedBox(width: 10),
                        Text(
                          "Редактирование данные",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff95798A)
                          ),
                        ),
                      ],
                    ),

                    /// Arrow
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xff95798A),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        /// Favorites
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  // shape: BoxShape.circle
                  border: Border.all(
                      color: const Color(0xff95798A)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// Icon and Title
                  Row(
                    children: [
                      const Icon(Icons.favorite_outline_rounded, color: Color(0xff95798A)),
                      const SizedBox(width: 10),
                      Text(
                        "Избранные",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff95798A)
                        ),
                      ),
                    ],
                  ),

                  /// Arrow
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xff95798A),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        /// Support
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  // shape: BoxShape.circle
                  border: Border.all(
                      color: const Color(0xff95798A)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// Icon and Title
                  Row(
                    children: [
                      const Icon(Icons.settings_rounded, color: Color(0xff95798A)),
                      const SizedBox(width: 10),
                      Text(
                        "Поддержка",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff95798A)
                        ),
                      ),
                    ],
                  ),

                  /// Arrow
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xff95798A),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        /// Logout
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  // shape: BoxShape.circle
                  border: Border.all(
                      color: const Color(0xff95798A)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// Icon and Title
                  Row(
                    children: [
                      const Icon(Icons.exit_to_app, color: Color(0xff95798A)),
                      const SizedBox(width: 10),
                      Text(
                        "Выйти",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff95798A)
                        ),
                      ),
                    ],
                  ),

                  /// Arrow
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xff95798A),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

      ],
    );
  }
}
