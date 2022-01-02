import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/bookmark_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/cart_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/hello_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/profile_page.dart';
import 'package:sulu_mobile_application/utils/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /// Data
  /// Dropdown value
  String dropdownValue = 'Нур-Султан';

  /// Data of Bottom Navbar
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [
    const HelloPage(),
    const BookmarkPage(),
    const CartPage(),
    const ProfilePage()
  ];


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => UserBloc(),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 130,

          /// City
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              elevation: 16,
              style: GoogleFonts.inter(color: Colors.white),
              underline: null,
              dropdownColor: const Color(0xff95798a),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Нур-Султан', 'Алматы', 'Шымкент', 'Семей']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.inter(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),

          /// Burger
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 30,
                ))
          ],
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          unselectedItemColor: const Color(0xffBBBBBB),
          selectedItemColor: const Color(0xff95798a),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Главная"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: "Мои записи"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: "Корзина"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: "Аккаунт"
            ),
          ],
        ),
      ),
    );
  }
}
