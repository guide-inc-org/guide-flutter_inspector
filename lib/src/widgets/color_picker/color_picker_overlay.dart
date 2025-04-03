import 'package:flutter/material.dart';

import 'utils.dart';

class ColorPickerOverlay extends StatelessWidget {
  static const double size = 56.0;

  const ColorPickerOverlay({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black12,
            offset: Offset(0.0, 8.0),
          ),
        ],
      ),
      alignment: Alignment.bottomRight,
      child: Material(
        type: MaterialType.transparency,
        child: Text(
          colorToHexString(color),
          style: TextStyle(
            color: getTextColorOnBackground(color),
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
