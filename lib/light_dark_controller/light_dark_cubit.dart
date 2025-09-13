import 'package:flutter_bloc/flutter_bloc.dart';

import 'light_dark_states.dart';

class LightDarkCubit extends Cubit<ThemeState> {
  LightDarkCubit() : super(DarkState());

  void lightTheming() {
    emit(LightState());
  }

  void darkTheming() {
    emit(DarkState());
  }
}
