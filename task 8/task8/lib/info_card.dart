import 'package:flutter/material.dart';
import 'data_item.dart';
import 'data_item_widget.dart';

class InfoCard extends StatefulWidget {
  final List<Data> vehicleData;
  const InfoCard(this.vehicleData);

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        height: 450,
        child: ListView(          
          children: widget.vehicleData.map((info) {
            return DataCard(title: info.title, value: info.value);
          }).toList(),
        ),
      ),
    );
  }
}
