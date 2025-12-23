import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'custom_overlay_select.dart';

class SelectBoxWidget<T> extends StatefulWidget {
  const SelectBoxWidget({
    super.key,
    required this.height,
    required this.options,
    required this.currentValue,
    this.onChange,
    this.placeholder,
    this.validator,
    this.colorError,
    this.isSearch,
    this.hintSearch,
    this.isRequired = false,
    this.isDisabled = false,
  });
  final double height;
  final List<T> options;
  final T? currentValue;
  final String? placeholder;
  final Function(dynamic)? onChange;
  final String? Function(dynamic)? validator;
  final Color? colorError;
  final bool? isSearch;
  final String? hintSearch;
  final bool isRequired;
  final bool isDisabled;

  @override
  State<SelectBoxWidget> createState() => _SelectBoxWidgetState<T>();
}

class _SelectBoxWidgetState<T> extends State<SelectBoxWidget> {
  T? value;

  CustomOverlaySelect? overlaySelect;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    value = widget.currentValue;

    setState(() {});
  }

  void onChange(T v) {
    setState(() {
      value = v;
    });
    widget.onChange?.call(v);
    if (stateForm?.errorText?.isNotEmpty == true) {
      stateForm?.validate();
    }
  }

  @override
  void didUpdateWidget(covariant SelectBoxWidget oldWidget) {
    // TODO: implement didUpdateWidget
    oldWidget.currentValue != value;
    if (widget.options.length != oldWidget.options.length) {
      overlaySelect?.options.clear();
      overlaySelect?.options.addAll(widget.options);
    }
    setState(() {
      value = widget.currentValue;
    });
    super.didUpdateWidget(oldWidget);
  }

  FormFieldState<T>? stateForm;
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      overlaySelect = CustomOverlaySelect(
          context: context,
          onChange: (v) => onChange(v),
          options: widget.options,
          lineWidth: MediaQuery.sizeOf(context).width - 20,
          isSearch: widget.isSearch,
          hintTextSearch: widget.hintSearch);
    });
    return FormField<T>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: value,
      builder: (state) {
        stateForm = state;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSelect(state, context),
            (state.errorText ?? "").isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10),
                    child: Text(
                      state.errorText ?? '',
                      style: TextStyle(
                        color: (widget.colorError ?? Colors.red),
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        );
      },
      validator: widget.validator,
    );
  }

  Widget buildSelect(FormFieldState<T> state, BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (widget.options.isNotEmpty && !widget.isDisabled) {
          overlaySelect?.showOverlay(c: context);
        }
      },
      child: TextField(
        controller: TextEditingController(text: value != null ? '$value' : ''),
        readOnly: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                color: (state.errorText ?? "").isNotEmpty
                    ? (widget.colorError ?? Colors.red)
                    : Colors.black87),
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                color: (state.errorText ?? "").isNotEmpty
                    ? (widget.colorError ?? Colors.red)
                    : Colors.black87),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                color: (state.errorText ?? "").isNotEmpty
                    ? (widget.colorError ?? Colors.red)
                    : Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: (widget.colorError ?? Colors.red)),
          ),
          fillColor: widget.isDisabled ? Colors.grey[200] : Colors.white,
          filled: true,
          enabled: !widget.isDisabled,
          label: RichText(
            text: TextSpan(
              text: '${widget.placeholder}',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
              children: [
                if (widget.isRequired)
                  const TextSpan(
                    text: " *",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ),
        style: TextStyle(
          color: value != null ? Colors.black87 : Colors.black87,
          fontSize: 16,
          height: 24 / 16,
        ),
        onTap: () {
          if (widget.isDisabled != true) {
            FocusScope.of(context).requestFocus(FocusNode());
            if (widget.options.isNotEmpty && !widget.isDisabled) {
              overlaySelect?.showOverlay(c: context);
            }
          }
        },
        onChanged: (v) {},
        onSubmitted: (v) {},
      ),

      // Container(
      //   width: double.maxFinite,
      //   constraints: BoxConstraints(
      //     minHeight: widget.height,
      //   ),
      //   padding: const EdgeInsets.only(left: 10, right: 12),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(8),
      //     border: Border.all(
      //         color: (state.errorText ?? "").isNotEmpty
      //             ? (widget.colorError ?? Colors.red)
      //             : Colors.black54),
      //     color: widget.isDisabled ? Colors.grey[200] : Colors.white,
      //   ),
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     children: [
      //       Expanded(
      //         child: value != null
      //             ? Text(
      //                 '$value',
      //                 style: TextStyle(
      //                   color: value != null ? Colors.black87 : Colors.black87,
      //                   fontSize: 16,
      //                   height: 24 / 16,
      //                 ),
      //               )
      //             : RichText(
      //                 text: TextSpan(
      //                   text: '${widget.placeholder}',
      //                   style: const TextStyle(
      //                     color: Colors.black87,
      //                     fontSize: 14,
      //                   ),
      //                   children: [
      //                     if (widget.isRequired)
      //                       const TextSpan(
      //                         text: " *",
      //                         style: TextStyle(
      //                           color: Colors.red,
      //                           fontSize: 14,
      //                         ),
      //                       ),
      //                   ],
      //                 ),
      //               ),
      //       ),
      //       const SizedBox(
      //         width: 4,
      //       ),
      //       const Icon(Icons.arrow_drop_down, size: 24)
      //     ],
      //   ),
      // ),
    );
  }
}
