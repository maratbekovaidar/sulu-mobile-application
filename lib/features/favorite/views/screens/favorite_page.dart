import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/establishment/views/screens/establishment_page.dart';
import 'package:sulu_mobile_application/utils/bloc/establishment/establishment_bloc.dart';
import 'package:sulu_mobile_application/utils/repository/establishment_repository.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  EstablishmentRepository establishmentRepository = EstablishmentRepository();

  @override
  Widget build(BuildContext context) {
    /// Size
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) =>
          EstablishmentBloc(establishmentRepository: establishmentRepository),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Избранные"),
          centerTitle: true,
        ),
        body: BlocBuilder<EstablishmentBloc, EstablishmentState>(
          builder: (context, state) {
            EstablishmentBloc establishmentBloc =
                BlocProvider.of<EstablishmentBloc>(context);

            if (state is EstablishmentInitialState) {
              establishmentBloc.add(EstablishmentFavoriteLoadEvent());
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
              return ListView.builder(
                itemCount: state.establishments.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      /// One Salon
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: GestureDetector(
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
                                    child: Image.asset(
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
                                                      .amountOfLikes
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
                                                      .amountOfLikes
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
    );
  }
}
