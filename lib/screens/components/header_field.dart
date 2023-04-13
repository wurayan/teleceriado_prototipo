import 'package:flutter/material.dart';

class HeaderField extends StatelessWidget {
  String value;
  HeaderField({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01),
      child: Text(value, style:const TextStyle(fontSize: 18)),
    );
  }
}