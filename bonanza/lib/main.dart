import 'dart:js_interop';
import 'dart:ui_web' as ui_web;
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
          final int viewId = View.of(context).viewId;
          final initialData =
              ui_web.views.getInitialData(viewId) as BonanzaInitialData;
          return DeferredLibrary(
            load: counter.loadLibrary,
            builder: () {
              return counter.Counter(
                category: initialData.category,
              );
            },
          );
        },
      ),
    ),
  );
}

extension type BonanzaInitialData<T extends JSObject>._(JSObject o)
    implements JSObject {
  external BonanzaInitialData({String category});
  external String get category;
}
