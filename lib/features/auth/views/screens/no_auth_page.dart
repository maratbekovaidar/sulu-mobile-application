import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/home/views/screens/appbar/drawer/drawer.dart';
import 'package:sulu_mobile_application/utils/model/main_banner_model.dart';
import 'package:sulu_mobile_application/utils/services/establishment_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class NoAuthPage extends StatefulWidget {
  const NoAuthPage({Key? key}) : super(key: key);

  @override
  _NoAuthPageState createState() => _NoAuthPageState();
}

class _NoAuthPageState extends State<NoAuthPage> {
  /// Data of MainBanner
  List<MainBannerModel> mainBanners = [
    MainBannerModel(
      1,
      "https://cdn3.vectorstock.com/i/1000x1000/45/32/orange-ripped-paper-background-banner-template-vector-20944532.jpg",
      "https://cdn3.vectorstock.com/i/1000x1000/45/32/orange-ripped-paper-background-banner-template-vector-20944532.jpg",
      1
    ),
  ];
  int _mainBannerIndex = 0;
  final CarouselController _mainBannerController = CarouselController();

  List<int> favoritesId = [];

  /// Favorite status
  bool getFavoriteStatus(int id) {
    if (favoritesId.contains(id)) {
      return true;
    } else {
      return false;
    }
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

  void updateFavorites() {
    _establishmentProvider
        .getFavoriteEstablishments()
        .then((favoriteEstablishments) {
      setState(() {
        favoritesId = favoriteEstablishments.map((e) => e.id).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    updateFavorites();
  }

  /// Provider
  final EstablishmentService _establishmentProvider = EstablishmentService();

  @override
  Widget build(BuildContext context) {
    /// Sizes
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(),
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                /// Main Carousel
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Builder(
                          builder: (context) {
                            return CarouselSlider(
                              options: CarouselOptions(
                                  height: width / 2.2,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  autoPlay: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _mainBannerIndex = index;
                                    });
                                  }),
                              carouselController: _mainBannerController,
                              items: mainBanners
                                  .map((item) => Center(
                                  child: Container(
                                    width: width,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/mainBanner.png")),
                                    ),
                                  )))
                                  .toList(),
                            );
                          },
                        )),
                    Align(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: mainBanners.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                _mainBannerController.animateToPage(entry.key),
                            child: Container(
                              width: 10.0,
                              height: 10.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Colors.white).withOpacity(
                                      _mainBannerIndex == entry.key
                                          ? 0.9
                                          : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                /// Услуги
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Услуги",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ],
                    ),


                    /// Услгуи
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Hair
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/services/hair.svg',
                                      color: Colors.redAccent,
                                      width: width / 4 - 60,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Волосы",
                                      style: GoogleFonts.inter(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),

                              /// Ногти
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/services/finger.svg',
                                      color: Colors.redAccent,
                                      width: width / 4 - 60,
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "Ногти",
                                      style: GoogleFonts.inter(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),

                              /// Удаление волос
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);

                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/services/hair_delete.svg',
                                      color: Colors.redAccent,
                                      width: width / 4 - 60,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Удаление \n волос",
                                      style: GoogleFonts.inter(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),

                              /// Косметалогия
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);

                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/services/cosmetic.svg',
                                      color: Colors.redAccent,
                                      width: width / 4 - 60,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Косметалогия",
                                      style: GoogleFonts.inter(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Ресницы
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);

                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/services/eyelashes.svg',
                                      color: Colors.redAccent,
                                      width: width / 4 - 60,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Ресницы",
                                      style: GoogleFonts.inter(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),

                              /// Брови
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);

                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/services/brow.svg',
                                      color: Colors.redAccent,
                                      width: width / 4 - 60,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Брови",
                                      style: GoogleFonts.inter(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),

                              /// Макияж
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);

                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/services/makeup.svg',
                                      color: Colors.redAccent,
                                      width: width / 4 - 60,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Макияж",
                                      style: GoogleFonts.inter(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),

                              /// Уход за телом
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);

                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/services/spa.svg',
                                      color: Colors.redAccent,
                                      width: width / 4 - 60,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Уход за телом",
                                      style: GoogleFonts.inter(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                /// Favorites
                Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Фавориты Sulu",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// Bloc Carousel
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                                physics: const PageScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                const Divider(
                                  indent: 10,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  Widget item = SizedBox(
                                    width: 250,
                                    child: Column(
                                      children: [
                                        /// Image
                                        Expanded(
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  child: Image.network(
                                                    "https://images.squarespace-cdn.com/content/v1/5edee990a8696a7b8618fe6d/1592969100838-LFYK2NLO6IOIP3XJ2IUA/salon.jpg",
                                                    width: 250,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(5.0),
                                                  child: GestureDetector(
                                                    onTap:(){
                                                      Navigator.pop(context);
                                                    },
                                                    child:const  CircleAvatar(
                                                      radius: 15,
                                                      child: Icon(
                                                         Icons
                                                            .favorite_outline_rounded,
                                                        color: Colors.redAccent,
                                                        size: 16,
                                                      ),
                                                      backgroundColor:
                                                      Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),

                                        /// Name and Rating

                                      ],
                                    ),
                                  );

                                  return item;
                                }),

                    ),
                    const SizedBox(height: 20),
                  ],
                ),

                /// Salons
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/salons');
                          },
                          child: Row(
                            children: [
                              Text(
                                "Салоны",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// Bloc Carousel

                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// Open url of partners
const String _url = 'https://sulu.life';
Future _launchURL() async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

