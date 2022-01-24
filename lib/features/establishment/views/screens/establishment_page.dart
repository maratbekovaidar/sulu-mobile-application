import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/establishment/views/screens/order/order_set_date_page.dart';
import 'package:sulu_mobile_application/utils/bloc/comment/comment_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/master/master_bloc.dart';
import 'package:sulu_mobile_application/utils/bloc/service/service_bloc.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/master_model.dart';
import 'package:sulu_mobile_application/utils/repository/comment_repository.dart';
import 'package:sulu_mobile_application/utils/repository/master_repository.dart';
import 'package:sulu_mobile_application/utils/repository/service_repository.dart';
import 'package:sulu_mobile_application/utils/services/establishment_provider.dart';
import 'package:share/share.dart';
import 'package:sulu_mobile_application/constants/app_constants.dart' as constants;


class EstablishmentPage extends StatefulWidget {
  const EstablishmentPage({Key? key, required this.establishmentModel})
      : super(key: key);

  final EstablishmentModel establishmentModel;

  @override
  _EstablishmentPageState createState() => _EstablishmentPageState();
}

class _EstablishmentPageState extends State<EstablishmentPage>
    with TickerProviderStateMixin {
  /// Service
  bool hairSubcategory = true;

  /// Order Amount
  int orderAmount = 0;

  /// Establishment schedule
  late int firstDay;
  late int lastDay;

  /// Image carousel
  int _mainBannerIndex = 0;
  final CarouselController _mainBannerController = CarouselController();


  /// Repositories
  ServiceRepository serviceRepository = ServiceRepository();
  MasterRepository masterRepository = MasterRepository();
  CommentRepository commentRepository = CommentRepository();

  List<MasterModel> masters = [];


  final EstablishmentProvider _establishmentProvider = EstablishmentProvider();


  @override
  void initState() {
    super.initState();
    List<int> days = widget.establishmentModel.schedule.map((e) => e.id).toList();
    days.sort();
    firstDay = days[0];
    lastDay = days[days.length - 1];
  }

  @override
  Widget build(BuildContext context) {
    /// Size
    double width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ServiceBloc(serviceRepository: serviceRepository),
        ),
        BlocProvider(
          create: (context) => MasterBloc(masterRepository: masterRepository),
        ),
        BlocProvider(
            create: (context) =>
                CommentBloc(commentRepository: commentRepository))
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 20),

                    /// Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Title
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Name
                            Text(
                              widget.establishmentModel.name,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold),
                            ),

                            /// Type
                            Text(
                              "Салон красоты",
                              style: GoogleFonts.inter(
                                  fontSize: 14, color: Colors.black38),
                            ),
                          ],
                        ),

                        /// Buttons
                        Row(
                          children: [
                            /// Share Button
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    Share.share(
                                        'Удобное приложение для записи на услуги красоты! \n https://sulu.life');
                                  });
                                },
                                icon: const Icon(
                                  Icons.ios_share,
                                  color: Colors.black38,
                                  size: 30,
                                )),

                            /// Favorite Button
                            IconButton(
                                onPressed: () async {
                                  int resultFavorite =
                                      await _establishmentProvider
                                          .setFavoriteEstablishment(
                                              widget.establishmentModel.id);

                                  if (resultFavorite == 200) {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          'Салон успешно добавлен в избранные!'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (resultFavorite == 406) {
                                    const snackBar = SnackBar(
                                      content: Text('Салон уже добавлен!'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    const snackBar = SnackBar(
                                      content: Text('Ошибка'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                icon: const Icon(
                                  Icons.favorite_outline_rounded,
                                  color: Colors.black38,
                                  size: 30,
                                )),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// Establishment Body
                    Column(
                      children: [
                        /// Image
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Builder(
                                  builder: (context) {
                                    return CarouselSlider(
                                      options: CarouselOptions(
                                          height: 230,
                                          viewportFraction: 1.0,
                                          enlargeCenterPage: false,
                                          autoPlay: true,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _mainBannerIndex = index;
                                            });
                                          }
                                      ),
                                      carouselController: _mainBannerController,
                                      items: widget.establishmentModel.images
                                          .map((item) =>
                                          Center(
                                              child: Container(
                                                width: width,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        item
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
                            Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: widget.establishmentModel.images.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () => _mainBannerController.animateToPage(entry.key),
                                    child: Container(
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Colors.white).withOpacity(_mainBannerIndex == entry.key ? 0.9 : 0.4)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        /// Work Time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Schedule and Time
                            Row(
                              children: [
                                const Icon(Icons.access_time_rounded),
                                const SizedBox(width: 10),

                                /// Schedule
                                Text(constants.days[firstDay - 1] + " - " + constants.days[lastDay - 1]),
                                const SizedBox(width: 10),

                                /// Time
                                Text(widget.establishmentModel.toWorkSchedule
                                        .replaceRange(5, 8, "") +
                                    " - " +
                                    widget.establishmentModel.fromWorkSchedule
                                        .replaceRange(5, 8, "")),
                                const SizedBox(width: 10),
                              ],
                            ),

                            /// Rating
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                Text(
                                  widget.establishmentModel.rating.toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: 14, color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 5),

                        /// Address
                        Row(
                          children: [
                            /// Location icon
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(width: 10),

                            /// Address text
                            Text(
                              widget.establishmentModel.address,
                              style: GoogleFonts.inter(),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),

                        /// Phone number
                        Row(
                          children: [
                            /// Location icon
                            const Icon(Icons.phone),
                            const SizedBox(width: 10),

                            /// Address text
                            Text(
                              widget.establishmentModel.phoneNumber,
                              style: GoogleFonts.inter(),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),

                        /// Line
                        Container(
                          width: width - 30,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// Tab bar
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 20.0),
                          DefaultTabController(
                              length: 4, // length of tabs
                              initialIndex: 0,
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    /// Tabs
                                    TabBar(
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Colors.black38,
                                      indicatorColor: Colors.black,
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.grey),
                                      tabs: const [
                                        Tab(text: 'Услуги'),
                                        Tab(text: 'Мастера'),
                                        Tab(text: 'Отзывы'),
                                        Tab(text: 'Портфолио'),
                                      ],
                                    ),

                                    /// Tab's Items
                                    Container(
                                        height: 300, //height of TabBarView
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.5))),
                                        child: TabBarView(children: <Widget>[
                                          /// Service
                                          Center(
                                              child: hairSubcategory
                                                  ? BlocBuilder<ServiceBloc,
                                                      ServiceState>(
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is ServiceInitialState) {
                                                          ServiceBloc
                                                              serviceBloc =
                                                              BlocProvider.of<
                                                                      ServiceBloc>(
                                                                  context);

                                                          serviceBloc.add(
                                                              ServiceLoadEvent(
                                                                  id: widget
                                                                      .establishmentModel
                                                                      .id));

                                                          MasterBloc
                                                              masterBloc =
                                                              BlocProvider.of<
                                                                      MasterBloc>(
                                                                  context);
                                                          masterBloc.add(
                                                              MasterLoadEvent(
                                                                  id: widget
                                                                      .establishmentModel
                                                                      .id));
                                                          return Container();
                                                        }

                                                        if (state
                                                            is ServiceLoadingState) {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }

                                                        if (state
                                                            is ServiceErrorState) {
                                                          return Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Text(
                                                                  "У салона нету услуг"),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    ServiceBloc
                                                                        serviceBloc =
                                                                        BlocProvider.of<ServiceBloc>(
                                                                            context);

                                                                    serviceBloc.add(ServiceLoadEvent(
                                                                        id: widget
                                                                            .establishmentModel
                                                                            .id));
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .refresh_rounded))
                                                            ],
                                                          );
                                                        }

                                                        if (state
                                                            is ServiceLoadedState) {
                                                          return ListView
                                                              .builder(
                                                            itemCount: state
                                                                .loadedServices
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(builder:
                                                                          (context) {
                                                                        return OrderSetDatePage(
                                                                            establishmentModel: widget.establishmentModel,
                                                                            selectedService: state.loadedServices[index]);
                                                                      }));
                                                                },
                                                                child: Container(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          10),
                                                                  decoration: const BoxDecoration(
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                              color:
                                                                                  Colors.black12))),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [

                                                                      /// Information
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          /// Title
                                                                          Text(
                                                                            constants.subcategories[state.loadedServices[index].subTypeId - 1],
                                                                            style:
                                                                                GoogleFonts.inter(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 16
                                                                                ),
                                                                          ),

                                                                          SizedBox(
                                                                            width: width * 0.5,
                                                                            child: Text(
                                                                              state.loadedServices[index].description,
                                                                              style:
                                                                              GoogleFonts.inter(
                                                                                  color: Colors.black38,
                                                                                  fontSize: 12
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),

                                                                      /// Price
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.start,
                                                                        children: [
                                                                          /// Price
                                                                          Text(
                                                                            state.loadedServices[index].cost.toString() + "₸",
                                                                            style: GoogleFonts.inter(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 14
                                                                            ),
                                                                          ),

                                                                          /// Time
                                                                          Text(
                                                                            "1 час",
                                                                            style: GoogleFonts.inter(color: Colors.black38, fontSize: 12),
                                                                          ),

                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }

                                                        return const Text(
                                                            "Произошла ошибка");
                                                      },
                                                    )
                                                  : Container()),

                                          /// Masters
                                          Center(
                                            child: BlocBuilder<MasterBloc,
                                                MasterState>(
                                              builder: (context, state) {
                                                MasterBloc masterBloc =
                                                    BlocProvider.of<MasterBloc>(
                                                        context);

                                                if (state
                                                    is MasterInitialState) {
                                                  masterBloc.add(MasterLoadEvent(
                                                      id: widget
                                                          .establishmentModel
                                                          .id));
                                                  return Container();
                                                }

                                                if (state
                                                    is MasterLoadingState) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }

                                                if (state is MasterErrorState) {
                                                  return const Center(
                                                    child: Text(
                                                        "У салона нету мастеров"),
                                                  );
                                                }

                                                if (state
                                                    is MasterLoadedState) {
                                                  masters = state
                                                      .loadedMastersOfEstablishment;

                                                  return ListView.builder(
                                                    itemCount: state
                                                        .loadedMastersOfEstablishment
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        color: const Color(
                                                            0xffF8F8FB),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            /// Master Information
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 10),

                                                                /// Avatar
                                                                CircleAvatar(
                                                                    radius: 25,
                                                                    backgroundImage: NetworkImage(state.loadedMastersOfEstablishment[index].photo)),
                                                                const SizedBox(
                                                                    width: 10),

                                                                /// Info
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(state
                                                                        .loadedMastersOfEstablishment[
                                                                            index]
                                                                        .name),
                                                                    Text(
                                                                      state
                                                                          .loadedMastersOfEstablishment[
                                                                              index]
                                                                          .masterType[
                                                                              0]
                                                                          .type,
                                                                      style: GoogleFonts.inter(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black38),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),

                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_rounded,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 14,
                                                                ))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }

                                                return Container();
                                              },
                                            ),
                                          ),

                                          ///  Reports
                                          Center(
                                            child: BlocBuilder<CommentBloc,
                                                CommentState>(
                                              builder: (context, state) {
                                                CommentBloc commentBloc = BlocProvider.of<CommentBloc>(context);

                                                if(state is CommentInitialState) {
                                                  commentBloc.add(CommentLoadEvent(id: widget.establishmentModel.id));
                                                }

                                                if(state is CommentLoadingState) {
                                                  return const Center(
                                                    child: CircularProgressIndicator(),
                                                  );
                                                }

                                                if(state is CommentErrorState) {
                                                  return const Center(
                                                    child: Text("Нету отзывов"),
                                                  );
                                                }

                                                if(state is CommentLoadedState) {
                                                  return ListView.builder(
                                                    itemCount: state.loadedCommentsOfEstablishment.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                        int index) {
                                                      return Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                        child: Container(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black38)),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              /// User Information
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [

                                                                  /// User Information
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      const CircleAvatar(
                                                                        radius: 25,
                                                                        backgroundImage:
                                                                        AssetImage(
                                                                            'assets/icons/master.png'),
                                                                      ),
                                                                      const SizedBox(
                                                                          width: 10),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          Text(state.loadedCommentsOfEstablishment[index].userfirstname + " " + state.loadedCommentsOfEstablishment[index].userfirstname),
                                                                          const Text(
                                                                            "12 января, 21:56",
                                                                            style: TextStyle(
                                                                                color: Colors
                                                                                    .black38,
                                                                                fontSize:
                                                                                14),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),

                                                                  /// Star
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: [
                                                                      const Icon(Icons.star, color: Colors.yellow),
                                                                      Text(state.loadedCommentsOfEstablishment[index].stars.toString())
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),

                                                              const SizedBox(
                                                                  height: 10),

                                                              /// Comment
                                                              Text(state.loadedCommentsOfEstablishment[index].text),
                                                              const SizedBox(
                                                                  height: 20),

                                                              /// Master
                                                              Row(
                                                                children: [
                                                                  const CircleAvatar(
                                                                    radius: 15,
                                                                    backgroundImage:
                                                                    AssetImage(
                                                                        'assets/icons/master.png'),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      Text(state.loadedCommentsOfEstablishment[index].mastername,
                                                                          style: const TextStyle(
                                                                              color: Colors
                                                                                  .black38,
                                                                              fontSize:
                                                                              14,
                                                                              fontWeight:
                                                                              FontWeight.bold)),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }

                                                return Container();

                                              },
                                            ),
                                          ),

                                          /// Portfolio
                                          const Center(
                                            child: Text('Display Tab 4',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ]))
                                  ])),
                        ]),

                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
