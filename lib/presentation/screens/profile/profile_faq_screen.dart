import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/extensions/translate_string.dart';
import 'package:ottaa_project_flutter/presentation/common/widgets/responsive_widget.dart';
import 'package:ottaa_ui_kit/widgets.dart';

class ProfileFAQScreen extends StatefulWidget {
  const ProfileFAQScreen({Key? key}) : super(key: key);

  @override
  State<ProfileFAQScreen> createState() => _ProfileFAQScreenState();
}

class _ProfileFAQScreenState extends State<ProfileFAQScreen> {
  bool selected = false;
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return ResponsiveWidget(
      child: Scaffold(
        appBar: OTTAAAppBar(
          title: Text(
            "profile.faq.title".trl,
            style: textTheme.headline3,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: ExpansionPanelList(
              dividerColor: colorScheme.background,
              expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 16),
              animationDuration: const Duration(milliseconds: 500),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _data[index].isExpanded = !isExpanded;
                });
              },
              children: _data.map<ExpansionPanel>((Item item) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Text(
                            item.headerValue,
                            style: textTheme.subtitle2!
                                .copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        child: Text(
                          item.expandedValue,
                          style: textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'profile.faq.faq$index'.trl,
      expandedValue: 'profile.faq.faq${index}Description'.trl,
    );
  });
}
