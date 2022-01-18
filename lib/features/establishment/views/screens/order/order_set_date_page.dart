import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/features/establishment/views/screens/order/order_confirm_page.dart';
import 'package:sulu_mobile_application/utils/bloc/master/master_bloc.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/master_model.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/service_model.dart';
import 'package:sulu_mobile_application/utils/repository/master_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class OrderSetDatePage extends StatefulWidget {
  const OrderSetDatePage(
      {Key? key,
      required this.establishmentModel,
      required this.selectedService})
      : super(key: key);

  final EstablishmentModel establishmentModel;
  final ServiceModel selectedService;

  @override
  _OrderSetDatePageState createState() => _OrderSetDatePageState();
}

class _OrderSetDatePageState extends State<OrderSetDatePage> {


  /// Calendar Date
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _selectedTime = "";
  MasterModel? _selectedMasterModel;

  /// Master Id
  int masterId = 0;

  List<bool> _selectedTimesStatus = List.filled(100, false);


  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  MasterRepository masterRepository = MasterRepository();

  @override
  Widget build(BuildContext context) {
    /// Size
    double width = MediaQuery.of(context).size.width;

    /// Selected time

    return BlocProvider(
      create: (context) => MasterBloc(masterRepository: masterRepository),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Новая запись"),
          centerTitle: true,
        ),
        body: ListView(
          children: [

            /// About Service
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Service
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title
                          Text(
                            widget.selectedService.name,
                            style: GoogleFonts.inter(),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// Time
                              Text(
                                "1 час",
                                style:
                                    GoogleFonts.inter(color: Colors.black38),
                              ),

                              /// Price
                              Text(
                                "  • " +
                                    widget.selectedService.cost.toString() +
                                    "₸",
                                style: GoogleFonts.inter(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Master
                Container(
                  width: width,
                  color: const Color(0xffF8F8FB),
                  height: 80,
                  child: BlocBuilder<MasterBloc, MasterState>(
                    builder: (context, state) {
                      MasterBloc masterBloc =
                          BlocProvider.of<MasterBloc>(context);

                      if (state is MasterInitialState) {
                        masterBloc.add(MasterLoadByTypeIdEvent(
                            id: widget.selectedService.id));
                        return Container();
                      }

                      if (state is MasterLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is MasterErrorState) {
                        return const Center(
                          child: Text("У салона нету мастеров"),
                        );
                      }

                      if (state is MasterLoadedState) {

                        if(state.loadedMastersOfEstablishment.isNotEmpty) {

                          return DropdownButton(
                            underline: const SizedBox(),
                            itemHeight: 70,
                            value: _selectedMasterModel ?? state.loadedMastersOfEstablishment[0],
                            items: state.loadedMastersOfEstablishment.map((MasterModel items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Container(
                                  width: width * 0.9,
                                  padding: const EdgeInsets.all(15),
                                  color: const Color(0xffF8F8FB),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      /// Master Information
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),

                                          /// Avatar
                                          const CircleAvatar(
                                              radius: 25,
                                              backgroundImage: AssetImage(
                                                  'assets/icons/master.png')),
                                          const SizedBox(width: 10),

                                          /// Info
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(items.firstName +
                                                  " " + items.lastName),
                                              Text(items.masterType[0].type,
                                                style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    color: Colors.black38),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (MasterModel? newValue) {
                              setState(() {
                                _selectedMasterModel = newValue!;
                              });
                            },
                          );
                        } else {
                          return const Center(
                            child: Text("Для этой услуги нету мастеров"),
                          );
                        }

                      }

                      return Container();
                    },
                  ),
                ),
              ],
            ),

            /// Select Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                  child: Text(
                    "Выберите дату: ",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                /// Select Day
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    locale: 'ru_RU',
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        if (day.weekday == DateTime.sunday) {
                          final text = DateFormat.E().format(day);

                          return Center(
                            child: Text(
                              text,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                      },
                    ),
                    calendarStyle: const CalendarStyle(
                        selectedDecoration: BoxDecoration(
                            color: Color(0xffFF385C), shape: BoxShape.rectangle)),
                  ),
                ),
              ],
            ),

            /// Select Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                  child: Text(
                    "Выберите время: ",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                if (_selectedMasterModel != null) Container(
                  height: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GridView.builder(
                      physics: const ScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.5
                      ),
                      itemCount: _selectedMasterModel!.masterStartTime.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTimesStatus = List.filled(100, false);
                              _selectedTime = _selectedMasterModel!.masterStartTime[index];
                              _selectedTimesStatus[index] = !_selectedTimesStatus[index];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: _selectedTimesStatus[index] == false ? Colors.white : Colors.black12,
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(_selectedMasterModel!.masterStartTime[index].replaceRange(5, 8, '')),
                          ),
                        );
                      }),
                ) else Container(),
              ],
            ),


            /// Button
            Container(
              padding: const EdgeInsets.all(20),
              width: width * 0.8,
              child: ElevatedButton(
                  onPressed: () {
                    if (_selectedDay != null) {
                      if (_selectedTime != "") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            String date =
                                (_selectedDay!.day.toString().length == 1
                                    ? "0" + _selectedDay!.day.toString()
                                    : _selectedDay!.day.toString()) +
                                    "-" +
                                    (_selectedDay!.month.toString().length == 1
                                        ? "0" + _selectedDay!.month.toString()
                                        : _selectedDay!.month.toString()) +
                                    "-" +
                                    _selectedDay!.year.toString();
                            return OrderConfirmPage(
                              masterId: _selectedMasterModel!.id,
                              date: date,
                              time: _selectedTime,
                              establishmentModel: widget.establishmentModel,
                              serviceModel: widget.selectedService, masterModel: _selectedMasterModel!,
                            );
                          }),
                        );
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return CupertinoAlertDialog(
                                content: const Center(
                                  child: Text(
                                    "Выберите время записи!",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok"))
                                ],
                              );
                            });
                      }
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) {
                            return CupertinoAlertDialog(
                              content: const Center(
                                child: Text(
                                  "Выберите дату записи!",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"))
                              ],
                            );
                          });
                    }
                  },
                  child: const Text("Записаться")),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
