import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.onPresssed,
    required this.name,
  }) : super(key: key);

  VoidCallback onPresssed;
  String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPresssed,
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blue[300],
        ),
        child: Center(
          child: Text(name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  )),
        ),
      ),
    );
  }
}
