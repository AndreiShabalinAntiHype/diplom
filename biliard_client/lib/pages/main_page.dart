import 'package:biliard_client/widgets/painter_widget.dart';
import 'package:biliard_client/widgets/parameters_layout.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          PainterWidget(),
          ParametersLayout(),
        ],
      ),
    );
  }
}
