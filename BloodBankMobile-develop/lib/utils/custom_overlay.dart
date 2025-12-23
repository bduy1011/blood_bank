import 'package:flutter/material.dart';

class CustomOverlay {
  CustomOverlay({
    required this.context,
    this.offset,
    required this.child,
    this.barrierDismissible,
    this.isProcessDialog,
  });
  final BuildContext context;
  OverlayEntry? _overlayEntry;
  Offset? offset;
  final Widget child;
  final bool? barrierDismissible;
  final bool? isProcessDialog;

  void showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  bool get isShowOverlay => _overlayEntry != null;

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    Offset? position;
    if (offset != null) {
      position = offset!;
    }
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          isProcessDialog == true
              ? Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                )
              : const SizedBox.shrink(),
          barrierDismissible == true
              ? Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      hideOverlay();
                    },
                    onTapDown: (detail) {
                      hideOverlay();
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          position != null
              ? Positioned(
                  top: position.dy,
                  left: position.dx,
                  child: child,
                )
              : Align(
                  alignment: Alignment.center,
                  child: child,
                ),
        ],
      ),
    );
  }
}
