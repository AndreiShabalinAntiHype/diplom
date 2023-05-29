import 'dart:typed_data';
import 'dart:ui';

import 'package:biliard_client/drawing_bloc/drawing_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_ffi/web_ffi.dart';

part 'drawing_event.dart';
part 'drawing_state.dart';

class DrawingBloc extends Bloc<DrawingEvent, DrawingState> {
  final repo = DrawingRepo();
  DrawingBloc() : super(DrawingState( Float32List.fromList([]))) {
    on<UpdateN>(_updateN);
    on<UpdatePos>(_updatePos);
    on<SetPainterSize>(_setSize);
    // on<UpdateAngle>(_updateAngle);
    // on<UpdateVAngle>(_updateVAngle);
    on<StopMoving>(_stop);
    on<StartMoving>(_start);
  }

  Future<void> _stop(StopMoving e, Emitter emit) async {
    repo.stop();
    emitFromRepo(emit);
  }

  Future<void> _start(StartMoving e, Emitter emit) async {
    repo.start();
    emitFromRepo(emit);
  }

  Future<void> _updateN(UpdateN e, Emitter emit) async {
    repo.updateN(e.n.toInt());
    emitFromRepo(emit);
  }

  Future<void> _updatePos(UpdatePos e, Emitter emit) async {
    if (repo.isMoving) {
      repo.updatePos();
      emitFromRepo(emit);
    }
  }

  Future<void> _setSize(SetPainterSize e, Emitter emit) async {
    repo.setPainterSize(Size(e.w, e.h));
            emitFromRepo(emit);

  }


  // Future<void> _updateAngle(UpdateAngle e, Emitter emit) async {
  //   repo.updateAngle(e.angle.toDouble());
  //   emitFromRepo(emit);
  // }

  // Future<void> _updateVAngle(UpdateVAngle e, Emitter emit) async {
  //   repo.updateVAngle(e.vAngle);
  //   emitFromRepo(emit);
  // }

  emitFromRepo(Emitter emit) {
    emit(DrawingState(repo.getRawPos,
      n: repo.numOfPoints,
    ));
  }
}
