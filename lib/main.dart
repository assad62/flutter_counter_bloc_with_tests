import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int>{
  CounterBloc() : super(0){

    on<CounterEvent>((event, emit) {
      switch(event.runtimeType){

        case IncrementEvent:
          emit(state+1);

          case DecrementEvent:
           emit(state-1);
      }
    });
  }

}


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final CounterBloc bloc = CounterBloc();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Counter App'),
        ),
        body: BlocBuilder<CounterBloc, int>(
          bloc: bloc,
          builder: (context, count) {
            return Center(
              child: Text(
                'Count: $count',
                style: const TextStyle(fontSize: 24),
              ),
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => bloc.add(IncrementEvent()),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () => bloc.add(DecrementEvent()),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}