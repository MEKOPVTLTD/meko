import 'package:flutter/material.dart';

class GenderWidget extends StatelessWidget {
  final VoidCallback onclick;
  final IconData icon;

  final bool isSelected;

  GenderWidget({
    required this.isSelected,
    required this.onclick,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected == true
                ? Colors.white.withOpacity(0.2)
                : Colors.white
                    .withOpacity(0.0), //change color based on your need,
            border: Border.all(
              color: isSelected == true
                  ? Colors.white.withOpacity(0.3)
                  : Colors.white
                      .withOpacity(0.0), //change color based on your need,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              color: Colors.white,
              icon,
              size: 50,
            )
          ],
        )),
      ),
    );
  }
}
