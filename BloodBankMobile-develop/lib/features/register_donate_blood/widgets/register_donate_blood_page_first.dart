// import 'package:blood_donation/app/theme/colors.dart';
// import 'package:blood_donation/core/localization/app_locale.dart';
// import 'package:blood_donation/utils/extension/context_ext.dart';
// import 'package:blood_donation/utils/widget/spacer_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// import '../../../utils/app_utils.dart';
// import '../controller/register_donate_blood_controller.dart';

// class RegisterDonateBloodPageFirst extends StatelessWidget {
//   const RegisterDonateBloodPageFirst({super.key, required this.state});
//   final RegisterDonateBloodController state;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Positioned(
//               top: -470,
//               child: Container(
//                 height: 700,
//                 width: 700,
//                 decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [
//                         AppColor.mainColor,
//                         Color.fromARGB(255, 222, 45, 45),
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomCenter,
//                     ),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                           color: AppColor.mainColor.withOpacity(0.9),
//                           blurRadius: 20,
//                           blurStyle: BlurStyle.outer)
//                     ]),
//               )),
//           Positioned(
//               top: -130,
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(100)),
//                 ),
//               )),
//           Positioned(
//             top: 10,
//             child: SizedBox(
//               width: 270,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Icon(
//                     Icons.chevron_left,
//                     size: 30,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     '1/4',
//                     style: context.myTheme.textThemeT1.body
//                         .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const Icon(Icons.chevron_right,
//                       size: 30, color: Colors.white),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               top: 150,
//               child: Container(
//                 height: 400,
//                 width: 270,
//                 padding: const EdgeInsets.all(30),
//                 decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: const BorderRadius.all(Radius.circular(20)),
//                     color: Colors.white),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Bạn có từng hiến máu trước đây chưa?',
//                       style: context.myTheme.textThemeT1.body
//                           .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
//                       softWrap: true,
//                       overflow: TextOverflow.clip,
//                     ),
//                     const VSpacing(
//                       spacing: 20,
//                     ),
//                     Obx(
//                       () => GestureDetector(
//                         onTap: () {
//                           state.usetoRegister.value = true;
//                         },
//                         child: Container(
//                           width: 150,
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 30),
//                           decoration: BoxDecoration(
//                             color: state.usetoRegister.value == true
//                                 ? AppColor.mainColor
//                                 : Colors.transparent,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(20)),
//                             border:
//                                 Border.all(color: AppColor.mainColor, width: 2),
//                           ),
//                           child: Text('Có',
//                               style: context.myTheme.textThemeT1.title.copyWith(
//                                 color: state.usetoRegister.value == true
//                                     ? Colors.white
//                                     : null,
//                               )),
//                         ),
//                       ),
//                     ),
//                     const VSpacing(
//                       spacing: 20,
//                     ),
//                     Obx(
//                       () => GestureDetector(
//                         onTap: () {
//                           state.usetoRegister.value = false;
//                         },
//                         child: Container(
//                           width: 150,
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 30),
//                           decoration: BoxDecoration(
//                               color: state.usetoRegister.value == false
//                                   ? AppColor.mainColor
//                                   : Colors.transparent,
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(20)),
//                               border: Border.all(
//                                   color: AppColor.mainColor, width: 2)),
//                           child: Text(
//                             'Không',
//                             style: context.myTheme.textThemeT1.title.copyWith(
//                               color: state.usetoRegister.value == false
//                                   ? Colors.white
//                                   : null,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     InkWell(
//                       onTap: () {
//                         if (state.usetoRegister.value != null) {
//                           state.updateNextPage(2);
//                         } else {
//                           AppUtils.instance.showMessage(
//                               "Chọn câu trả lời để tiếp tục!",
//                               context: context);
//                         }
//                       },
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             AppLocale.next.translate(context),
//                             style: context.myTheme.textThemeT1.title,
//                           ),
//                           const Icon(Icons.arrow_right_alt_outlined)
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )),
//           // Positioned(
//           //   bottom: 50,
//           //   child: ElevatedButton(
//           //       onPressed: () {},
//           //       style: ElevatedButton.styleFrom(
//           //         backgroundColor: const Color.fromARGB(255, 229, 59, 59),
//           //         shape: RoundedRectangleBorder(
//           //           borderRadius: BorderRadius.circular(50),
//           //         ),
//           //         padding: const EdgeInsets.symmetric(
//           //           vertical: 15,
//           //           horizontal: 40,
//           //         ),
//           //       ),
//           //       child: Text(
//           //         AppLocale.register.tr(context),
//           //         style: context.myTheme.textThemeT1.title
//           //             .copyWith(color: Colors.white),
//           //       )),
//           // )
//         ],
//       ),
//     );
//   }
// }
