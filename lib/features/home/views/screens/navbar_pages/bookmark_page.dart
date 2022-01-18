import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/comment/views/screens/comment_page.dart';
import 'package:sulu_mobile_application/utils/bloc/appointment/appointment_bloc.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {

  @override
  Widget build(BuildContext context) {

    /// Size
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        AppointmentBloc appointmentBloc =
            BlocProvider.of<AppointmentBloc>(context);

        if (state is AppointmentInitialState) {
          appointmentBloc.add(AppointmentLoadEvent());
          return Container();
        }

        if (state is AppointmentErrorState) {
          return RefreshIndicator(
              onRefresh: () async {
                appointmentBloc.add(AppointmentLoadEvent());
              },
              child: ListView(
                children: const [
                  SizedBox(
                    height: 300,
                  ),
                  Text(
                    "У вас нету записей!",
                    textAlign: TextAlign.center,
                  ),
                ],
              ));
        }

        if (state is AppointmentLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AppointmentLoadedState) {
          return RefreshIndicator(
            onRefresh: () async {
              appointmentBloc.add(AppointmentLoadEvent());
            },
            child: ListView.builder(
                itemCount: state.loadedAppointments.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.black12))),
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Image
                          Image.asset(
                            'assets/images/salon.jpg',
                            fit: BoxFit.cover,
                            height: 200,
                            width: 180,
                          ),
                          const SizedBox(width: 10),

                          /// Information
                          SizedBox(
                            width: width - 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                /// Information
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Салон красоты",
                                      style: GoogleFonts.inter(
                                          color: Colors.black38, fontSize: 14),
                                    ),
                                    Text(
                                      state.loadedAppointments[index]
                                          .establishmentName,
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(height: 20),
                                    Text("Дата: " +
                                        state.loadedAppointments[index]
                                            .appointmentDate),
                                    Text("Время: " +
                                        state.loadedAppointments[index]
                                            .appointmentStartTime +
                                        " - " +
                                        state.loadedAppointments[index]
                                            .appointmentEndTime),
                                  ],
                                ),

                                /// Button Feedback
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          print(state.loadedAppointments[index].serviceId);
                                          return CommentPage(serviceId: state.loadedAppointments[index].serviceId, appointmentModel: state.loadedAppointments[index],);
                                        } ));
                                      },
                                      child: const Text(
                                        "Оставить отзыв",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        }

        return Container();
      },
    );
  }
}
