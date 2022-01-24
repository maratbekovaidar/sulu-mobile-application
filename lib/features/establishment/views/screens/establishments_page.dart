import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sulu_mobile_application/features/establishment/views/screens/establishment_page.dart';
import 'package:sulu_mobile_application/utils/bloc/establishment/establishment_bloc.dart';
import 'package:sulu_mobile_application/utils/repository/establishment_repository.dart';

class EstablishmentsPage extends StatefulWidget {
  const EstablishmentsPage({Key? key, this.title, this.typeId, this.name})
      : super(key: key);

  final String? title;
  final int? typeId;
  final String? name;

  @override
  _EstablishmentsPageState createState() => _EstablishmentsPageState();
}

class _EstablishmentsPageState extends State<EstablishmentsPage> {

  /// Services Providers and Repositories
  EstablishmentRepository establishmentRepository = EstablishmentRepository();
  late EstablishmentBloc establishmentBloc;

  /// Establishments settings
  String? title;
  int? typeId;
  String? name;

  /// Filter Settings
  List<bool> selectedCategoriesStatus = List.filled(10, false);
  List<String> categories = [
    "Волосы",
    "Ногти",
    "Удаление волос",
    "Косметалогия",
    "Для мужчин",
    "Ресницы",
    "Брови",
    "Макияж",
    "Уход за телом"
  ];

  /// Search Settings
  bool _searchOpacity = false;
  final TextEditingController _searchController = TextEditingController();

  /// Amount of establishments
  int amountOfEstablishment = 0;

  /// Set state of bloc
  void setCategories(int id) {
    _panelController.close();
    setState(() {
      title = categories[id - 1];
      typeId = id;
    });
    establishmentsRefresh();
  }
  void establishmentsRefresh() {

    debugPrint("Name: " + (name ?? "null"));
    debugPrint("Type id: " + (typeId ?? -1).toString());

    if(name == null) {
      if(typeId == null) {
        establishmentBloc.add(EstablishmentLoadEvent());
      } else {
        establishmentBloc.add(EstablishmentLoadByTypeIdEvent(typeId: typeId!));
      }
    } else if (typeId == null) {
      establishmentBloc.add(EstablishmentLoadByNameEvent(name: name!));
    } else {
      establishmentBloc.add(EstablishmentLoadByNameAndTypeIdEvent(name: name!, typeId: typeId!));
    }
  }

  @override
  void initState() {

    /// Init from widget
    setState(() {
      title ??= widget.title;
      typeId ??= widget.typeId;
      name ??= widget.name;
    });

    if(name != null) {
      setState(() {
        _searchOpacity = true;
        _searchController.text = name!;
      });
    }
    super.initState();
  }

  /// Swipe Up
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {

    /// Size
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) =>
          EstablishmentBloc(establishmentRepository: establishmentRepository),
      child: SlidingUpPanel(
        /// Filter Panel
        panel: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                /// Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                /// Filter title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text("Фильтр",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            setState(() {
                              typeId = null;
                              selectedCategoriesStatus = List.filled(20, false);
                              _panelController.close();
                            });
                            establishmentsRefresh();
                          });
                        },
                        child: const Text("Очистить фильтр",
                            style: TextStyle(fontSize: 14, decoration: TextDecoration.underline)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                /// Filter
                Wrap(
                  // alignment: WrapAlignment.end,
                  runSpacing: 10,
                  spacing: 10,
                  children: [

                    /// Волосы
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesStatus = List?.filled(10, false);
                          selectedCategoriesStatus[1] = true;
                          setCategories(1);
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectedCategoriesStatus[1]
                              ? Colors.red.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Волосы",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    /// Ногти
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesStatus = List?.filled(10, false);
                          selectedCategoriesStatus[2] = true;
                          setCategories(2);

                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectedCategoriesStatus[2]
                              ? Colors.red.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Ногти",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    /// Удаление волос
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesStatus = List?.filled(10, false);
                          selectedCategoriesStatus[3] = true;
                          setCategories(3);
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectedCategoriesStatus[3]
                              ? Colors.red.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Удаление волос",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    /// Косметология
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesStatus = List?.filled(10, false);
                          selectedCategoriesStatus[4] = true;
                          setCategories(4);
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectedCategoriesStatus[4]
                              ? Colors.red.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Косметология",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    /// Для Мужчин
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesStatus = List?.filled(10, false);
                          selectedCategoriesStatus[5] = true;
                          setCategories(5);
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectedCategoriesStatus[5]
                              ? Colors.red.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Для Мужчин",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    /// Ресницы
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesStatus = List?.filled(10, false);
                          selectedCategoriesStatus[6] = true;
                          setCategories(6);
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectedCategoriesStatus[6]
                              ? Colors.red.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Ресницы",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    /// Брови
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesStatus = List?.filled(10, false);
                          selectedCategoriesStatus[7] = true;
                          setCategories(7);
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectedCategoriesStatus[7]
                              ? Colors.red.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Брови",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    /// Макияж
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesStatus = List?.filled(10, false);
                          selectedCategoriesStatus[8] = true;
                          setCategories(8);
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectedCategoriesStatus[8]
                              ? Colors.red.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Макияж",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    /// Уход за телом
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoriesStatus = List?.filled(10, false);
                          selectedCategoriesStatus[9] = true;
                          setCategories(9);
                        });
                      },
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: selectedCategoriesStatus[9]
                              ? Colors.red.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Уход за телом",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        controller: _panelController,
        panelSnapping: true,
        collapsed: const SizedBox(height: 0),
        minHeight: 0,
        maxHeight: width,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        body: Scaffold(
            appBar: AppBar(
              title: _searchOpacity ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Поиск..."
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                    establishmentsRefresh();
                  });
                },
              ) : (title == null
                  ? const Text("Салоны")
                  : Column(
                    children: [
                      Text(title!),
                      Text("Найдено " + amountOfEstablishment.toString() + " салонов", style: const TextStyle(
                        fontSize: 12
                      ),)
                    ],
                  )),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _searchOpacity = !_searchOpacity;
                        name = null;
                      });
                      establishmentsRefresh();
                    },
                    child: _searchOpacity ? const Icon(Icons.close_rounded) : const Icon(Icons.search)
                  ),
                )
              ],
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                /// Filter
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.black38,
                                width: 2,
                              )),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () async {
                            if (_panelController.isPanelClosed) {
                              await _panelController.open();
                            } else {
                              await _panelController.close();
                            }
                          },
                          icon: const Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.black38,
                            size: 14,
                          ),
                          label: const Text(
                            "Фильтр",
                            style:
                                TextStyle(color: Colors.black38, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: SizedBox(
                        height: 40,
                        width: 130,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.black38,
                                width: 2,
                              )),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4))),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () {
                            showDialog(context: context, builder: (_) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        establishmentsRefresh();
                                      },
                                      title: const Text("По рекомендации", textAlign: TextAlign.center,),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        establishmentsRefresh();
                                      },
                                      title: const Text("По дате", textAlign: TextAlign.center,),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        establishmentsRefresh();
                                      },
                                      title: const Text("По рейтингу", textAlign: TextAlign.center,),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.sort,
                            color: Colors.black38,
                            size: 14,
                          ),
                          label: const Text(
                            "Сортировка",
                            style:
                                TextStyle(color: Colors.black38, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 15),

                /// Establishments
                Expanded(
                  child: BlocBuilder<EstablishmentBloc, EstablishmentState>(
                    builder: (context, state) {
                      establishmentBloc =
                          BlocProvider.of<EstablishmentBloc>(context);

                      if (state is EstablishmentInitialState) {
                        establishmentsRefresh();
                        return Container();
                      }

                      if (state is EstablishmentLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is EstablishmentErrorState) {
                        return Center(
                          child: Text(
                            "",
                            style: GoogleFonts.inter(color: Colors.red),
                          ),
                        );
                      }

                      if (state is EstablishmentLoadedState) {

                        WidgetsBinding.instance?.addPostFrameCallback((_){
                          setState(() {
                            amountOfEstablishment = state.establishments.length;
                          });
                        });

                        return ListView.builder(
                          itemCount: state.establishments.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                /// One Salon
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EstablishmentPage(
                                                      establishmentModel: state
                                                          .establishments[index]),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: SizedBox(
                                            width: width * 0.90,
                                            height: 200,
                                            child: Column(
                                              children: [
                                                /// Image
                                                Expanded(
                                                  child: Image.network(
                                                    state.establishments[index]
                                                        .images[0],
                                                    width: width * 0.9,
                                                    // height: 140,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                /// Information
                                                Container(
                                                  color: const Color(0xffF8F8FB),
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    children: [
                                                      /// Name and Rating
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            state
                                                                .establishments[
                                                                    index]
                                                                .name,
                                                            style:
                                                                GoogleFonts.inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 16),
                                                          ),

                                                          /// Rating
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.star,
                                                                size: 14,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Text(
                                                                state
                                                                    .establishments[
                                                                        index]
                                                                    .rating
                                                                    .toString(),
                                                                style: GoogleFonts
                                                                    .inter(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .grey),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),

                                                      /// Address and Reports
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            state
                                                                .establishments[
                                                                    index]
                                                                .address,
                                                            style: GoogleFonts.inter(
                                                                color: const Color(
                                                                    0xffBBBBBB),
                                                                fontSize: 11),
                                                          ),
                                                          Text(
                                                            state
                                                                    .establishments[
                                                                        index]
                                                                    .rating
                                                                    .toString() +
                                                                " отзывов",
                                                            style: GoogleFonts.inter(
                                                                color: const Color(
                                                                    0xffBBBBBB),
                                                                fontSize: 11),
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
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      }

                      return const Center(
                        child: Text("Unknown error"),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
