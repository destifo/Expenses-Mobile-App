import 'package:flutter/material.dart';

class ColorListTile extends StatelessWidget {
  const ColorListTile(
      {Key? key,
      required this.chooseColor,
      required this.pickedColor,
      required this.colorName})
      : super(key: key);
  final String pickedColor;
  final Function(String color) chooseColor;
  final String colorName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(colorName),
      leading: Radio(
          value: colorName,
          groupValue: pickedColor,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (clr) {
            String color = clr.toString();
            chooseColor(color);
          }),
    );
  }
}
