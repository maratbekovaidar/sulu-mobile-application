
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> { //todo бэк убрать у профиля  у кнопок убрать красные грани
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("В разработке", textAlign: TextAlign.center,),
    );
  }
}
