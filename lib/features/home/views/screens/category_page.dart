
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  bool hairSubcategory = false;
  bool fingerSubcategory = false;

  @override
  Widget build(BuildContext context) {

    /// Size
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Категории"),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          /// Hairs
          GestureDetector(
            onTap: () {
              setState(() {
                hairSubcategory = !hairSubcategory;
              });
            },
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Волосы",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    hairSubcategory ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: Colors.black38,
                  )
                ],
              ),
            ),
          ),

          /// Hairs Subcategories
          hairSubcategory ? Expanded(
            child: Column(
              children: [
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Стрижка",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Окрашивание",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Укладка",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Наращивание",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Прическа",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Уход за волосами",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            )
          ) : Container(),


          /// Finger
          GestureDetector(
            onTap: () {
              setState(() {
                fingerSubcategory = !fingerSubcategory;
              });
            },
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ногти",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    fingerSubcategory ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: Colors.black38,
                  )
                ],
              ),
            ),
          ),

          /// Hairs Subcategories
          fingerSubcategory ? Expanded(
              child: Column(
                children: [
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black12))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Маникюр",
                          style: GoogleFonts.inter(
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black12))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Педикюкр",
                          style: GoogleFonts.inter(
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black12))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Снятие покрытие",
                          style: GoogleFonts.inter(
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black12))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Наращивание",
                          style: GoogleFonts.inter(
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black12))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Подология",
                          style: GoogleFonts.inter(
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black12))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Парафенотерапия",
                          style: GoogleFonts.inter(
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              )
          ) : Container(),

          GestureDetector(
            onTap: () {
              setState(() {
                hairSubcategory = !hairSubcategory;
              });
            },
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Удаление волос",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    hairSubcategory ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: Colors.black38,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                hairSubcategory = !hairSubcategory;
              });
            },
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Косметалогия",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    hairSubcategory ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: Colors.black38,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                hairSubcategory = !hairSubcategory;
              });
            },
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ресницы",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    hairSubcategory ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: Colors.black38,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                hairSubcategory = !hairSubcategory;
              });
            },
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Брови",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    hairSubcategory ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: Colors.black38,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                hairSubcategory = !hairSubcategory;
              });
            },
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Макияж",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    hairSubcategory ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: Colors.black38,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                hairSubcategory = !hairSubcategory;
              });
            },
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Уход за телом",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    hairSubcategory ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: Colors.black38,
                  )
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
