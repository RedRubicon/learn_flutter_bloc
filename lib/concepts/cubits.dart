import 'package:bloc/bloc.dart';

void main() {
  basicUsage();
}

void basicUsage() {
  final cubit = CounterCubit();
  // ignore: avoid_print
  print(cubit.state); // 0
  cubit.increment();
  // ignore: avoid_print
  print(cubit.state); // 1
  cubit.close();
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}
