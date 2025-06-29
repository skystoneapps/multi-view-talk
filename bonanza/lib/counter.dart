import 'package:bonanza/total_count.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _registerCounter();
    });
  }

  @override
  void dispose() {
    _unregisterCounter();
    super.dispose();
  }

  void _registerCounter() {
    TotalCountProvider.of(context).registerCategory(widget.category);
  }

  void _unregisterCounter() {
    TotalCountProvider.of(context).unregisterCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final totalCount = TotalCountProvider.of(context);
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: <Widget>[
                Text(
                  widget.category,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Count:: ${totalCount.counts[widget.category] ?? 0}',
                  style: const TextStyle(fontSize: 32),
                ),
                Text(
                  'Total Count: ${totalCount.total}',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            totalCount.increment(widget.category);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
