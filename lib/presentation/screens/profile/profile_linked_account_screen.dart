import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/application/providers/profile_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileLinkedAccountScreen extends ConsumerStatefulWidget {
  const ProfileLinkedAccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileLinkedAccountScreen();
}

class _ProfileLinkedAccountScreen
    extends ConsumerState<ProfileLinkedAccountScreen> {
  @override
  void initState() {
    final provider = ref.read(profileProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await provider.fetchConnectedUsersData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final provider = ref.watch(profileProvider);
    final user = ref.read(userProvider.select((value) => value.user));
    print(provider.dataFetched);
    return ResponsiveWidget(
      child: Scaffold(
        appBar: OTTAAAppBar(
          title: Text(
            "profile.linked_accounts".trl,
            style: textTheme.displaySmall,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(
                  height: 36,
                ),
                //todo: emir need your help
                provider.dataFetched
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: provider.connectedUsersData.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ProfileCard(
                              title: provider
                                  .connectedUsersData[index].settings.data.name,
                              subtitle: "profile.user".trl,
                              actions: GestureDetector(
                                onTap: () async {
                                  final bool? cancel =
                                      await BasicBottomSheet.show(
                                    context,
                                    okButtonEnabled: true,
                                    title: "profile.unlink_account".trlf({
                                      "name": provider.connectedUsersData[index]
                                          .settings.data.name
                                    }),
                                    okButtonText: "global.yes".trl,
                                    cancelButtonText: "global.cancel".trl,
                                    cancelButtonEnabled: true,
                                  );
                                  if (cancel != null && cancel) {
                                    await provider.removeCurrentUser(
                                      userId:
                                          provider.connectedUsersData[index].id,
                                      careGiverId: user!.id,
                                    );
                                  }
                                },
                                child: Text(
                                  'profile.unlink'.trl,
                                  style: textTheme.titleMedium!
                                      .copyWith(color: colorScheme.primary),
                                ),
                              ),
                              leadingImage: NetworkImage(
                                provider.connectedUsersData[index].settings.data
                                    .avatar.network!,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
