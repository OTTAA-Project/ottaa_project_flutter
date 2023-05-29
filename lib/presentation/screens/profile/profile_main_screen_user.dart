import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/app_images.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/customise_data_type.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_photo_widget.dart';
import 'package:ottaa_ui_kit/theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileMainScreenUser extends ConsumerStatefulWidget {
  const ProfileMainScreenUser({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileMainScreenUser> createState() => _ProfileMainScreenUserState();
}

class _ProfileMainScreenUserState extends ConsumerState<ProfileMainScreenUser> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final _ttsProvider = ref.read(ttsProvider);
      await _ttsProvider.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider.select((value) => value.user));
    final textTheme = Theme.of(context).textTheme;
    return ResponsiveWidget(
      child: Scaffold(
        appBar: OTTAAAppBar(
          leading: GestureDetector(
            onTap: () => context.push(AppRoutes.userProfile),
            child: ProfilePhotoWidget(
              image: user?.settings.data.avatar.network ?? "",
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              'profile.hello'.trlf({'name': user!.settings.data.name}),
              style: textTheme.headline3,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'user.main.title'.trl,
                style: textTheme.button!.copyWith(
                  color: kPrimaryTextColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ActionCard(
                  title: '${'profile.tips.title2'.trl} / ${'global.pictogram'.trl}',
                  subtitle: 'user.main.subtitle2'.trl,
                  trailingImage: const AssetImage(AppImages.kProfileUserIcon1),
                  onPressed: () async {
                    final provider = ref.watch(customiseProvider);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );

                    /// checking if the user has its data or not
                    provider.dataExist = await provider.dataExistOrNot(userId: user.id);
                    context.pop();
                    provider.notify();
                    provider.type = provider.dataExist ? CustomiseDataType.user : CustomiseDataType.defaultCase;

                    context.push(AppRoutes.userCustomizeBoard);
                  },
                  focused: false,
                  imageSize: const Size(129, 96),
                ),
              ),
              ActionCard(
                title: 'profile.tips.title1'.trl,
                subtitle: 'user.main.subtitle1'.trl,
                trailingImage: const AssetImage(AppImages.kProfileUserIcon2),
                onPressed: () {},
                focused: false,
                imageSize: const Size(129, 96),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ActionCard(
                  title: 'global.settings'.trl,
                  subtitle: 'global.general'.trl,
                  trailingImage: const AssetImage(AppImages.kProfileIcon1),
                  onPressed: () {
                    context.push(AppRoutes.patientSettings);
                  },
                  focused: false,
                  imageSize: const Size(129, 96),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                onPressed: () {
                  ref.watch(patientNotifier.notifier).setUser(user.patient);
                  context.push(AppRoutes.userTalk);
                },
                text: '${'global.user_ottaa'.trl} ${user.settings.data.name}',
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
