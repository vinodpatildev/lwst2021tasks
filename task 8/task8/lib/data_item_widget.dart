import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final String title;
  final String value;
  const DataCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: Colors.deepPurple,),
        
        child: Row(
          children: [
            Container(width:150, child: Text(title, style: TextStyle(color: Colors.white,fontSize: 20, ))),
            Text(" : " + value, style: TextStyle(color: Colors.white,fontSize: 20,  ),),
          ],
        ),
      ),
    );
  }
}
