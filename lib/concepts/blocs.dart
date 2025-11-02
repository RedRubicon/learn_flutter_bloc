import 'package:bloc/bloc.dart';

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      addError(Exception('Error'), StackTrace.current);
      emit(state + 1);
    });
  }

  @override
  void onChange(Change<int> change) {
    // ignore: avoid_print
    print(change);
    super.onChange(change);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    // ignore: avoid_print
    print(transition);
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
    print('${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // ignore: avoid_print
    print('${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // ignore: avoid_print
    print('${bloc.runtimeType}, \n$error \n$stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  // basicUsage();
  // streamUsage();
  Bloc.observer = SimpleBlocObserver();
  CounterBloc()
    ..add(CounterIncrementPressed())
    ..close();
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

void streamUsage() async {
  final bloc = CounterBloc();
  // ignore: avoid_print
  final subscription = bloc.stream.listen(print);
  bloc.add(CounterIncrementPressed());
  await Future.delayed(Duration.zero);
  await subscription.cancel();
  await bloc.close();
}
