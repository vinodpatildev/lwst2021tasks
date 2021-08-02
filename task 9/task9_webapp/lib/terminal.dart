import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'terminal_output.dart';

class Terminal extends StatelessWidget {
  late List<String> Output = [];
  Terminal(this.Output);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        // color: Colors.black,
      ),
      height: 450,
      child: ListView(
        children: Output.map((data) {
          return TOutput(data);
        }).toList(),
      ),
    );
  }
}
