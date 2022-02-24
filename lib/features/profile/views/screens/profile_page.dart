import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sulu_mobile_application/features/profile/views/screens/profile_edit_page.dart';
import 'package:sulu_mobile_application/utils/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sulu_mobile_application/utils/services/upload_image_service.dart';
import 'package:sulu_mobile_application/utils/services/user_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  /// Providers and Controllers
  final ImagePicker _picker = ImagePicker();
  final UploadImageService _uploadImageProvider = UploadImageService();
  final PanelController _pc = PanelController();
  final UserService _userProvider = UserService();
  late UserBloc _userBloc;

  @override
  Widget build(BuildContext context) {
    /// Sizes
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => UserBloc(),
      child: SlidingUpPanel(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 15,
            blurRadius: 15,
            offset: const Offset(0, 10), // changes position of shadow
          ),
        ],
        minHeight: 0,
        maxHeight: height*0.8,
        controller: _pc,
        onPanelClosed: () {
          _userBloc.add(UserLoadEvent());
        },
        panel: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                _userBloc = BlocProvider.of<UserBloc>(context);

                if (state is UserInitial) {
                  // _userBloc.add(UserLoadCitiesEvent());
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is UserLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is UserErrorState) {
                  return const Center(child: Text("Error"));
                }

                if (state is UserCitiesLoadedState) {

                  return ListView.builder(
                    itemCount: state.cities.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {

                          /// Change City
                          _userProvider.changeCity(state.cities[index].id);
                          _pc.close();
                        },
                        title: Text(state.cities[index].name),
                      );
                    }
                  );
                }

                return Container();
              },
            ),
          ),
        ),
        body: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {

              _userBloc = BlocProvider.of<UserBloc>(context);

              if (state is UserInitial) {
                _userBloc.add(UserLoadEvent());
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
                return const Center(child: Text(""));
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
                                backgroundColor: Colors.grey,
                                radius: 100,
                                backgroundImage:
                                    NetworkImage(state.userModel.photo),
                              ),

                              /// Edit Button
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () async {
                                    final image = await _picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (image != null) {
                                      bool result = await _uploadImageProvider
                                          .uploadUserImage(state.userModel.id,
                                              image.path, image.name);
                                      if (result) {
                                        _userBloc.add(UserLoadEvent());
                                      } else {}
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
                              state.userModel.lastName,
                          style: GoogleFonts.inter(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    /// City
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 30),
                        Text(
                          state.userModel.city.name,
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            _pc.open();
                            _userBloc.add(UserLoadCitiesEvent());
                          },
                          child: const Icon(
                            Icons.edit_rounded,
                            color: Colors.red,
                            size: 16,
                          ),
                        )
                        // Text(
                        //   "Изменить",
                        //   style: GoogleFonts.inter(
                        //       fontSize: 12, color: Colors.blue, decoration: TextDecoration.underline),
                        //   textAlign: TextAlign.center,
                        // ),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEditPage(
                                        userModel: state.userModel)));
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
                                border:
                                    Border.all(color: const Color(0xffFF385C))),
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
                            showDialog(
                                context: context,
                                builder: (_) {
                                  TextEditingController _personController =
                                      TextEditingController();
                                  TextEditingController _feedbackController =
                                      TextEditingController();

                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    title: const Text("Напишите отчет",
                                        textAlign: TextAlign.center),
                                    content: SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: _personController,
                                              decoration: const InputDecoration(
                                                  hintText: "Ваши контакты"),
                                            ),
                                            const SizedBox(height: 10),
                                            TextField(
                                              controller: _feedbackController,
                                              maxLines: 4,
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
                                            String feedbackText =
                                                _feedbackController.value.text;
                                            String personText =
                                                _personController.value.text;
                                            String textOutput = "Контакты: " +
                                                personText +
                                                ".\nСообщение: " +
                                                feedbackText;
                                            Uri.parse(
                                                'https://api.telegram.org/bot5058514406:AAHBko2SdNPqQIemzUUEcB0sRBUBwABJx98/sendMessage?chat_id=-1001658501273&text=$textOutput');
                                          },
                                          child: const Text("Отправить"))
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
                                border:
                                    Border.all(color: const Color(0xffFF385C))),
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



              return const Center(child: Text(""));
            },
          ),
        ),
      ),
    );
  }
}
