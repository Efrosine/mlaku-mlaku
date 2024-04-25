// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class AdditionalFeatureWidget extends StatelessWidget {
  const AdditionalFeatureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(210),
      child: GridView.builder(
          itemCount: listItems.length,
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 110,
              mainAxisExtent: 64,
              crossAxisSpacing: 48,
              mainAxisSpacing: 38),
          itemBuilder: (context, index) =>
              AddtitionalFeatureItemWidget(items: listItems[index])),
    );
  }
}

List<AddsItems> listItems = [
  AddsItems(iconData: Icons.directions_bus, name: 'Bus & Travel'),
  AddsItems(iconData: Icons.lte_mobiledata_sharp, name: 'Pulsa'),
  AddsItems(iconData: Icons.electric_bike, name: 'Eco Bike'),
  AddsItems(iconData: Icons.electric_bolt, name: 'Listrik'),
  AddsItems(iconData: Icons.car_rental, name: 'Taxi'),
  AddsItems(iconData: Icons.directions_bus, name: 'Bus & Travel'),
  AddsItems(iconData: Icons.lte_mobiledata_sharp, name: 'Pulsa'),
  AddsItems(iconData: Icons.lte_mobiledata_sharp, name: 'Pulsa'),
  AddsItems(iconData: Icons.lte_mobiledata_sharp, name: 'Pulsa'),
];

class AddsItems {
  final IconData iconData;
  final String name;

  AddsItems({required this.iconData, required this.name});
}

class AddtitionalFeatureItemWidget extends StatelessWidget {
  const AddtitionalFeatureItemWidget({super.key, required this.items});

  final AddsItems items;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        CircleAvatar(
          backgroundColor: Colors.blueGrey[50],
          radius: 32,
          child: Icon(
            items.iconData,
            size: 28,
          ),
        ),
        Text(
          items.name,
          style: TextStyle(fontSize: 12),
        )
      ]),
    );
  }
}
