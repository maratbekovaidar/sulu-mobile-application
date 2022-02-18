import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/establishment/views/screens/establishment_page.dart';
import 'package:sulu_mobile_application/features/establishment/views/screens/establishments_page.dart';
import 'package:sulu_mobile_application/utils/bloc/establishment/establishment_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/favorite/favorite_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/user_bloc/user_bloc.dart';
import 'package:sulu_mobile_application/utils/model/main_banner_model.dart';
import 'package:sulu_mobile_application/utils/services/establishment_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelloPage extends StatefulWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  /// Data of MainBanner
  List<MainBannerModel> mainBanners = [
    MainBannerModel(
        title: "",
        description: "",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/sulutest-3de34.appspot.com/o/1.png?alt=media&token=84dde307-fe57-4b69-b7aa-95c6982e5090"),
    MainBannerModel(
        title: "",
        description: "",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/sulutest-3de34.appspot.com/o/2.png?alt=media&token=feb048f3-bbda-4bc0-891f-796975eab802"),
    MainBannerModel(
        title: "",
        description: "",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/sulutest-3de34.appspot.com/o/3.png?alt=media&token=0f3b96f8-615b-4f3b-b7ff-b417eabcaa43"),
    MainBannerModel(
        title: "",
        description: "",
        imageUrl:
            "https://firebasestorage.googleapis.com/v0/b/sulutest-3de34.appspot.com/o/4.png?alt=media&token=9c4782db-1130-4617-bc06-b1a27c621f54"),
    ];
  int _mainBannerIndex = 0;
  final CarouselController _mainBannerController = CarouselController();

  // List<int> favoritesId = [];
  //
  // /// Favorite status
  // bool getFavoriteStatus(int id) {
  //   if (favoritesId.contains(id)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  /// Provider
  final EstablishmentProvider _establishmentProvider = EstablishmentProvider();

  @override
  Widget build(BuildContext context) {
    /// Sizes
    double width = MediaQuery.of(context).size.width;

    /// Bloc
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    EstablishmentBloc establishmentBloc =
        BlocProvider.of<EstablishmentBloc>(context);

    return RefreshIndicator(
      onRefresh: () async {
        userBloc.add(UserLoadEvent());
        establishmentBloc.add(EstablishmentLoadEvent());
      },
      child: ListView(
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
                                  height: width / 2,
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
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  item.imageUrl)),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Волосы", typeId: 1)));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                title: "Удаление волос",
                                                typeId: 3,
                                              )));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Кометология",
                                                  typeId: 4)));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                title: "Ресницы",
                                                typeId: 6,
                                              )));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                  title: "Брови", typeId: 7)));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EstablishmentsPage(
                                                title: "Макияж",
                                                typeId: 8,
                                              )));
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
                      child: BlocBuilder<EstablishmentBloc, EstablishmentState>(
                        builder: (context, state) {
                          if (state is EstablishmentInitialState) {
                            establishmentBloc
                                .add(EstablishmentLoadPopularEvent());
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is EstablishmentLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is EstablishmentErrorState) {
                            return Center(
                              child: Text(
                                "Some Error",
                                style: GoogleFonts.inter(color: Colors.red),
                              ),
                            );
                          }

                          if (state is EstablishmentLoadedState) {
                            int itemLength = state.establishments.length;

                            return ListView.separated(
                                physics: const PageScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      indent: 10,
                                    ),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.establishments.length,
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
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EstablishmentPage(
                                                              establishmentModel:
                                                                  state.establishments[
                                                                      index]),
                                                    ),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    state.establishments[index]
                                                        .images[0],
                                                    width: 250,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              BlocBuilder<FavoriteBloc,
                                                      FavoriteState>(
                                                  builder:
                                                      (favContext, favState) {
                                                FavoriteBloc favoriteBloc =
                                                    BlocProvider.of<
                                                            FavoriteBloc>(
                                                        favContext);

                                                if (favState
                                                    is FavoriteInitial) {
                                                  favoriteBloc.add(
                                                      FavoriteLoadEvent(state
                                                          .establishments[index]
                                                          .id));
                                                }

                                                if (favState is FavoriteLoad) {
                                                  return Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          favoriteBloc.add(
                                                              FavoriteSetEvent(
                                                                  branchId: state
                                                                      .establishments[
                                                                          index]
                                                                      .id,
                                                                  context:
                                                                      favContext));
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 15,
                                                          child: FutureBuilder(
                                                              future: favoriteBloc
                                                                  .checkFavorite(state
                                                                      .establishments[
                                                                          index]
                                                                      .id),
                                                              builder: (context,
                                                                  AsyncSnapshot
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Icon(
                                                                    snapshot.data
                                                                        ? Icons
                                                                            .favorite
                                                                        : Icons
                                                                            .favorite_outline_rounded,
                                                                    color: Colors
                                                                        .redAccent,
                                                                    size: 16,
                                                                  );
                                                                } else {
                                                                  return SizedBox();
                                                                }
                                                              }),
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              })
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),

                                        /// Name and Rating
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            /// Title
                                            Text(
                                              state.establishments[index].name,
                                              style: GoogleFonts.inter(),
                                            ),

                                            /// Rating
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  state.establishments[index]
                                                      .rating
                                                      .toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                )
                                              ],
                                            )
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                              state.establishments[index]
                                                  .address,
                                              style: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                  if (index == 0) {
                                    return Padding(
                                      child: item,
                                      padding: const EdgeInsets.only(left: 0),
                                    );
                                  } else if (index == itemLength - 1) {
                                    return Padding(
                                      child: item,
                                      padding: const EdgeInsets.only(right: 10),
                                    );
                                  }
                                  return item;
                                });
                          }

                          return const Center(
                            child: Text("Unknown error"),
                          );
                        },
                      ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// Bloc Carousel
                    SizedBox(
                      height: 180,
                      child: BlocBuilder<EstablishmentBloc, EstablishmentState>(
                        builder: (context, state) {
                          if (state is EstablishmentInitialState) {
                            establishmentBloc.add(EstablishmentLoadEvent());
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is EstablishmentLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is EstablishmentErrorState) {
                            return Center(
                              child: Text(
                                "Some Error",
                                style: GoogleFonts.inter(color: Colors.red),
                              ),
                            );
                          }

                          if (state is EstablishmentLoadedState) {
                            int itemLength = state.establishments.length;

                            return ListView.separated(
                                physics: const PageScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      indent: 10,
                                    ),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.establishments.length,
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
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EstablishmentPage(
                                                              establishmentModel:
                                                                  state.establishments[
                                                                      index]),
                                                    ),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    state.establishments[index]
                                                        .images[0],
                                                    width: 250,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              BlocBuilder<FavoriteBloc,
                                                      FavoriteState>(
                                                  builder:
                                                      (favContext, favState) {
                                                FavoriteBloc favoriteBloc =
                                                    BlocProvider.of<
                                                            FavoriteBloc>(
                                                        favContext);

                                                if (favState
                                                    is FavoriteInitial) {
                                                  favoriteBloc.add(
                                                      FavoriteLoadEvent(state
                                                          .establishments[index]
                                                          .id));
                                                }

                                                if (favState is FavoriteLoad) {
                                                  return Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          favoriteBloc.add(
                                                              FavoriteSetEvent(
                                                                  branchId: state
                                                                      .establishments[
                                                                          index]
                                                                      .id,
                                                                  context:
                                                                      favContext));
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 15,
                                                          child: FutureBuilder(
                                                              future: favoriteBloc
                                                                  .checkFavorite(state
                                                                      .establishments[
                                                                          index]
                                                                      .id),
                                                              builder: (context,
                                                                  AsyncSnapshot
                                                                      snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Icon(
                                                                    snapshot.data
                                                                        ? Icons
                                                                            .favorite
                                                                        : Icons
                                                                            .favorite_outline_rounded,
                                                                    color: Colors
                                                                        .redAccent,
                                                                    size: 16,
                                                                  );
                                                                } else {
                                                                  return SizedBox();
                                                                }
                                                              }),
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              })
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),

                                        /// Name and Rating
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            /// Title
                                            Text(
                                              state.establishments[index].name,
                                              style: GoogleFonts.inter(),
                                            ),

                                            /// Rating
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  state.establishments[index]
                                                      .rating
                                                      .toString(),
                                                  style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                )
                                              ],
                                            )
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                              state.establishments[index]
                                                  .address,
                                              style: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                  if (index == 0) {
                                    return Padding(
                                      child: item,
                                      padding: const EdgeInsets.only(left: 0),
                                    );
                                  } else if (index == itemLength - 1) {
                                    return Padding(
                                      child: item,
                                      padding: const EdgeInsets.only(right: 10),
                                    );
                                  }
                                  return item;
                                });
                          }

                          return const Center(
                            child: Text("Unknown error"),
                          );
                        },
                      ),
                    ),
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
