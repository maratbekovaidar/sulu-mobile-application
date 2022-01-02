
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalonsPage extends StatefulWidget {
  const SalonsPage({Key? key}) : super(key: key);

  @override
  _SalonsPageState createState() => _SalonsPageState();
}

class _SalonsPageState extends State<SalonsPage> {
  
  @override
  Widget build(BuildContext context) {
    
    /// Size
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Салоны"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(height: 20),

          /// One Salon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: width * 0.90,
                  height: 200,
                  child: Column(
                    children: [

                      /// Image
                      Expanded(
                        child: Image.asset(
                          'assets/images/salon.jpg',
                          width: width * 0.9,
                          // height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// Information
                      Container(
                        color: const Color(0xffF8F8FB),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            /// Name and Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Top Beauty",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),

                                /// Rating
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14, color: Colors.grey,),
                                    Text("5.0", style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 5),

                            /// Address and Reports
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ул. Республика 17",
                                  style: GoogleFonts.inter(
                                    color: const Color(0xffBBBBBB),
                                    fontSize: 11
                                  ),
                                ),

                                Text(
                                  "4500 отзывов",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xffBBBBBB),
                                      fontSize: 11
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: width * 0.90,
                  height: 200,
                  child: Column(
                    children: [

                      /// Image
                      Expanded(
                        child: Image.asset(
                          'assets/images/salon.jpg',
                          width: width * 0.9,
                          // height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// Information
                      Container(
                        color: const Color(0xffF8F8FB),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            /// Name and Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Top Beauty",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),

                                /// Rating
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14, color: Colors.grey,),
                                    Text("5.0", style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 5),

                            /// Address and Reports
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ул. Республика 17",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xffBBBBBB),
                                      fontSize: 11
                                  ),
                                ),

                                Text(
                                  "4500 отзывов",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xffBBBBBB),
                                      fontSize: 11
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: width * 0.90,
                  height: 200,
                  child: Column(
                    children: [

                      /// Image
                      Expanded(
                        child: Image.asset(
                          'assets/images/salon.jpg',
                          width: width * 0.9,
                          // height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// Information
                      Container(
                        color: const Color(0xffF8F8FB),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            /// Name and Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Top Beauty",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),

                                /// Rating
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14, color: Colors.grey,),
                                    Text("5.0", style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 5),

                            /// Address and Reports
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ул. Республика 17",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xffBBBBBB),
                                      fontSize: 11
                                  ),
                                ),

                                Text(
                                  "4500 отзывов",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xffBBBBBB),
                                      fontSize: 11
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: width * 0.90,
                  height: 200,
                  child: Column(
                    children: [

                      /// Image
                      Expanded(
                        child: Image.asset(
                          'assets/images/salon.jpg',
                          width: width * 0.9,
                          // height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// Information
                      Container(
                        color: const Color(0xffF8F8FB),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            /// Name and Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Top Beauty",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),

                                /// Rating
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14, color: Colors.grey,),
                                    Text("5.0", style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 5),

                            /// Address and Reports
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ул. Республика 17",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xffBBBBBB),
                                      fontSize: 11
                                  ),
                                ),

                                Text(
                                  "4500 отзывов",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xffBBBBBB),
                                      fontSize: 11
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: width * 0.90,
                  height: 200,
                  child: Column(
                    children: [

                      /// Image
                      Expanded(
                        child: Image.asset(
                          'assets/images/salon.jpg',
                          width: width * 0.9,
                          // height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// Information
                      Container(
                        color: const Color(0xffF8F8FB),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            /// Name and Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Top Beauty",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),
                                ),

                                /// Rating
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 14, color: Colors.grey,),
                                    Text("5.0", style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),)
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 5),

                            /// Address and Reports
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ул. Республика 17",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xffBBBBBB),
                                      fontSize: 11
                                  ),
                                ),

                                Text(
                                  "4500 отзывов",
                                  style: GoogleFonts.inter(
                                      color: const Color(0xffBBBBBB),
                                      fontSize: 11
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      )
    );
  }
}
