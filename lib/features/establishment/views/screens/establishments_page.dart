import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  EstablishmentRepository establishmentRepository = EstablishmentRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Size
    double width = MediaQuery.of(context).size.width;

    /// Fields for search
    String? name = widget.name;
    int? typeId = widget.typeId;

    /// TextField Controller
    TextEditingController searchController = TextEditingController();

    return SlidingUpPanel(
      panel: const Center(
        child: Text("This is the sliding Widget"),
      ),

      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      body: BlocProvider(
        create: (context) {
          return EstablishmentBloc(establishmentRepository: establishmentRepository);
        },
        child: Scaffold(
            appBar: AppBar(
              title: widget.title == null
                  ? const Text("Салоны")
                  : Text(widget.title!),
              centerTitle: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.search),
                )
              ],
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                /// Establishments
                Expanded(
                  child: BlocBuilder<EstablishmentBloc, EstablishmentState>(
                    builder: (context, state) {
                      EstablishmentBloc establishmentBloc =
                          BlocProvider.of<EstablishmentBloc>(context);

                      if (state is EstablishmentInitialState) {
                        if (name != null) {
                          establishmentBloc.add(EstablishmentLoadByNameEvent(name: name));
                        } else if (typeId != null) {
                          establishmentBloc.add(
                              EstablishmentLoadByTypeIdEvent(typeId: typeId!));
                        } else {
                          establishmentBloc.add(EstablishmentLoadEvent());
                        }

                        return Container();
                      }

                      if (state is EstablishmentLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is EstablishmentErrorState) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [

                                  /// Filter
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                          side: MaterialStateProperty.all(const BorderSide(
                                            color: Colors.black38,
                                            width: 2,
                                          )),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4)
                                          )),
                                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                                          backgroundColor: MaterialStateProperty.all(
                                              Colors.transparent
                                          )
                                      ),
                                      onPressed: () {


                                        showDialog(context: context, builder: (_) {


                                          return AlertDialog(
                                            contentPadding: EdgeInsets.zero,
                                            title: const Text("Выберите категорию", textAlign: TextAlign.center),
                                            content: SizedBox(
                                              height: 320,
                                              child: Flex(
                                                direction: Axis.vertical,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = 1;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadByTypeIdEvent(typeId: typeId!));
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Волосы", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = 2;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadByTypeIdEvent(typeId: typeId!));
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Уход за телом", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = 3;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadByTypeIdEvent(typeId: typeId!));
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Маникюр", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = 4;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadByTypeIdEvent(typeId: typeId!));
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Брови", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = null;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadEvent());
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Очистить", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        });

                                      },
                                      icon: const Icon(
                                        Icons.filter_alt_outlined,
                                        color: Colors.black38,
                                        size: 14,
                                      ),
                                      label: const Text("Фильтр", style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 14
                                      ),),

                                    ),
                                  ),
                                  const SizedBox(width: 15),

                                  SizedBox(
                                    height: 40,
                                    width: 130,
                                    child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                          side: MaterialStateProperty.all(const BorderSide(
                                            color: Colors.black38,
                                            width: 2,
                                          )),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4)
                                          )),
                                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                                          backgroundColor: MaterialStateProperty.all(
                                              Colors.transparent
                                          )
                                      ),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.sort,
                                        color: Colors.black38,
                                        size: 14,
                                      ),
                                      label: const Text("Сортировка", style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 14
                                      ),),

                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                "",
                                style: GoogleFonts.inter(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      }

                      if (state is EstablishmentLoadedState) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [

                                  /// Filter
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                          side: MaterialStateProperty.all(const BorderSide(
                                            color: Colors.black38,
                                            width: 2,
                                          )),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4)
                                          )),
                                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                                          backgroundColor: MaterialStateProperty.all(
                                              Colors.transparent
                                          )
                                      ),
                                      onPressed: () {


                                        showDialog(context: context, builder: (_) {


                                          return AlertDialog(
                                            contentPadding: EdgeInsets.zero,
                                            title: const Text("Выберите категорию", textAlign: TextAlign.center),
                                            content: SizedBox(
                                              height: 320,
                                              child: Flex(
                                                direction: Axis.vertical,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = 1;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadByTypeIdEvent(typeId: typeId!));
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Волосы", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = 2;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadByTypeIdEvent(typeId: typeId!));
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Уход за телом", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = 3;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadByTypeIdEvent(typeId: typeId!));
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Маникюр", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = 4;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadByTypeIdEvent(typeId: typeId!));
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Брови", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        typeId = null;
                                                        Navigator.pop(context);
                                                        establishmentBloc.add(EstablishmentLoadEvent());
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          border: Border(top: BorderSide(color: Colors.black38, width: 1))
                                                      ),
                                                      child: const ListTile(
                                                        title: Text("Очистить", textAlign: TextAlign.center),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          );
                                        });

                                      },
                                      icon: const Icon(
                                        Icons.filter_alt_outlined,
                                        color: Colors.black38,
                                        size: 14,
                                      ),
                                      label: const Text("Фильтр", style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 14
                                      ),),

                                    ),
                                  ),

                                  const SizedBox(width: 15),

                                  SizedBox(
                                    height: 40,
                                    width: 130,
                                    child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                          side: MaterialStateProperty.all(const BorderSide(
                                            color: Colors.black38,
                                            width: 2,
                                          )),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4)
                                          )),
                                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                                          backgroundColor: MaterialStateProperty.all(
                                              Colors.transparent
                                          )
                                      ),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.sort,
                                        color: Colors.black38,
                                        size: 14,
                                      ),
                                      label: const Text("Сортировка", style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 14
                                      ),),

                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Expanded(
                              child: ListView.builder(
                                itemCount: state.establishments.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [

                                      /// One Salon
                                      Row(
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
                                                      padding: const EdgeInsets.all(15),
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
                                                                    color: Colors.grey,
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
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
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
