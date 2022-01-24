
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/establishment/views/screens/establishments_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  bool hairSubcategory = false;
  bool fingerSubcategory = false;
  bool deleteHairSubcategory = false;
  bool cosmeticSubcategory = false;
  bool eyelashesSubcategory = false;
  bool browsSubcategory = false;
  bool makeupSubcategory = false;
  bool spaSubcategory = false;

  /// Search Controller
  TextEditingController searchController = TextEditingController();


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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                hintText: "Поиск..."
              ),
              onSubmitted: (text) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EstablishmentsPage(name: searchController.text,)));
              },
            ),
          ),

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
          hairSubcategory ? GestureDetector(
            onTap: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Волосы",
                                                  typeId: 1)));
            },
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
            ),
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

          /// Finger Subcategories
          fingerSubcategory ? GestureDetector(
            onTap: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Маникюр",
                                                  typeId: 2)));
            },
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
            ),
          ) : Container(),

          /// Delete Hair
          GestureDetector(
            onTap: () {
              setState(() {
                deleteHairSubcategory = !deleteHairSubcategory;
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

          /// Delete Hair Subcategories
          deleteHairSubcategory ? GestureDetector(
            onTap: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Удаление волос",
                                                  typeId: 3)));
            },
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
                        "Шугаринг",
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
                        "Эпиляция",
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
                        "Депиляция",
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
                        "Skins",
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
                        "Лазерное удаление",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) : Container(),

          /// Cosmetics
          GestureDetector(
            onTap: () {
              setState(() {
                cosmeticSubcategory = !cosmeticSubcategory;
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
                    "Косметология",
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

          /// Cosmetics Subcategory
          cosmeticSubcategory ? GestureDetector(
            onTap: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Косметология",
                                                  typeId: 4)));
            },
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
                        "Уход за лицом",
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
                        "Чистка лица",
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
                        "Аппаратное омоложивания",
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
                        "Уколы красоты",
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
                        "Лечебная косметология",
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
                        "Пилинг",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ) : Container(),

          /// Eyelashes
          GestureDetector(
            onTap: () {
              setState(() {
                eyelashesSubcategory = !eyelashesSubcategory;
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
          eyelashesSubcategory ? GestureDetector(
            onTap: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Ресницы",
                                                  typeId: 6)));
            },
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
                        "Коррекция",
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
                        "Ламинирование",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) : Container(),

          /// Brows
          GestureDetector(
            onTap: () {
              setState(() {
                browsSubcategory = !browsSubcategory;
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
          browsSubcategory ? GestureDetector(
            onTap: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Брови",
                                                  typeId: 7)));
            },
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
                        "Коррекция",
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
                        "Татуаж",
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
                        "Ламинирование",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),



              ],
            ),
          ) : Container(),

          /// Makeup
          GestureDetector(
            onTap: () {
              setState(() {
                makeupSubcategory = !makeupSubcategory;
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
          makeupSubcategory ? GestureDetector(
            onTap: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Макияж",
                                                  typeId: 8)));
            },
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
                        "Дневной",
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
                        "Вечерний",
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
                        "Свадебный",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) : Container(),

          /// Spa
          GestureDetector(
            onTap: () {
              setState(() {
                spaSubcategory = !spaSubcategory;
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
          spaSubcategory ? GestureDetector(
            onTap: () {
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Уход за телом",
                                                  typeId: 9)));
            },
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
                        "Массаж",
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
                        "Парение",
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
                        "Банные процедуры",
                        style: GoogleFonts.inter(
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) : Container(),

        ],
      ),
    );
  }
}
