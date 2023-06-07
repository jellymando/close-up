import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Widget child;
  final void Function() onPressed;
  final String type;
  final bool isFill;

  const Button(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.type = 'primary',
      this.isFill = true})
      : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Color color = Colors.cyan.shade300;

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case 'primary':
        setState(() {
          color = Colors.cyan.shade300;
        });
        break;
      case 'secondary':
        setState(() {
          color = Colors.black12;
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: widget.child,
      style: widget.isFill
          ? ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              backgroundColor: MaterialStateProperty.all<Color>(color),
            )
          : ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                color: color,
                width: 1.0,
              )),
              foregroundColor: MaterialStateProperty.all<Color>(color),
            ),
    );
  }
}
