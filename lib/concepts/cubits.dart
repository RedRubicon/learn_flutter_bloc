import 'package:bloc/bloc.dart';

void main() async {
  // basicUsage();
  // streamUsage();
  Bloc.observer = SimpleBlocObserver();
  CounterCubit()
    ..increment()
    ..close();
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

  void increment() {
    addError(Exception('increment error'), StackTrace.current);
    emit(state + 1);
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    // ignore: avoid_print
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // ignore: avoid_print
    print('$error \n$stackTrace');
    super.onError(error, stackTrace);
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // ignore: avoid_print
    print('${bloc.runtimeType} $error \n$stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
