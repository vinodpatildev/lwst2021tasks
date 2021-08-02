import 'dart:html';

import 'package:flutter/material.dart';

class TOutput extends StatelessWidget {
  final String Toutput;
  const TOutput(this.Toutput);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),
        color: Colors.deepPurple,
        ),
        padding: EdgeInsets.all(5),
        
        child:Text(Toutput,style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
