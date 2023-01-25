import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);
  int activePageIndex = 0;

  void changePageIndex(int newIndex) {
    emit(activePageIndex = newIndex);
  }
}