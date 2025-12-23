import 'package:flutter/material.dart';

class CustomOverlaySelect<T> {
  CustomOverlaySelect({
    required this.context,
    this.lineHeight,
    this.lineWidth,
    this.offset,
    required this.options,
    this.onChange,
    this.iconWidget,
    this.iconSelectWidget,
    this.isMultiSelect,
    this.onSelect,
    this.optionsSelect,
    this.isSearch,
    this.hintTextSearch,
    this.padding,
    this.onHide,
  });
  final EdgeInsets? padding;
  final BuildContext context;
  OverlayEntry? _overlayEntry;
  final double? lineHeight;
  final double? lineWidth;
  Offset? offset;
  final List<T> options;
  final List<T>? optionsSelect;
  final void Function(T)? onChange;
  final void Function(List<T>)? onSelect;
  final Widget? iconWidget;
  final Widget? iconSelectWidget;
  final Function? onHide;

  final bool? isMultiSelect;
  void Function(void Function())? _setState;
  String? textSearch;
  String? hintTextSearch;

  final bool? isSearch;

  bool get isShowOverlay => _overlayEntry != null;
  void showOverlay({BuildContext? c}) {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(c ?? context).insert(_overlayEntry!);
  }

  void onSearch(String text) {
    try {
      _setState?.call(() {
        ///
        textSearch = text;
      });
    } catch (e) {
      // TODO
    }
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    if (_overlayEntry != null) {
      onHide?.call();
    }

    _overlayEntry = null;
    textSearch = null;
  }

  OverlayEntry _createOverlayEntry({BuildContext? c}) {
    late Offset position;
    double? heightParent;
    if (offset != null) {
      position = offset!;
    } else {
      RenderBox renderBox = (c ?? context).findRenderObject() as RenderBox;
      position = renderBox.localToGlobal(Offset.zero);
      heightParent = renderBox.size.height;
    }

    return OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  _hideOverlay();
                },
                onTapDown: (detail) {
                  _hideOverlay();
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            StatefulBuilder(builder:
                (BuildContext c1, void Function(void Function()) setState) {
              _setState = setState;

              ///
              double max = MediaQuery.sizeOf(context).height -
                  MediaQuery.viewInsetsOf(context).bottom -
                  MediaQuery.paddingOf(context).bottom -
                  (position.dy + (lineHeight ?? heightParent ?? 0));
              double height = (MediaQuery.sizeOf(context).height -
                      MediaQuery.viewInsetsOf(context).bottom) *
                  0.5;

              double? top = position.dy + (lineHeight ?? heightParent ?? 0);
              if (MediaQuery.viewInsetsOf(context).bottom > 0) {
                height = MediaQuery.sizeOf(context).height -
                    MediaQuery.viewInsetsOf(context).bottom -
                    top;
              }
              if (height > max) {
                height = max;
              }
              double? bottom;
              if (height <
                  (MediaQuery.sizeOf(context).height -
                          MediaQuery.viewInsetsOf(context).bottom) *
                      0.25) {
                bottom = MediaQuery.sizeOf(context).height - position.dy;
                top = null;
                height = MediaQuery.sizeOf(context).height * 0.5;
                if (MediaQuery.viewInsetsOf(context).bottom > 0) {
                  ///
                  if (bottom < MediaQuery.viewInsetsOf(context).bottom) {
                    height = height -
                        (MediaQuery.viewInsetsOf(context).bottom - bottom);
                    bottom = MediaQuery.viewInsetsOf(context).bottom;
                  }
                }
              }
              Alignment alignment =
                  bottom != null ? Alignment.bottomLeft : Alignment.topLeft;
              if (position.dx > MediaQuery.sizeOf(context).width / 2) {
                alignment =
                    bottom != null ? Alignment.bottomRight : Alignment.topRight;
              }

              return Positioned(
                top: top,
                bottom: bottom,
                left: 16,
                right: 16,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: height),
                  child: Container(
                    child: Stack(
                      children: [
                        Align(
                          alignment: alignment,
                          child: Card(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 5,
                            child: Container(
                              padding: padding ??
                                  const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SingleChildScrollView(
                                      physics: const ClampingScrollPhysics(),
                                      child: IntrinsicWidth(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: (isSearch == true) ? 50 : 0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ...options
                                                    .where((e) {
                                                      return "$e"
                                                          .toLowerCase()
                                                          .contains(((textSearch ??
                                                                  "")
                                                              .toLowerCase()));
                                                    })
                                                    .toList()
                                                    .map((value) =>
                                                        buildItem(value)),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isSearch == true)
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(8)),
                                      ),
                                      child: TextField(
                                        onChanged: (v) {
                                          onSearch(v);
                                        },
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          hintText: hintTextSearch,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  bool isSelect(T value) {
    if (optionsSelect?.contains(value) == true) {
      return true;
    }
    return false;
  }

  Widget buildItem(T value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        options.indexWhere((e) => e == value) == 0
            ? const SizedBox.shrink()
            : const Divider(
                color: Colors.grey,
                height: 1,
              ),
        GestureDetector(
          onTap: () {
            if (isMultiSelect == true) {
              if (isSelect(value)) {
                optionsSelect?.removeWhere((e) => e == value);
                onSelect?.call(optionsSelect ?? <T>[]);
                _setState?.call(() {});
              } else {
                optionsSelect?.add(value);
                onSelect?.call(optionsSelect ?? <T>[]);
                _setState?.call(() {});
              }
            } else {
              onChange?.call(value);
              _hideOverlay();
            }
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 40),
            width: double.maxFinite,
            padding: const EdgeInsets.only(right: 5),
            color: isSelect(value) ? Colors.grey[200] : Colors.transparent,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                isMultiSelect != true
                    ? (iconWidget ?? const SizedBox.shrink())
                    : isSelect(value)
                        ? (iconSelectWidget ?? const SizedBox.shrink())
                        : (iconWidget ?? const SizedBox.shrink()),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$value",
                      style: const TextStyle(
                        color: Color(0xff111827),
                        fontSize: 16,
                        height: 24 / 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
