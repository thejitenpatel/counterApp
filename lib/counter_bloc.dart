import 'dart:async';

import 'package:counter_app/counter_event.dart';
import 'package:counter_app/counter_state.dart';

class CounterBloc {
  int _counter = 0;

  // Stream controllers
  final _stateController = StreamController<CounterState>();

  // Event controller
  final _eventController = StreamController<CounterEvent>();
  
  // Output Stream
  Stream<CounterState> get state => _stateController.stream;

  // Input Sink
  Sink<CounterEvent> get event => _eventController.sink;

  CounterBloc() {
    _stateController.add(CounterState(_counter)); // Initial state
    _eventController.stream.listen(
      (event) => _stateController.add(
        _mapEventToState(event),
      ),
    );
  }

  CounterState _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else if (event is DecrementEvent) {
      _counter--;
    }

    return CounterState(_counter);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
