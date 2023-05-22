import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_final/main.dart';



// Mock Bloc
class MockCounterBloc extends MockBloc<CounterEvent, int>
    implements CounterBloc {}

void main() {
  group('whenListen', () {
    test("Let's mock the CounterBloc's stream!", () {
      // Create Mock CounterBloc Instance
      final bloc = MockCounterBloc();

      // Stub the listen with a fake Stream
      whenListen(bloc, Stream.fromIterable([0, 1, 2, 3]));

      // Expect that the CounterBloc instance emitted the stubbed Stream of
      // states
      expectLater(bloc.stream, emitsInOrder(<int>[0, 1, 2, 3]));
    });
  });

  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    tearDown(() {
     // counterBloc.close();
    });

    test('initial state should be 0', () {
      expect(counterBloc.state, 0);
    });

    blocTest<CounterBloc, int>(
      'emits [1] when IncrementEvent is added',
      build: () => counterBloc,
      act: (bloc) => bloc.add(IncrementEvent()),
      expect:()=> [1],
    );

    blocTest<CounterBloc, int>(
      'emits [-1] when DecrementEvent is added',
      build: () => counterBloc,
      act: (bloc) => bloc.add(DecrementEvent()),
      expect:()=> [-1],
    );
  });
}

