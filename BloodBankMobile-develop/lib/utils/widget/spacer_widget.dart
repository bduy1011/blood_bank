import 'package:flutter/cupertino.dart';

import '../../app/theme/dimens.dart';

class VSpacing extends StatelessWidget {
  const VSpacing({Key? key, this.spacing}) : super(key: key);

  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: spacing ?? AppDimens.spacing7,
    );
  }
}

class HSpacing extends StatelessWidget {
  const HSpacing({Key? key, this.spacing}) : super(key: key);

  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: spacing ?? AppDimens.spacing5,
    );
  }
}
