import 'package:blood_donation/app/app_util/enum.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/models/question.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:intl/intl.dart';

import '../controller/register_donate_blood_controller.dart';

class RegisterDonateBloodQuestion extends StatefulWidget {
  const RegisterDonateBloodQuestion({
    super.key,
    required this.state,
  });
  final RegisterDonateBloodController state;

  @override
  State<RegisterDonateBloodQuestion> createState() =>
      _RegisterDonateBloodQuestionState();
}

class _RegisterDonateBloodQuestionState
    extends State<RegisterDonateBloodQuestion> {
  Map<int, bool?> answers = {};
  TextEditingController noteController = TextEditingController();
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          const VSpacing(
            spacing: 20,
          ),
          widget.state.questions.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView(
                    children: widget.state.questions
                        .where((e) => widget
                                    .state.registerDonationBlood.gioiTinh ==
                                true
                            ? e.maleSkip != true
                            : true) // nếu là nam thì chỉ lấy những câu hỏi maleSkip != 1
                        .map((question) => _buildQuestionWidget(question))
                        .toList()
                      ..add(
                        buildAction(context),
                      ),
                  ),
                ),
        ],
      ),
    );
  }

  Column buildAction(BuildContext context) {
    return Column(
      children: [
        const VSpacing(
          spacing: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 229, 59, 59),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 15,
                ),
              ),
              onPressed: () {
                widget.state.updatePrevPage(2);
              },
              child: SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocale.prev.translate(context),
                      style: context.myTheme.textThemeT1.title
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 229, 59, 59),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              onPressed: () {
                widget.state.submitAnswers(
                    answers: answers, note: noteController.text, day: date);
              },
              child: SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocale.register.translate(context),
                      style: context.myTheme.textThemeT1.title
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const VSpacing(
          spacing: 50,
        ),
      ],
    );
  }

  Widget _buildQuestionWidget(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: html.Html(
            data: question.content,
          ),
        ),
        question.attribute == SurveyQuestionAttribute.InputDate.value &&
                answers[question.id ?? 0] == true
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: TextEditingController(
                      text: date != null
                          ? DateFormat("dd/MM/yyyy").format(date!)
                          : ""),
                  decoration: InputDecoration(
                    labelText: "Chọn ngày",
                    labelStyle: const TextStyle(color: Colors.black),
                    suffixIcon:
                        const Icon(Icons.calendar_today, color: Colors.red),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        date = pickedDate;
                      });
                    }
                  },
                ),
              )
            : const SizedBox(),
        question.attribute == SurveyQuestionAttribute.InputText.value &&
                answers[question.id ?? 0] == true
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: noteController,
                  decoration: InputDecoration(
                    labelText: "Nhập câu trả lời...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  minLines: 1,
                  maxLines: 4,
                ),
              )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: answers[question.id],
                      onChanged: (value) {
                        setState(() {
                          answers[question.id ?? 0] = value;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          answers[question.id ?? 0] = true;
                        });
                      },
                      child: Text(AppLocale.yes.translate(context),
                          style: context.myTheme.textThemeT1.textButton),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<bool>(
                      value: false,
                      groupValue: answers[question.id],
                      onChanged: (value) {
                        if (question.attribute ==
                            SurveyQuestionAttribute.InputDate.value) {
                          date = null;
                        }
                        if (question.attribute ==
                            SurveyQuestionAttribute.InputText.value) {
                          noteController.text = "";
                        }
                        setState(() {
                          answers[question.id ?? 0] = value;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        if (question.attribute ==
                            SurveyQuestionAttribute.InputDate.value) {
                          date = null;
                        }
                        if (question.attribute ==
                            SurveyQuestionAttribute.InputText.value) {
                          noteController.text = "";
                        }
                        setState(() {
                          answers[question.id ?? 0] = false;
                        });
                      },
                      child: Text(AppLocale.no.translate(context),
                          style: context.myTheme.textThemeT1.textButton),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
