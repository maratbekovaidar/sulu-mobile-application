
import 'package:flutter/material.dart';

class SalonsPage extends StatefulWidget {
  const SalonsPage({Key? key}) : super(key: key);

  @override
  _SalonsPageState createState() => _SalonsPageState();
}

class _SalonsPageState extends State<SalonsPage> {
  
  @override
  Widget build(BuildContext context) {
    
    // /// Size
    // double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Салоны"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(),
          )
        ],
      )
    );
  }
}
