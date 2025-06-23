import 'package:flutter/widgets.dart';
import 'dart:js_interop';

@JS()
external void setCategoryVotes(String category, int votes);

class TotalCountProvider extends InheritedNotifier<TotalCountState> {
  TotalCountProvider({
    super.key,
    required super.child,
  }) : super(
         notifier: TotalCountState(),
       );

  static TotalCountState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TotalCountProvider>()!
        .notifier!;
  }

  @override
  bool updateShouldNotify(TotalCountProvider oldWidget) => true;
}

class TotalCountState extends ChangeNotifier {
  final Map<String, int> _counts = {};

  int get total => _counts.values.fold(0, (a, b) => a + b);

  Map<String, int> get counts => Map.unmodifiable(_counts);

  void registerCategory(String category) {
    if (!_counts.containsKey(category)) {
      _counts[category] = 0;
      notifyListeners();
    }
  }

  void unregisterCategory(String category) {
    if (_counts.containsKey(category)) {
      _counts.remove(category);
      notifyListeners();
    }
  }

  void increment(String category) {
    if (_counts.containsKey(category)) {
      _counts[category] = _counts[category]! + 1;
      setCategoryVotes(category, _counts[category]!);
      notifyListeners();
    }
  }
}
