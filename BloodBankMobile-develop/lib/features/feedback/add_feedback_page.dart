import 'package:blood_donation/app/theme/colors.dart';
import 'package:blood_donation/base/base_view/base_view_stateful.dart';
import 'package:blood_donation/features/feedback/controller/feedback_controller.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddFeedbackSupportPage extends StatefulWidget {
  const AddFeedbackSupportPage({super.key});

  @override
  _AddFeedbackSupportPageState createState() => _AddFeedbackSupportPageState();
}

class _AddFeedbackSupportPageState
    extends BaseViewStateful<AddFeedbackSupportPage, FeedbackController> {
  @override
  FeedbackController dependencyController() {
    // TODO: implement dependencyController
    return FeedbackController();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final feedback = _feedbackController.text.trim();

      // Here, you can handle the submitted data, like sending it to your server.
      // print('Name: $name');
      // print('Email: $email');
      // print('Feedback: $feedback');

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Thank you for your feedback!')),
      // );
      controller.createGopY(name, email, feedback);
      // Clear the fields after submission
      // _nameController.clear();
      // _emailController.clear();
      // _feedbackController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFB22C2D),
            Color.fromARGB(255, 240, 88, 88),
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text(
            "Góp ý/ phản hồi",
            style:
                context.myTheme.textThemeT1.title.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          surfaceTintColor: context.myTheme.colorScheme.scaffoldBackgroundColor,
        ),
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                    'Chúng tôi đánh giá cao phản hồi của bạn. Vui lòng điền vào mẫu dưới đây.',
                    style: context.myTheme.textThemeT1.body
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Họ tên',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập họ tên';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _feedbackController,
                    decoration: const InputDecoration(
                      labelText: 'Nội dung góp ý/ phản hồi',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập nội dung góp ý/ phản hồi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.mainColor,
                    ),
                    onPressed: _submitFeedback,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ic_paper-plane.svg",
                          width: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 45,
                          child: const Text(
                            'Gửi',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
