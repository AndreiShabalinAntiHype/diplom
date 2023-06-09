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
            numOfPointsSlider(context, drawingBlocState),
            stopButton(context),
            startButton(context),
          ],
        ));
  }

  Widget numOfPointsSlider(BuildContext context, DrawingState state) {
          return      CustomSlider("Num of points", (p) {
              context.read<DrawingBloc>().add(UpdateN(p));
            }, state.numOfPoints as double, 1, 2500);
  }

  Widget stopButton(BuildContext context) {
  return TextButton(
    onPressed: () => context.read<DrawingBloc>().add(StopMoving()),
    child: Text("Stop"),
  );
  }

      Widget startButton(BuildContext context) {
  return TextButton(
    onPressed: () => context.read<DrawingBloc>().add(StartMoving()),
    child: Text("Start"),
  );
      }
}
