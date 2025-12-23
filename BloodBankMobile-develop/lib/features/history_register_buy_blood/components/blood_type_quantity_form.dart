import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

import '../../../models/blood_type.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../../home/components/blood_type_widget.dart';

class BloodTypeQuantityForm extends StatelessWidget {
  const BloodTypeQuantityForm({super.key, required this.types});
  final List<BloodType> types;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: types.length,
      itemBuilder: (context, index) {
        final item = types[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BloodTypeWidget(isActive: () => false, title: item.name ?? ""),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove,
                      color: context.myTheme.colorScheme.primary,
                    )),
                SizedBox(
                    width: 100,
                    child: TextFormField(
                      initialValue: "0",
                      textAlign: TextAlign.center,
                      style: context.myTheme.textThemeT1.title,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: context.myTheme.colorScheme.primary,
                    )),
              ],
            )
          ],
        );
      },
      separatorBuilder: (context, index) => const VSpacing(),
    );
  }
}
