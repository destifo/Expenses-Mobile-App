import 'package:expenses_app_restarted/widgets/color_list_tile.dart';
import 'package:flutter/material.dart';

class ChooseColor extends StatefulWidget {
  const ChooseColor({Key? key, required this.changeColor}) : super(key: key);
  final Function(String color) changeColor;

  @override
  State<ChooseColor> createState() => _ChooseColorState();
}

class _ChooseColorState extends State<ChooseColor> {
  String pickedColor = 'Purple';

  void _chooseColor(String color) {
    setState(() {
      pickedColor = color;
    });
    widget.changeColor(color);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          child: Form(
              child: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              const Text(
                'Choose app\'s theme color',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              ColorListTile(
                  colorName: 'Purple',
                  chooseColor: _chooseColor,
                  pickedColor: pickedColor),
              ColorListTile(
                  colorName: 'Pink',
                  chooseColor: _chooseColor,
                  pickedColor: pickedColor),
              ColorListTile(
                  colorName: 'Green',
                  chooseColor: _chooseColor,
                  pickedColor: pickedColor),
            ],
          )),
        );
      },
    );
  }
}
