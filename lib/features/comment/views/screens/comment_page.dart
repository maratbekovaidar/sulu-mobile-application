import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/appointment_model.dart';
import 'package:sulu_mobile_application/utils/services/appointment_service.dart';

class CommentPage extends StatefulWidget {
  const CommentPage(
      {Key? key, required this.appointmentModel, required this.serviceId})
      : super(key: key);

  final AppointmentModel appointmentModel;
  final int serviceId;

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  /// Providers
  final AppointmentService _appointmentProvider = AppointmentService();

  /// Upload data
  double ratingComment = 0;
  final TextEditingController _feedbackController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images;



  @override
  Widget build(BuildContext context) {
    /// Size
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          /// Appointment
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
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
                              widget.appointmentModel.establishmentName,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            Text("Дата: " +
                                widget.appointmentModel.appointmentDate),
                            Text("Время: " +
                                widget.appointmentModel.appointmentStartTime),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          /// Star
          Column(
            children: [
              const Text(
                "Насколько вы довольны работой?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Насколько вы довольны работой?",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    ratingComment = rating;
                  });
                },
              ),
              const SizedBox(height: 20),

              /// Text Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _feedbackController,
                  maxLines:4,
                  decoration: const InputDecoration(
                    hintText: "Ваш отзыв",
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Image picker
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        images = await _picker.pickMultiImage();
                        setState(() {
                        });
                      },
                      child: Container(
                        width: width / 4 - 20 ,
                        height: width / 4 - 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red, width: 2)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.camera_alt_rounded, color: Colors.red),
                            Text("Добавить \n фото", style: TextStyle(color: Colors.red, fontSize: 12), textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width / 4 - 20,
                      height: width / 4 - 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red, width: 2)
                      ),
                      child: images != null ? Image.file(File(images![0].path), fit: BoxFit.cover,) : Container(),
                    ),
                    Container(
                      width: width / 4 - 20,
                      height: width / 4 - 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red, width: 2)
                      ),
                      child: images != null && images!.length > 1 ? Image.file(File(images![1].path), fit: BoxFit.cover,) : Container(),
                    ),
                    Container(
                      width: width / 4 - 20,
                      height: width / 4 - 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.red, width: 2)
                      ),
                      child: images != null && images!.length > 2 ? Image.file(File(images![2].path), fit: BoxFit.cover,) : Container(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// Send Button
              SizedBox(
                width: width - 30,
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
                    bool result = await _appointmentProvider.setCommentService(widget.appointmentModel.establishmentId, widget.appointmentModel.masterDataId, ratingComment, _feedbackController.text, images);
                    if(result) {
                      Navigator.pop(context);
                      showDialog(context: context, builder: (_) {
                        return CupertinoAlertDialog(
                          content: Column(
                            children: const [
                              Text("Спасибо за отзыв!", style: TextStyle(
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
                  },
                  child: const Text("Оставить отзыв")
                ),
              ),
              const SizedBox(height: 20),

            ],
          )
        ],
      ),
    );
  }
}
