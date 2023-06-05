import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;
  final void Function(double) updateRating;
  const Rating({Key? key, required this.rating, required this.updateRating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(5, (index) {
      return Star(index: index, rating: rating, updateRating: updateRating);
    }));
  }
}

class Star extends StatefulWidget {
  final int index;
  final double rating;
  final void Function(double) updateRating;
  const Star(
      {Key? key,
      required this.index,
      required this.rating,
      required this.updateRating})
      : super(key: key);

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  late bool isFill;
  late bool isHalf;

  @override
  void initState() {
    isFill = widget.rating - widget.index.toDouble() >= 1;
    isHalf = !isFill && widget.rating - widget.index.toDouble() > 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => widget.updateRating(widget.index + 1),
      icon: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            // 오른쪽 드래그
            widget.updateRating(isHalf ? widget.index + 1 : widget.index + 0.5);
          } else if (details.delta.dx < 0) {
            // 왼쪽 드래그
            widget.updateRating(
                isHalf ? widget.index.toDouble() : widget.index + 0.5);
          }
        },
        child: Icon(
            isHalf
                ? Icons.star_half_rounded
                : isFill
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
            size: 36,
            color: Colors.yellow.shade500),
      ),
    );
  }
}
