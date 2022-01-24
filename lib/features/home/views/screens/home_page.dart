import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sulu_mobile_application/features/home/views/screens/appbar/category_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/appbar/drawer.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/bookmark_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/cart_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/hello_page.dart';
import 'package:sulu_mobile_application/features/profile/views/screens/profile_page.dart';
import 'package:sulu_mobile_application/utils/bloc/appointment/appointment_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/establishment/establishment_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sulu_mobile_application/utils/repository/appointment_repository.dart';
import 'package:sulu_mobile_application/utils/repository/establishment_repository.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  /// Dropdown value
  String dropdownValue = 'Нур-Султан';

  /// Index of Bottom Navbar
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Repository
  EstablishmentRepository establishmentRepository = EstablishmentRepository();
  AppointmentRepository appointmentRepository = AppointmentRepository();

  @override
  Widget build(BuildContext context) {

    /// Bottom Navbar pages
    List<Widget> pages = [
      const HelloPage(),
      const BookmarkPage(),
      const CartPage(),
      const ProfilePage()
    ];

    /// Bloc
    UserBloc userBloc = UserBloc();
    EstablishmentBloc establishmentBloc =
        EstablishmentBloc(establishmentRepository: establishmentRepository);
    AppointmentBloc appointmentBloc =
        AppointmentBloc(appointmentRepository: appointmentRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => userBloc,
        ),
        BlocProvider(
          create: (context) => establishmentBloc,
        ),
        BlocProvider(
          create: (context) => appointmentBloc,
        ),
      ],
      child: Scaffold(

        /// Drawer
        drawer: const SuluDrawer(),

        /// AppBar
        appBar: AppBar(

          /// Burger
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const CategoryPage();
                    })
                  );
                },
                icon: const Icon(
                  Icons.search,
                  size: 30,
                ))
          ],
        ),

        body: pages[_selectedIndex],

        /// Bottom Navbar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          unselectedItemColor: const Color(0xffBBBBBB),
          selectedItemColor: const Color(0xffFF385C),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Главная"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark), label: "Мои записи"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: "Магазин"),
          ],
        ),
      ),
    );
  }
}
