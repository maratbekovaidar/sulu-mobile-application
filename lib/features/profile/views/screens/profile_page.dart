import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulu_mobile_application/features/profile/views/screens/profile_edit_page.dart';
import 'package:sulu_mobile_application/utils/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sulu_mobile_application/utils/services/upload_image_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final ImagePicker _picker = ImagePicker();
  final UploadImageProvider _uploadImageProvider = UploadImageProvider();


  @override
  Widget build(BuildContext context) {
    /// Sizes
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => UserBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            UserBloc userBloc = BlocProvider.of<UserBloc>(context);

            if (state is UserInitial) {
              userBloc.add(UserLoadEvent());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }

            if (state is UserErrorState) {
              FlutterSecureStorage storage = const FlutterSecureStorage();
              storage.delete(key: 'token');
              Navigator.popAndPushNamed(context, '/first_page');
              return const Center(child: Text("Error"));
            }

            if (state is UserLoadedState) {
              return ListView(
                children: [
                  const SizedBox(height: 50),

                  /// Avatar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        child: Stack(
                          children: [
                            /// Image
                            CircleAvatar(
                              radius: 100,
                              backgroundImage: NetworkImage(state.userModel.photo),
                            ),

                            /// Edit Button
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () async {
                                  final image = await _picker.pickImage(source: ImageSource.gallery);
                                  if(image != null) {
                                    bool result = await _uploadImageProvider.uploadUserImage(state.userModel.id, image.path, image.name);
                                    if(result) {
                                      userBloc.add(UserLoadEvent());
                                    } else {
                                    }
                                  }
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Color(0xffFF385C),
                                  radius: 20,
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  /// User name, surname
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.userModel.firstName +
                            " " +
                            state.userModel.lastName +
                            " \n " +
                            state.userModel.patronymic,
                        style: GoogleFonts.inter(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  /// Edit data of user
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Button action
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditPage(userModel: state.userModel)));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              // shape: BoxShape.circle
                              border:
                                  Border.all(color: const Color(0xffFF385C))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Icon and Title
                              Row(
                                children: [
                                  const Icon(Icons.person_outline_outlined,
                                      color: Color(0xffFF385C)),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Редактирование данные",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xffFF385C)),
                                  ),
                                ],
                              ),

                              /// Arrow
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xffFF385C),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Favorites
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/favorite');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              // shape: BoxShape.circle
                              border: Border.all(color: const Color(0xffFF385C))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Icon and Title
                              Row(
                                children: [
                                  const Icon(Icons.favorite_outline_rounded,
                                      color: Color(0xffFF385C)),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Избранные",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xffFF385C)),
                                  ),
                                ],
                              ),

                              /// Arrow
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xffFF385C),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Support
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: (_) {

                            TextEditingController _personController = TextEditingController();
                            TextEditingController _feedbackController = TextEditingController();



                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              title: const Text("Напишите отчет", textAlign: TextAlign.center),
                              content: SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _personController,
                                        decoration: const InputDecoration(
                                            hintText: "Ваши контакты"
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: _feedbackController,
                                        maxLines:4,
                                        decoration: const InputDecoration(
                                          hintText: "Ваш предложение",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      String feedbackText = _feedbackController.value.text;
                                      String personText = _personController.value.text;
                                      String textOutput = "Контакты: " + personText + ".\nСообщение: " + feedbackText;
                                      Uri.parse('https://api.telegram.org/bot5058514406:AAHBko2SdNPqQIemzUUEcB0sRBUBwABJx98/sendMessage?chat_id=-1001658501273&text=$textOutput');
                                    },
                                    child: const Text("Отправить")
                                )
                              ],
                            );
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              // shape: BoxShape.circle
                              border: Border.all(color: const Color(0xffFF385C))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Icon and Title
                              Row(
                                children: [
                                  const Icon(Icons.settings_rounded,
                                      color: Color(0xffFF385C)),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Поддержка",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xffFF385C)),
                                  ),
                                ],
                              ),

                              /// Arrow
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xffFF385C),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Logout
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          FlutterSecureStorage storage =
                              const FlutterSecureStorage();
                          storage.delete(key: 'token');
                          Navigator.popAndPushNamed(context, '/first_page');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              // shape: BoxShape.circle
                              border:
                                  Border.all(color: const Color(0xffFF385C))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Icon and Title
                              Row(
                                children: [
                                  const Icon(Icons.exit_to_app,
                                      color: Color(0xffFF385C)),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Выйти",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xffFF385C)),
                                  ),
                                ],
                              ),

                              /// Arrow
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xffFF385C),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }

            return const Center(child: Text("Error"));
          },
        ),
      ),
    );
  }
}
