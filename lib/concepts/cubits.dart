import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // ignore: unused_local_variable
  final cubit = CounterCubit();
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}
