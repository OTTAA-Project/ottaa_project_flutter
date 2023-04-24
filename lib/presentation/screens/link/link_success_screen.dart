import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/application/providers/link_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/enums/customise_data_type.dart';
import 'package:ottaa_ui_kit/theme.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class LinkSuccessScreen extends ConsumerStatefulWidget {
  const LinkSuccessScreen({super.key});

  @override
  ConsumerState<LinkSuccessScreen> createState() => _LinkSuccessScreenState();
}

class _LinkSuccessScreenState extends ConsumerState<LinkSuccessScreen> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final provider = ref.watch(linkProvider);

    initializeDateFormatting(provider.user!.settings.language.language);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text("profile.link.success.title".trl, style: textTheme.headline2),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
                width: 312,
                child: ProfileCard(
                  title: provider.user!.settings.data.name,
                  subtitle: "profile.link.success.lastTime".trlf({
                    "date": DateFormat("dd/MM/yy HH:mm",
                            provider.user!.settings.language.language)
                        .format(provider.user!.settings.data.lastConnection)
                  }),
                  //TODO: Re do this u.u
                  leadingImage: CachedNetworkImageProvider(
                      provider.user!.settings.data.avatar.network!),
                  actions: IconButton(
                    onPressed: () {},
                    color: kBlackColor,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: kBlackColor,
                    ),
                    style: IconButton.styleFrom(
                      foregroundColor: kBlackColor,
                    ),
                    splashRadius: 10,
                  ),
                )),
          ),
          const Spacer(),
          SizedBox(
            width: size.width * 0.8,
            child: PrimaryButton(
              onPressed: () {
                final provider = ref.watch(customiseProvider);
                provider.type = CustomiseDataType.defaultCase;
                context.push(AppRoutes.userCustomize);
              },
              text: "global.continue".trl,
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
