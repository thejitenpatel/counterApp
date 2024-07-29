import 'package:counter_app/counter_bloc.dart';
import 'package:counter_app/counter_event.dart';
import 'package:counter_app/counter_state.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final _counterBloc = CounterBloc();

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter Page"),
      ),
      body: Center(
        child: StreamBuilder<CounterState>(
          stream: _counterBloc.state,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Counter value: ${snapshot.data?.counter ?? 0}',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () =>
                            _counterBloc.event.add(IncrementEvent()),
                        child: const Text('Increment'),
                      ),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () =>
                            _counterBloc.event.add(DecrementEvent()),
                        child: const Text('Decrement'),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
