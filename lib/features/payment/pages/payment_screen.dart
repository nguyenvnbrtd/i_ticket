import 'package:flutter/material.dart';
import 'package:flutter_animation/widgets/base_screen/origin_screen.dart';

class PaymentScreen extends StatefulWidget{
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return OriginScreen(
      child: Container(
        color: Colors.red,
      ),
    );
  }
}