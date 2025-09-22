import 'dart:js_interop';

import 'package:bonanza/util/deferred_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'counter.dart' deferred as counter;
import 'total_count.dart';
import 'util/multi_view_app.dart';

void main() {
  setUrlStrategy(null);

  runWidget(
    TotalCountProvider(
      child: MultiViewApp(
        viewBuilder: (context) {
          return DeferredLibrary(
            load: counter.loadLibrary,
            builder: () {
              return counter.Counter();
            },
          );
        },
      ),
    ),
  );
}

extension type VoteCounterInitialData<T extends JSObject>._(JSObject o)
    implements JSObject {
  external VoteCounterInitialData({String category});
  external String get category;
}
