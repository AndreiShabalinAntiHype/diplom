import 'dart:math';

import 'package:biliard_client/drawing_bloc/drawing_bloc.dart';
import 'package:biliard_client/widgets/slider_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParametersLayout extends StatelessWidget {
  const ParametersLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final drawingBlocState = context.read<DrawingBloc>().state;
    return Container(
        color: const Color.fromRGBO(242, 242, 242, 1),
        width: 220,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CustomSlider("Num of points", (p) {
              context.read<DrawingBloc>().add(UpdateN(p));
            }, drawingBlocState.numOfPoints as double, 1, 5000),
            CustomSlider("Radius", (p) {
              context.read<DrawingBloc>().add(UpdateR(p.toDouble()));
            },500, 0, 2000),
            // CustomSlider("Velocity angle", (p) {
            //   context.read<DrawingBloc>().add(UpdateVAngle(p));
            // }, drawingBlocState.velocityAngle, 1, 5),
          ],
        ));
  }
}
