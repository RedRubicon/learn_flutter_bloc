import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      emit(state + 1);
    });
  }
}

void main() async {
  basicUsage();
}

void basicUsage() async {
  final bloc = CounterBloc();
  // ignore: avoid_print
  print(bloc.state);
  bloc.add(CounterIncrementPressed());
  await Future.delayed(Duration.zero);
  // ignore: avoid_print
  print(bloc.state);
  await bloc.close();
}
