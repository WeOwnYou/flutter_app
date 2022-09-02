import 'package:flutter/material.dart';

// TODO(update): how to it better???
class ConnectivityOverlay {
  OverlayEntry? overlayEntry;
  ConnectivityOverlay._();

  static final instance = ConnectivityOverlay._();

  void showOverlay(BuildContext context, String text) {
    // print('opening ${overlayEntry?.mounted}');
    if (overlayEntry != null && overlayEntry!.mounted) return;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).viewInsets.top + 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context)
                .size
                .width, // получаем width всего экрана
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              decoration: BoxDecoration(
                color: ThemeData.dark().primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
    // print(overlayEntry);
    Overlay.of(context)?.insert(overlayEntry!);
  }

  void removeOverlay() {
    // print('closing ${overlayEntry}');
    if (overlayEntry != null && overlayEntry!.mounted) {
      overlayEntry?.remove();
    }
  }
}

/*
Future<void> _showOverlay(
  BuildContext context, {
  required String text,
  bool hasInternet = true,
}) async {
  final overlayState = Overlay.of(context);
  const secondsDuration = 2;
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).viewInsets.top + 50,
      child: Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          width:
              MediaQuery.of(context).size.width, // получаем width всего экрана
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            decoration: BoxDecoration(
              color: ThemeData.dark().primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );
  /*
  OverlayEntry(
    builder: (context) {
      return BuildOverlayEntryWidget(
        text: text,
        secondsDuration: secondsDuration,
      );
    },
  );

   */
  overlayState!.insert(overlayEntry);
  await Future<void>.delayed(const Duration(seconds: secondsDuration))
      .whenComplete(hasInternet ? overlayEntry.remove : () {});
}
 */
