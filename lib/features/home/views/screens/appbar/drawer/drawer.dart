import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sulu_mobile_application/utils/bloc/user_bloc/user_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class SuluDrawer extends StatefulWidget {
  const SuluDrawer({Key? key}) : super(key: key);

  @override
  _SuluDrawerState createState() => _SuluDrawerState();
}

class _SuluDrawerState extends State<SuluDrawer> {
  Function? navigateToPage(BuildContext context,String pathName){
    Navigator.pushNamed(context, pathName);

  }
  Function? becomePartner() {
          showDialog(context: context, builder: (_) {

            TextEditingController _personController = TextEditingController();
            TextEditingController _feedbackController = TextEditingController();



            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: const Text("Напишите отчет", textAlign: TextAlign.center),
              content: SizedBox(
                height: 170,
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
                        maxLines: 2,
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
                      var url = Uri.parse('https://api.telegram.org/bot5058514406:AAHBko2SdNPqQIemzUUEcB0sRBUBwABJx98/sendMessage?chat_id=-1001658501273&text=$textOutput');
                      await http.post(url);
                    },
                    child: const Text("Отправить")
                )
              ],
            );
          });
  }
  @override
  Widget build(BuildContext context) {

    List<ListTileItem> listTileItems=  [
       ListTileItem(onTap: (){navigateToPage(context,'/');}, text: "Главная", icon: Icons.home),
        ListTileItem(onTap: (){navigateToPage(context, '/favorite');}, text: "Избранные", icon: Icons.favorite),
        ListTileItem( onTap:(){}, text: "История платежей", icon:Icons.history),
        ListTileItem( onTap:(){},text: "Мои карты", icon: Icons.payment_outlined),
        ListTileItem( onTap:()async{_launchURL();}, text: "Стать партнером", icon: Icons.wallet_travel_rounded),
        ListTileItem( onTap: (){becomePartner();}, text: "Техническая поддержка", icon: Icons.help_outline_rounded)
    ];

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
                                  Navigator.popAndPushNamed(context, '/profile');
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
                                        const SizedBox(height: 5),

                                        /// City
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.black38,
                                              size: 18,
                                            ),
                                            Text(
                                              state.userModel.city.name,
                                              style: const TextStyle(
                                                color: Colors.black38,
                                                fontSize: 18
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 15),

                                    /// Avatar
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
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
                    
                   SizedBox(
                      height: 340,
                      child: ListView.builder(
                        itemCount: listTileItems.length,
                          itemBuilder: (context,index){
                        return listTileItems[index];
                      }),
                    ),

                //     /// Главная
                //     ListTile(
                //       onTap: () {
                //         Navigator.pushNamed(context, '/');
                //       },
                //       leading: const CircleAvatar(
                //         backgroundColor: Colors.redAccent,
                //         child: Icon(
                //           Icons.favorite,
                //           color: Colors.white,
                //         ),
                //       ),
                //       title: const Text(
                //         "Избранные",
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ),
                //
                //     /// Фавориты
                //     ListTile(
                //       onTap: () {
                //         Navigator.pushNamed(context, '/favorite');
                //       },
                //       leading: const CircleAvatar(
                //         backgroundColor: Colors.redAccent,
                //         child: Icon(
                //           Icons.favorite,
                //           color: Colors.white,
                //         ),
                //       ),
                //       title: const Text(
                //         "Избранные",
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ),
                //
                //     /// History of payment
                //     const ListTile(
                //       leading: CircleAvatar(
                //         backgroundColor: Colors.redAccent,
                //         child: Icon(
                //           Icons.history,
                //           color: Colors.white,
                //         ),
                //       ),
                //       title: Text(
                //         "История платежей",
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ),
                //
                //     /// Cards
                //     const ListTile(
                //       leading: CircleAvatar(
                //         backgroundColor: Colors.redAccent,
                //         child: Icon(
                //           Icons.payment_rounded,
                //           color: Colors.white,
                //         ),
                //       ),
                //       title: Text(
                //         "Мои карты",
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ),
                //
                //     /// Can partners
                //     ListTile(
                //       onTap: () {
                //         _launchURL();
                //       },
                //       leading: const CircleAvatar(
                //         backgroundColor: Colors.redAccent,
                //         child: Icon(
                //           Icons.wallet_travel_rounded,
                //           color: Colors.white,
                //         ),
                //       ),
                //       title: const Text(
                //         "Стать партнером",
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ),
                //
                //     /// Tech support
                //     ListTile(
                //       onTap: () {
                //         showDialog(context: context, builder: (_) {
                //
                //           TextEditingController _personController = TextEditingController();
                //           TextEditingController _feedbackController = TextEditingController();
                //
                //
                //
                //           return AlertDialog(
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(20.0),
                //             ),
                //             title: const Text("Напишите отчет", textAlign: TextAlign.center),
                //             content: SizedBox(
                //               height: 170,
                //               child: Center(
                //                 child: Column(
                //                   children: [
                //                     TextField(
                //                       controller: _personController,
                //                       decoration: const InputDecoration(
                //                           hintText: "Ваши контакты"
                //                       ),
                //                     ),
                //                     const SizedBox(height: 10),
                //                     TextField(
                //                       controller: _feedbackController,
                //                       maxLines: 2,
                //                       decoration: const InputDecoration(
                //                         hintText: "Ваш предложение",
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             actions: [
                //               TextButton(
                //                   onPressed: () async {
                //                     Navigator.pop(context);
                //                     String feedbackText = _feedbackController.value.text;
                //                     String personText = _personController.value.text;
                //                     String textOutput = "Контакты: " + personText + ".\nСообщение: " + feedbackText;
                //                     var url = Uri.parse('https://api.telegram.org/bot5058514406:AAHBko2SdNPqQIemzUUEcB0sRBUBwABJx98/sendMessage?chat_id=-1001658501273&text=$textOutput');
                //                     await http.post(url);
                //                   },
                //                   child: const Text("Отправить")
                //               )
                //             ],
                //           );
                //         });
                //       },
                //       leading: const CircleAvatar(
                //         backgroundColor: Colors.redAccent,
                //         child: Icon(
                //           Icons.help_outline_rounded,
                //           color: Colors.white,
                //         ),
                //       ),
                //       title: const Text(
                //         "Техническая поддержка",
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ),
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

class ListTileItem extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData icon;
  const ListTileItem({
    required this.onTap,
    required this.text,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Icon(icon, color: Colors.white,)
      ),
      title:  Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}


/// Open url of partners
const String _url = 'https://sulu.life';
Future _launchURL() async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
