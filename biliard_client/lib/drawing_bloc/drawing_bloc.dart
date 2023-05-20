import 'dart:typed_data';

import 'package:biliard_client/drawing_bloc/drawing_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_ffi/web_ffi.dart';

part 'drawing_event.dart';
part 'drawing_state.dart';

class DrawingBloc extends Bloc<DrawingEvent, DrawingState> {
  final repo = DrawingRepo();
  DrawingBloc() : super(DrawingState()) {
    on<UpdateN>(_updateN);
    on<UpdateAngle>(_updateAngle);
    // on<UpdateVAngle>(_updateVAngle);
  }

  Future<void> _updateN(UpdateN e, Emitter emit) async {
    repo.updateN(e.n.toInt());
    emitFromRepo(emit);
  }

  Future<void> _updateAngle(UpdateAngle e, Emitter emit) async {
    repo.updateAngle(e.angle.toDouble());
    emitFromRepo(emit);
  }

  // Future<void> _updateVAngle(UpdateVAngle e, Emitter emit) async {
  //   repo.updateVAngle(e.vAngle);
  //   emitFromRepo(emit);
  // }

  emitFromRepo(Emitter emit) {
    emit(DrawingState(
      n: repo.numOfPoints,
      angle: repo.startingAngle,
    ));
  }
}
