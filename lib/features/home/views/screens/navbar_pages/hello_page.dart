import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/home/views/carousel/carousel.dart';
import 'package:sulu_mobile_application/utils/model/favorite_sulu_model.dart';
import 'package:sulu_mobile_application/utils/model/main_banner_model.dart';
import 'package:sulu_mobile_application/utils/model/service_model.dart';

class HelloPage extends StatefulWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {


  /// Data of MainBanner
  List<MainBannerModel> mainBanners = [
    MainBannerModel(title: "PartySet",
        description: "Save more than 50% off",
        imageUrl: "https://cdn3.vectorstock.com/i/1000x1000/45/32/orange-ripped-paper-background-banner-template-vector-20944532.jpg"),
    MainBannerModel(title: "PartySet",
        description: "Save more than 50% off",
        imageUrl: "https://cdn3.vectorstock.com/i/1000x1000/45/32/orange-ripped-paper-background-banner-template-vector-20944532.jpg"),
    MainBannerModel(title: "PartySet",
        description: "Save more than 50% off",
        imageUrl: "https://cdn3.vectorstock.com/i/1000x1000/45/32/orange-ripped-paper-background-banner-template-vector-20944532.jpg"),
    MainBannerModel(title: "PartySet",
        description: "Save more than 50% off",
        imageUrl: "https://cdn3.vectorstock.com/i/1000x1000/45/32/orange-ripped-paper-background-banner-template-vector-20944532.jpg"),
    MainBannerModel(title: "PartySet",
        description: "Save more than 50% off",
        imageUrl: "https://cdn3.vectorstock.com/i/1000x1000/45/32/orange-ripped-paper-background-banner-template-vector-20944532.jpg"),
    MainBannerModel(title: "PartySet",
        description: "Save more than 50% off",
        imageUrl: "https://cdn3.vectorstock.com/i/1000x1000/45/32/orange-ripped-paper-background-banner-template-vector-20944532.jpg"),
  ];

  /// Data of Favorite Banner
  List<FavoriteSuluModel> favoriteSuluBanners = [
    FavoriteSuluModel(
        imageUrl: "https://elen.kz/wp-content/uploads/2019/10/%D1%81%D0%B0%D0%BB1-1024x592.jpg",
        title: "Иван Иванов",
        rating: 5.0,
        subtitle: "Манюкюр"),
    FavoriteSuluModel(
        imageUrl: "https://elen.kz/wp-content/uploads/2019/10/%D1%81%D0%B0%D0%BB1-1024x592.jpg",
        title: "Иван Иванов",
        rating: 5.0,
        subtitle: "Манюкюр"),
    FavoriteSuluModel(
        imageUrl: "https://elen.kz/wp-content/uploads/2019/10/%D1%81%D0%B0%D0%BB1-1024x592.jpg",
        title: "Иван Иванов",
        rating: 5.0,
        subtitle: "Манюкюр"),
    FavoriteSuluModel(
        imageUrl: "https://elen.kz/wp-content/uploads/2019/10/%D1%81%D0%B0%D0%BB1-1024x592.jpg",
        title: "Иван Иванов",
        rating: 5.0,
        subtitle: "Манюкюр"),
  ];


  /// Data of Services Banner
  List<ServiceModel> servicesBanners = [
    ServiceModel(icon: const FaIcon(FontAwesomeIcons.crosshairs, size: 30,), title: "Волосы"),
    ServiceModel(icon: const FaIcon(FontAwesomeIcons.soap, size: 30,), title: "Уход за телом "),
    ServiceModel(icon: const FaIcon(FontAwesomeIcons.fingerprint, size: 30,), title: "Маникюр"),
    ServiceModel(icon: const FaIcon(FontAwesomeIcons.eye, size: 30,), title: "Брови")
  ];


  @override
  Widget build(BuildContext context) {

    /// Sizes
    double width = MediaQuery
        .of(context)
        .size
        .width;


    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              /// Search Bar
              const TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Поиск"
                ),
              ),
              const SizedBox(height: 20),

              /// Main Carousel
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Builder(
                    builder: (context) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 220,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          // autoPlay: false,
                        ),
                        items: mainBanners
                            .map((item) =>
                            Center(
                                child: Container(
                                  width: width,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/mainBanner.png"
                                        )
                                    ),
                                  ),
                                )
                            ))
                            .toList(),
                      );
                    },
                  )
              ),
              const SizedBox(height: 40),

              /// Favorites
              Row(
                children: [
                  Text("Фавориты SULU", style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black
                  ),),
                ],
              ),
              const SizedBox(height: 10),
              Carousel(
                height: 160,
                items: favoriteSuluBanners,
                builderFunction: (context, item) {
                  return SizedBox(
                    width: 250,
                    child: Column(
                      children: [

                        /// Image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item.imageUrl,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),

                        /// Name and Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            /// Title
                            Text(item.title, style: GoogleFonts.inter(),),

                            /// Rating
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.grey,),
                                Text(item.rating.toString(), style: GoogleFonts.inter(fontSize: 16, color: Colors.grey),)
                              ],
                            )
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              item.subtitle,
                              style: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 14
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              /// Услуги
              Row(
                children: [
                  Text("Услуги", style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black
                  ),),
                ],
              ),
              const SizedBox(height: 10),
              Carousel(
                height: 160,
                items: servicesBanners,
                builderFunction: (context, item) {
                  return SizedBox(
                    width: 140,
                    child: Column(
                      children: [

                        /// Image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: const Color(0xffF8F8FB),
                              child: Center(
                                child: item.icon,
                              ),
                            )
                          ),
                        ),
                        const SizedBox(height: 5),

                        /// Name and Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            /// Title
                            Text(item.title, style: GoogleFonts.inter(),),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              /// Sales
              Row(
                children: [
                  Text("Скидки", style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black
                  ),),
                ],
              ),
              const SizedBox(height: 10),
              Carousel(
                height: 160,
                items: favoriteSuluBanners,
                builderFunction: (context, item) {
                  return SizedBox(
                    width: 250,
                    child: Column(
                      children: [

                        /// Image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item.imageUrl,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),

                        /// Name and Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            /// Title
                            Text(item.title, style: GoogleFonts.inter(),),

                            /// Rating
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.grey,),
                                Text(item.rating.toString(), style: GoogleFonts.inter(fontSize: 16, color: Colors.grey),)
                              ],
                            )
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              item.subtitle,
                              style: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 14
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              /// Salons
              Row(
                children: [
                  Text("Салоны", style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black
                  ),),
                ],
              ),
              const SizedBox(height: 10),
              Carousel(
                height: 160,
                items: favoriteSuluBanners,
                builderFunction: (context, item) {
                  return SizedBox(
                    width: 250,
                    child: Column(
                      children: [

                        /// Image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              item.imageUrl,
                              width: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),

                        /// Name and Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            /// Title
                            Text(item.title, style: GoogleFonts.inter(),),

                            /// Rating
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.grey,),
                                Text(item.rating.toString(), style: GoogleFonts.inter(fontSize: 16, color: Colors.grey),)
                              ],
                            )
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              item.subtitle,
                              style: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 14
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

            ],
          ),
        )
      ],
    );
  }
}
