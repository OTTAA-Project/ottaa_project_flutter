import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ConnectedUsersList extends ConsumerStatefulWidget {
  const ConnectedUsersList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConnectedUsersList> createState() => _ConnectedUsersListState();
}

class _ConnectedUsersListState extends ConsumerState<ConnectedUsersList> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final user = ref.read(userNotifier);
    final provider = ref.watch(profileProvider);
    return ExpansionPanelList(
      dividerColor: colorScheme.background,
      expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 16),
      animationDuration: const Duration(milliseconds: 500),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          provider.expasionList[index] = !isExpanded; //TODO: Load the user data by the index
        });
      },
      children: provider.connectedUsersData.mapIndexed<ExpansionPanel>((int index, PatientUserModel item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ProfileCard(
              title: "Juan",
              leadingImage: CachedNetworkImageProvider(user!.settings.data.avatar.network!),
              subtitle: 'time will be here',
              onPressed: () {},
              actions: Text('actions'),
            );
          },
          body: Column(
            children: [
              Divider(
                height: 2,
                color: colorScheme.background,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Text(
                  'item.expandedValue',
                  style: textTheme.subtitle1,
                ),
              ),
            ],
          ),
          isExpanded: provider.expasionList[index],
        );
      }).toList(),
    );
  }
}
