import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double spentPct;

  ChartCard(this.label, this.spentAmount, this.spentPct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: constraints.maxHeight * 0.7,
                  width: 11,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(220, 220, 220, 1),
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: spentPct,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                    child: Text(label,
                        style: Theme.of(context).textTheme.bodyText2),),),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text("\$${spentAmount}",
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ),
          ],
        ),
      );
    });
  }
}
