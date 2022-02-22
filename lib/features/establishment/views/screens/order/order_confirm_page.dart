

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';
import 'package:sulu_mobile_application/utils/model/master_models/master_model.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/service_model.dart';
import 'package:sulu_mobile_application/utils/services/service_service.dart';

class OrderConfirmPage extends StatefulWidget {
  const OrderConfirmPage({Key? key, required this.date, required this.time, required this.establishmentModel, required this.serviceModel, required this.masterId, required this.masterModel}) : super(key: key);

  final String date;
  final String time;
  final int masterId;
  final MasterModel masterModel;

  final EstablishmentModel establishmentModel;
  final ServiceModel serviceModel;

  @override
  _OrderConfirmPageState createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {


  final ServiceService _provider = ServiceService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    /// Size
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Подтвердите запись"),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.black12))
            ),
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    widget.establishmentModel.images[0],
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.establishmentModel.name),
                      Text("Салон красоты", style: GoogleFonts.inter(
                        color: Colors.black38,
                        fontSize: 16
                      ),),
                      const SizedBox(height: 20),
                      Text("Дата: " + widget.date),
                      Text("Время: " + widget.time)
                    ],
                  )
                ],
              ),
            ),
          ),

          /// About Service
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12))),
            child: Column(
              children: [
                /// Service
                Container(
                  width: width,
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title
                          Text(
                            "Стрижка",
                            style: GoogleFonts.inter(),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// Time
                              Text(
                                "1 час",
                                style: GoogleFonts.inter(color: Colors.black38),
                              ),

                              /// Price
                              Text(
                                "  • 1000 - 4000₸",
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
                  padding: const EdgeInsets.all(15),
                  color: const Color(0xffF8F8FB),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Master Information
                      Row(
                        children: [
                          const SizedBox(width: 10),

                          /// Avatar
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              widget.masterModel.photo
                            ),
                          ),
                          const SizedBox(width: 10),

                          /// Info
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.masterModel.name),
                              Text(
                                widget.masterModel.masterType[0].type,
                                style: GoogleFonts.inter(
                                    fontSize: 14, color: Colors.black38),
                              )
                            ],
                          ),
                        ],
                      ),

                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 14,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Ваши контакты"),
                ),
                const SizedBox(height: 10,),

                /// Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Имя"),
                    controller: _nameController,
                  ),
                ),
                const SizedBox(height: 10),

                /// First Name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Номер"),
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(height: 20),

                /// Button
                Container(
                  padding: const EdgeInsets.all(10),
                  width: width,
                  child: ElevatedButton(
                      onPressed: () async {
                        showDialog(context: context, barrierDismissible: false, builder: (_) {
                          return const CupertinoAlertDialog(
                            content: SizedBox(
                              width: 50,
                              height: 100,
                              child: Center(child: CircularProgressIndicator())
                            ),
                          );
                        });

                        try {
                          bool result = await _provider.setAppointment(widget.date, widget.time, widget.masterId, _phoneNumberController.text, widget.serviceModel.id, _nameController.text);
                          if(result == true) {
                            Navigator.pop(context);
                            showDialog(context: context, builder: (_) {
                              return CupertinoAlertDialog(
                                content: Column(
                                  children: const [
                                    Text("Вы успешно записались!", style: TextStyle(
                                        color: Colors.green
                                    ),),
                                    Icon(
                                      Icons.check, color:  Colors.green,
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                                  }, child: const Text("Ok"))
                                ],
                              );
                            });
                          } else {
                            Navigator.pop(context);
                            showDialog(context: context, builder: (_) {
                              return CupertinoAlertDialog(
                                content: Column(
                                  children: const [
                                    Text("Не удалось сделать запись!", style: TextStyle(
                                        color: Colors.red
                                    ),),
                                    Icon(
                                      Icons.check, color:  Colors.red,
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(onPressed: () {
                                    Navigator.pop(context);
                                  }, child: const Text("Ok"))
                                ],
                              );
                            });
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          showDialog(context: context, barrierDismissible: false, builder: (_) {
                            return CupertinoAlertDialog(
                              content: const Center(
                                child: Text("Не удалось сделать зппись!", style: TextStyle(color: Colors.red),),
                              ),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: const Text("Ok"))
                              ],
                            );
                          });
                        }
                      },
                      child: const Text("Записаться")
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
