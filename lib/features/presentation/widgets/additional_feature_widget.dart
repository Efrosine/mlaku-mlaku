import 'package:flutter/material.dart';

class AdditionalFeatureWidget extends StatelessWidget {
  const AdditionalFeatureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(190),
      child: GridView.builder(
          itemCount: 10,
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 110,
              mainAxisExtent: 64,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24),
          itemBuilder: (context, index) => Container(
                // color: Colors.red,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueGrey[50],
                    radius: 24,
                    child: Icon(
                      Icons.directions_bus,
                    ),
                  ),
                  Text(
                    'Bus & Travel',
                    style: TextStyle(fontSize: 12),
                  )
                ]),
              )),
    );
  }
}
