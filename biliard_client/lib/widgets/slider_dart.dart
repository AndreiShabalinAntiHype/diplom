import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  double sliderValue, minValue, maxValue;
  String sliderName;
  final void Function(num) functionToUpdate;

  CustomSlider(this.sliderName, this.functionToUpdate, this.sliderValue,
      this.minValue, this.maxValue,
      {super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.sliderName),
        Slider(
          value: widget.sliderValue,
          min: widget.minValue,
          max: widget.maxValue,
          onChanged: (value) => setState(() {
            widget.sliderValue = value;
            widget.functionToUpdate(value);
          }),
        ),
      ],
    );
  }
}
