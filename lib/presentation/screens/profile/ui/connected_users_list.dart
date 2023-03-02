import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/common/time_helper.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/customise_data_type.dart';
import 'package:ottaa_project_flutter/application/providers/user_settings_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/connected_user_widget.dart';

class ConnectedUsersList extends ConsumerStatefulWidget {
  const ConnectedUsersList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConnectedUsersList> createState() => _ConnectedUsersListState();
}

class _ConnectedUsersListState extends ConsumerState<ConnectedUsersList> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(profileProvider);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: provider.connectedUsersData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ConnectedUserWidget(
            title: provider.connectedUsersData[index].settings.data.name,
            image: provider
                .connectedUsersData[index].settings.data.avatar.network!,
            onPressed: () {
              provider.connectedUsersProfileDataExpanded[index] =
                  !provider.connectedUsersProfileDataExpanded[index];
              provider.notify();
            },
            actionTap: () {
              provider.connectedUsersProfileDataExpanded[index] =
                  !provider.connectedUsersProfileDataExpanded[index];
              provider.notify();
            },
            timeText: provider.connectedUsersData[index].settings.data
                .lastConnection.timezonedDate.timeString,
            show: provider.connectedUsersProfileDataExpanded[index],
            customiseTap: () async {
              final customisePro = ref.watch(customiseProvider);
              customisePro.type = CustomiseDataType.careGiver;
              customisePro.userId = provider.connectedUsersData[index].id;
              context.push(AppRoutes.customizedBoardScreen);
            },
            settingsTap: () {
              ref.read(patientNotifier.notifier).setUser(provider.connectedUsersData[index].patient);
              context.push(AppRoutes.settingScreenUser);
            },
          ),
        );
      },
    );
  }
}
