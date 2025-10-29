import 'package:bloc/bloc.dart';

void main() async {
  // basicUsage();
  streamUsage();
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

void streamUsage() async {
  final cubit = CounterCubit();
  // ignore: avoid_print
  final subscription = cubit.stream.listen((value) => print(value));
  cubit.increment();
  await Future.delayed(Duration.zero);
  await subscription.cancel();
  await cubit.close();
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    // ignore: avoid_print
    print(change);
  }
}
