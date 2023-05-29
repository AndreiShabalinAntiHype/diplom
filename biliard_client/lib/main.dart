import 'package:biliard_client/drawing_bloc/drawing_bloc.dart';
import 'package:biliard_client/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
      create: (BuildContext context) {
        return DrawingBloc();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<DrawingBloc>().add(SetPainterSize(width - 220, height));
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
