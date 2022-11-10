import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/onboarding_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_project_flutter/presentation/common/ui/ottaa_wave.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/ottaa_textinput.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/simple_button.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';

class UserInfoStep extends ConsumerStatefulWidget {
  const UserInfoStep({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoStepState();
}

class _UserInfoStepState extends ConsumerState<UserInfoStep> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    final provider = ref.watch(onBoardingProvider);

    final formKey = provider.formKeys[0];

    final loading = ref.watch(loadingProvider);

    return SizedBox.fromSize(
      size: size,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: FadeInLeft(
              child: const OTTAAWave(
                color: kOTTAAOrangeNew,
                bgColor: kOTTAABackgroundNew,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: width * 0.05,
            child: JelloIn(
              child: Image.asset(
                AppImages.kPeople,
                width: width * 0.4,
              ),
            ),
          ),
          Positioned(
            right: width * 0.05,
            height: height,
            child: Align(
              alignment: Alignment.center,
              child: FadeInUp(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    width: width * 0.35,
                    height: height * 0.73,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage(AppImages.kLogoOttaa),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.05),
                            child: Text(
                              "check_if_the_info_is_correct_nif_not_change_it_as_you_wish_this_will_help_us_to_personalize_the_app_for_you".trl,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name".trl,
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: OTTAATextInput(
                                        controller: provider.nameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'please_enter_some_text'.trl;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                Row(
                                  children: [
                                    Text(
                                      "Gender".trl,
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: OTTAATextInput(
                                        controller: provider.genderController,
                                        enabled: true,
                                        isReadOnly: true,
                                        onTap: () async {
                                          final String? gender = await showDialog<String>(
                                            context: context,
                                            builder: (context) => AlertDialog(content: _dialogWidget()),
                                          );

                                          print(gender);
                                          if (gender != null) {
                                            provider.genderController.text = gender;
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'please_enter_some_text'.trl;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 50),
                                Row(
                                  children: [
                                    Text(
                                      "Date_of_birth".trl,
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: TextfieldDatePicker(
                                        cupertinoDatePickerBackgroundColor: Colors.white,
                                        cupertinoDatePickerMaximumDate: DateTime(2099),
                                        cupertinoDatePickerMaximumYear: 2099,
                                        cupertinoDatePickerMinimumYear: 1990,
                                        cupertinoDatePickerMinimumDate: DateTime(1990),
                                        cupertinoDateInitialDateTime: DateTime.now(),
                                        materialDatePickerFirstDate: DateTime(1990),
                                        materialDatePickerInitialDate: DateTime.now(),
                                        materialDatePickerLastDate: DateTime(2099),
                                        preferredDateFormat: DateFormat('dd-MM-' 'yyyy'),
                                        textfieldDatePickerController: provider.birthDateController,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        textCapitalization: TextCapitalization.sentences,
                                        cursorColor: Colors.black,
                                        decoration: const InputDecoration(
                                          focusColor: kOTTAAOrangeNew,
                                          fillColor: kOTTAAOrangeNew,
                                          isDense: true,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: kOTTAAOrangeNew),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'please_enter_some_text'.trl;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: width * 0.05,
            bottom: height * 0.05,
            child: SizedBox(
              width: width * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SimpleButton(
                    text: "Previous".trl,
                    // leading: Icons.chevron_left,
                    onTap: () async {
                      await provider.signOut();
                      if (mounted) context.go(AppRoutes.login);
                    },
                    backgroundColor: kQuantumGrey,
                    fontColor: Colors.white,
                  ),
                  SimpleButton(
                    text: "Next".trl,
                    // trailing: Icons.chevron_right,
                    onTap: () async {
                      final result = await provider.saveUserInformation();
                      if (result.isLeft) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.left)));
                        return;
                      }

                      provider.nextPage();
                    },
                    backgroundColor: kOTTAAOrangeNew,
                    fontColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: width * 0.045,
            left: height * 0.025,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.45,
                  child: FittedBox(
                    child: Text(
                      'hola_nnos_conozcamos_un_poco'.trl,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: width * 0.02,
                ),
                SizedBox(
                  width: height * 0.45,
                  child: Text(
                    'vamos_a_pedirte_cierta_informaci_n_para_nmejorar_tu_experiencia_con_ottaa'.trl,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          if (loading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _dialogWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _textWidget(text: 'Male'.trl),
          const Divider(),
          _textWidget(text: 'Female'.trl),
          const Divider(),
          _textWidget(text: 'Binary'.trl),
          const Divider(),
          _textWidget(text: 'Fluid'.trl),
          const Divider(),
          _textWidget(text: 'Other'.trl),
        ],
      ),
    );
  }

  Widget _textWidget({required String text}) {
    return ListTile(
      title: Text(text),
      onTap: () {
        Navigator.pop(context, text);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
