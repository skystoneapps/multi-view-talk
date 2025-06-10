import 'package:flutter/material.dart';

class DeferredLibrary extends StatefulWidget {
  const DeferredLibrary({super.key, required this.load, required this.builder});

  final Widget Function() builder;
  final Future<void> Function() load;

  @override
  State<DeferredLibrary> createState() => _DeferredLibraryState();
}

class _DeferredLibraryState extends State<DeferredLibrary> {
  late Future<void> _loadLibraryFuture;

  @override
  void initState() {
    super.initState();
    _loadLibraryFuture = widget.load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadLibraryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return widget.builder();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
