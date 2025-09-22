import 'dart:ui_web' as ui_web;

import 'package:bonanza/main.dart';
import 'package:bonanza/total_count.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({
    super.key,
  });

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

  String get category {
    final int viewId = View.of(context).viewId;
    final initialData =
        ui_web.views.getInitialData(viewId) as VoteCounterInitialData;
    return initialData.category; // e.g. "🍟"
  }

  void _registerCounter() {
    TotalCountProvider.of(context).registerCategory(category);
  }

  void _unregisterCounter() {
    TotalCountProvider.of(context).unregisterCategory(category);
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
                  category,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Count_: ${totalCount.counts[category] ?? 0}',
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
            totalCount.increment(category);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
