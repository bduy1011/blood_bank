import 'package:blood_donation/app/theme/colors.dart';
import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  CheckboxWidget({
    super.key,
    this.isEnabled = true,
    this.value,
    this.onChange,
    this.text,
    this.onClick,
    this.padding,
    this.color,
  });

  bool? value;
  final bool? isEnabled;
  void Function(bool? v)? onChange;
  void Function()? onClick;
  final String? text;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  void didUpdateWidget(covariant CheckboxWidget oldWidget) {
    // TODO: implement didUpdateWidget
    if (widget.value != oldWidget.value) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
                side: const BorderSide(
                  // set border color here
                  color: Colors.black87,
                  width: 1.0,
                ),
                value: widget.value == true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                fillColor: WidgetStateProperty.resolveWith(
                  (state) => getColor(
                    state,
                    widget.value == true,
                  ),
                ),
                onChanged: (bool? value) {
                  if (widget.isEnabled == true) {
                    ///
                    setState(() {
                      ///
                      widget.value = !(widget.value == true);
                    });
                    widget.onChange?.call(widget.value);
                  }
                  widget.onClick?.call();
                }),
          ),
          widget.text != null
              ? Expanded(
                  child: GestureDetector(
                    onTap: () {
                      //

                      if (widget.isEnabled == true) {
                        ///
                        setState(() {
                          ///
                          widget.value = !(widget.value == true);
                        });
                        widget.onChange?.call(widget.value);
                      }
                      widget.onClick?.call();
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        widget.text ?? "",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Color getColor(Set<WidgetState> states, bool? value) {
    if (!(value == true)) {
      return Colors.white;
    }
    if (value == true) {
      return widget.color ?? AppColor.mainColor;
    }
    return Colors.white;
  }
}
