import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sulu_mobile_application/features/profile/views/screens/profile_page.dart';
import 'package:sulu_mobile_application/utils/bloc/user_bloc/user_bloc.dart';
import 'package:url_launcher/url_launcher.dart';


class SuluDrawer extends StatefulWidget {
  const SuluDrawer({Key? key}) : super(key: key);

  @override
  _SuluDrawerState createState() => _SuluDrawerState();
}

class _SuluDrawerState extends State<SuluDrawer> {
  @override
  Widget build(BuildContext context) {

    /// Bloc
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Drawer(
      child: ListView(
        children: [

          /// Header
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/background/drawer.png',
                  ),
                )
            ),
            height: 150,
            child: Center(child: Image.asset('assets/logo/drawer_logo.png')),
          ),

          /// Body
          Container(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Column(
                  children: [

                    /// Profile
                    SizedBox(
                      height: 100,
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {

                          if(state is UserInitial) {
                            userBloc.add(UserLoadEvent());
                            return const Center(child: CircularProgressIndicator(),);
                          }

                          if(state is UserLoadingState) {
                            return const Center(child: CircularProgressIndicator(color: Colors.grey,),);
                          }

                          if(state is UserErrorState) {
                            FlutterSecureStorage storage = const FlutterSecureStorage();
                            storage.delete(key: 'token');
                            Navigator.popAndPushNamed(context, '/first_page');
                            return const Center(child: Text("Error"));
                          }

                          if(state is UserLoadedState) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    /// Information
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        /// Name
                                        Text(
                                          state.userModel.firstName + " " + state.userModel.lastName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),

                                        /// City
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.black38,
                                              size: 14,
                                            ),
                                            Text(
                                              state.userModel.city.name,
                                              style: const TextStyle(color: Colors.black38),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 15),

                                    /// Avatar
                                    CircleAvatar(
                                      backgroundImage:
                                      NetworkImage(state.userModel.photo),
                                      radius: 40,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return Container();
                        },
                      ),
                    ),
                    const SizedBox(height: 0),

                    /// Главная
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        "Главная",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    /// Фавориты
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/favorite');
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        "Избранные",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    /// History of payment
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "История платежей",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    /// Cards
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.payment_rounded,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Мои карты",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    /// Can partners
                    ListTile(
                      onTap: () {
                        _launchURL();
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.wallet_travel_rounded,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        "Стать партнером",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    /// Tech support
                    ListTile(
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
                      leading: const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.help_outline_rounded,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        "Техническая поддержка",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),

                /// Logout
                ListTile(
                  onTap: () {
                    FlutterSecureStorage storage =
                    const FlutterSecureStorage();
                    storage.delete(key: 'token');
                    Navigator.popAndPushNamed(context, '/first_page');
                  },
                  leading: const CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text(
                    "Выйти с аккаунта",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


/// Open url of partners
const String _url = 'https://sulu.life';
void _launchURL() async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
