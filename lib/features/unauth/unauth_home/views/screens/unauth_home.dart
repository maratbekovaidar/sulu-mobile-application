
import 'package:flutter/material.dart';
import 'package:sulu_mobile_application/features/home/views/screens/appbar/category_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/appbar/drawer/drawer.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/bookmark_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/cart_page.dart';
import 'package:sulu_mobile_application/features/home/views/screens/navbar_pages/hello_page.dart';
import 'package:sulu_mobile_application/features/profile/views/screens/profile_page.dart';
import 'package:sulu_mobile_application/utils/bloc/appointment/appointment_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/establishment/establishment_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/favorite/favorite_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/main_banner/main_banner_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sulu_mobile_application/utils/repository/appointment_repository.dart';
import 'package:sulu_mobile_application/utils/repository/banner_repository.dart';
import 'package:sulu_mobile_application/utils/repository/establishment_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class UnAuthHomePage extends StatefulWidget {
  const UnAuthHomePage({Key? key}) : super(key: key);

  @override
  State<UnAuthHomePage> createState() => _UnAuthHomePageState();
}

class _UnAuthHomePageState extends State<UnAuthHomePage> {

  /// Dropdown value
  String dropdownValue = 'Нур-Султан';

  /// Index of Bottom Navbar
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Function? becomePartner() {
    showDialog(context: context, builder: (_) {

      TextEditingController _personController = TextEditingController();
      TextEditingController _feedbackController = TextEditingController();



      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text("Напишите отчет", textAlign: TextAlign.center),
        content: SizedBox(
          height: 170,
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: _personController,
                  decoration: const InputDecoration(
                      hintText: "Ваши контакты"
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _feedbackController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: "Ваш предложение",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.pop(context);
                String feedbackText = _feedbackController.value.text;
                String personText = _personController.value.text;
                String textOutput = "Контакты: " + personText + ".\nСообщение: " + feedbackText;
                var url = Uri.parse('https://api.telegram.org/bot5058514406:AAHBko2SdNPqQIemzUUEcB0sRBUBwABJx98/sendMessage?chat_id=-1001658501273&text=$textOutput');
                await http.post(url);
              },
              child: const Text("Отправить")
          )
        ],
      );
    });
    return null;
  }


  /// Repository
  EstablishmentRepository establishmentRepository = EstablishmentRepository();
  AppointmentRepository appointmentRepository = AppointmentRepository();
  BannerRepository bannerRepository = BannerRepository();

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
    FavoriteBloc favoriteBloc = FavoriteBloc();
    EstablishmentBloc establishmentBloc =
    EstablishmentBloc(establishmentRepository: establishmentRepository);
    AppointmentBloc appointmentBloc =
    AppointmentBloc(appointmentRepository: appointmentRepository);
    MainBannerBloc mainBannerBloc =
    MainBannerBloc(bannerRepository: bannerRepository);


    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => userBloc,
        ),
        BlocProvider(
          create: (context) => favoriteBloc,
        ),
        BlocProvider(
          create: (context) => establishmentBloc,
        ),
        BlocProvider(
          create: (context) => appointmentBloc,
        ),
        BlocProvider(
          create: (context) => mainBannerBloc,
        ),
      ],
      child: Scaffold(

        /// Drawer
        drawer: Drawer(
          child: ListView(
            children: [

              /// Header
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(


                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/background/drawer.png',
                      ),
                    )
                ),
                height: 150,
                child: Center(child: Image.asset('assets/logo/drawer_logo.png')),
              ),
              const SizedBox(height: 10),
              ListTileItem(
                onTap: (){
                  Navigator.pushNamed(context, "/login");
                },
                text: "Войти", icon: Icons.login_rounded
              ),
              ListTileItem(
                  onTap: (){
                    Navigator.pushNamed(context, "/register");
                  },
                  text: "Зарегистрироваться", icon: Icons.app_registration_rounded
              ),
              ListTileItem( onTap:()async{_launchURL();}, text: "Стать партнером", icon: Icons.wallet_travel_rounded),
              ListTileItem( onTap: (){becomePartner();}, text: "Техническая поддержка", icon: Icons.help_outline_rounded)
            ],
          ),
        ),

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


/// Open url of partners
const String _url = 'https://sulu.life';
Future _launchURL() async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

