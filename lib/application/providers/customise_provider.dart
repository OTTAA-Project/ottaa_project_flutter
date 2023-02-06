import 'package:flutter/material.dart' hide Shortcuts;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/repositories/customise_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';

class CustomiseProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final CustomiseRepository _customiseService;
  final I18N _i18n;
  List<Picto> pictograms = [];
  List<Group> groups = [];
  List<Picto> selectedGruposPicts = [];
  bool pictosFetched = false;
  int selectedGroup = 00;
  String selectedGroupName = '';
  String selectedGroupImage = '';
  bool selectedGroupStatus = false;
  Map<String, int> pictosMap = {};

  CustomiseProvider(
    this._pictogramsService,
    this._groupsService,
    this._customiseService,
    this._i18n,
  );

  List<bool> selectedShortcuts = List.generate(7, (index) => true);

  Future<void> setGroupData({required int index}) async {
    selectedGroup = index;
    selectedGroupImage = (groups[index].resource.network ??
        groups[index].resource.asset); //TODO: Check this with asimA
    //todo: set the language here too
    selectedGroupName = groups[index].text; //TODO: Change it to user language
    selectedGroupStatus = groups[index].block;
    fetchDesiredPictos();
    notifyListeners();
  }

  Future<void> setShortcutsForUser({required String userId}) async {
    await _customiseService.setShortcutsForUser(
      shortcuts: Shortcuts(
        favs: selectedShortcuts[0],
        history: selectedShortcuts[1],
        camera: selectedShortcuts[2],
        games: selectedShortcuts[3],
        yes: selectedShortcuts[4],
        no: selectedShortcuts[5],
        share: selectedShortcuts[6],
      ),
      userId: userId,
    );
  }

  Future<void> fetchDesiredPictos() async {
    selectedGruposPicts = [];
    for (int i = 0; i < groups[selectedGroup].relations.length; i++) {
      for (var e in pictograms) {
        if (e.id == groups[selectedGroup].relations[i].id) {
          selectedGruposPicts.add(e);
        }
      }
    }
  }

  Future<void> fetchData() async {
    await getDefaultGroups();
    pictosFetched = true;
    notifyListeners();
    final locale = _i18n.locale;

    final languageCode = "${locale.languageCode}-${locale.countryCode}";
    pictograms =
        await _customiseService.fetchDefaultPictos(languageCode: languageCode);
    await createMapForPictos();
  }

  Future<void> uploadData({required String userId}) async {
    final locale = _i18n.locale;

    final languageCode = "${locale.languageCode}_${locale.countryCode}";

    await _pictogramsService.uploadPictograms(pictograms, languageCode,
        userId: userId);
    await _groupsService.uploadGroups(groups, 'type', languageCode,
        userId: userId);
    await setShortcutsForUser(userId: userId);
  }

  void notify() {
    notifyListeners();
  }

  Future<void> getDefaultGroups() async {
    final locale = _i18n.locale;

    final languageCode = "${locale.languageCode}-${locale.countryCode}";
    final res =
        await _customiseService.fetchDefaultGroups(languageCode: languageCode);
    print(res.length);
    groups = res;
  }

  Future<void> createMapForPictos() async {
    int i = 0;
    for (var element in pictograms) {
      pictosMap[element.id.toString()] = i;
    }
  }

  void block({required int index}) async {
    selectedGruposPicts[index].block = !selectedGruposPicts[index].block;

    pictograms[pictosMap[selectedGruposPicts[index].id]!].block =
        !pictograms[pictosMap[selectedGruposPicts[index].id]!].block;
    notifyListeners();
  }
}

final customiseProvider = ChangeNotifierProvider<CustomiseProvider>((ref) {
  final CustomiseRepository customiseService =
      GetIt.I.get<CustomiseRepository>();
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  final i18N = GetIt.I<I18N>();
  return CustomiseProvider(
      pictogramService, groupService, customiseService, i18N);
});
