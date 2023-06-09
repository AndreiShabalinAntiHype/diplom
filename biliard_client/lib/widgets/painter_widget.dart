import 'dart:async';

import 'package:biliard_client/data/constants.dart';
import 'package:biliard_client/drawing_bloc/drawing_bloc.dart';
import 'package:biliard_client/painters/main_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PainterWidget extends StatefulWidget {
  const PainterWidget({super.key});

  @override
  State<PainterWidget> createState() => _PainterWidgetState();
}

class _PainterWidgetState extends State<PainterWidget> {
  Timer? timer;


void initTimer() {
  if (timer != null && timer!.isActive) return;

  timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
    //job
    context.read<DrawingBloc>().add(UpdatePos());
  });
}

@override
void dispose() {
  timer?.cancel();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    initTimer();
    return BlocConsumer<DrawingBloc, DrawingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final queryData = MediaQuery.of(context);
        final double painterWidth =
            queryData.size.width - AppConstants.paramsLayout;
        final double painterHeight = queryData.size.height;
        return GestureDetector(
          onTapDown:(details) {
            // print(details);
          },
          child: SizedBox(
            width: painterWidth,
            height: painterHeight,
            child: InteractiveViewer(
              minScale: 0.2,
              maxScale: 2,
                child: CustomPaint(
              painter: MainPainter(painterWidth, painterHeight, state),
            )),
          ),
        );
      },
    );
  }
}
