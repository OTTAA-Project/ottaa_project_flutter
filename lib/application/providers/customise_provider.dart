import 'package:flutter/material.dart' hide Shortcuts;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/enums/customise_data_type.dart';
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
  bool groupsFetched = false;
  int selectedGroup = 00;
  String selectedGroupName = '';
  String selectedGroupImage = '';
  bool selectedGroupStatus = false;
  Map<String, int> pictosMap = {};
  CustomiseDataType type = CustomiseDataType.defaultCase;

  // userId for other use cases
  String userId = '';

  CustomiseProvider(
    this._pictogramsService,
    this._groupsService,
    this._customiseService,
    this._i18n,
  );

  List<bool> selectedShortcuts = List.generate(7, (index) => true);

  Future<void> setGroupData({required int index}) async {
    selectedGroup = index;
    selectedGroupImage = (groups[index].resource.network ?? groups[index].resource.asset); //TODO: Check this with asim
    selectedGroupName = groups[index].text;
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

  Future<void> inIt({String? userId}) async {
    switch (type) {
      case CustomiseDataType.user:
        await fetchUserCaseValues(userId: userId!);
        break;
      case CustomiseDataType.careGiver:
        await fetchUserCaseValues(userId: userId!);
        break;
      case CustomiseDataType.defaultCase:
      default:
        await fetchDefaultCaseValues();
        break;
    }
  }

  Future<void> fetchDefaultCaseValues() async {
    await getDefaultGroups();
    groupsFetched = true;
    notifyListeners();
    await getDefaultPictos();
    await createMapForPictos();
  }

  Future<void> fetchUserCaseValues({required String userId}) async {
    await fetchShortcutsForUser(userId: userId);
    groupsFetched = true;

    await fetchUserGroups(userId: userId);

    notifyListeners(); //OSDIFHUIDSFGYUIASDGBUYOF UIOSDYFSDIFSD

    await fetchUserPictos(userId: userId);
    await createMapForPictos();
  }

  Future<void> uploadData({required String userId}) async {
    final locale = _i18n.locale;

    final languageCode = locale.toString();

    await _pictogramsService.uploadPictograms(pictograms, languageCode, userId: userId);
    await _groupsService.uploadGroups(groups, 'type', languageCode, userId: userId);
    await setShortcutsForUser(userId: userId);
  }

  void notify() {
    notifyListeners();
  }

  Future<void> getDefaultGroups() async {
    final locale = _i18n.locale;

    final languageCode = locale.toString();

    final res = await _customiseService.fetchDefaultGroups(languageCode: languageCode);
    groups = res;
  }

  Future<void> getDefaultPictos() async {
    final locale = _i18n.locale;

    final languageCode = locale.toString();
    pictograms = await _customiseService.fetchDefaultPictos(languageCode: languageCode);
  }

  Future<void> createMapForPictos() async {
    int i = 0;
    for (var element in pictograms) {
      pictosMap[element.id.toString()] = i;
    }

    print(pictosMap);
  }

  void block({required int index}) async {
    selectedGruposPicts[index].block = !selectedGruposPicts[index].block;
    pictograms[pictosMap[selectedGruposPicts[index].id]!].block = !pictograms[pictosMap[selectedGruposPicts[index].id]!].block;
    notifyListeners();
  }

  Future<void> fetchShortcutsForUser({required String userId}) async {
    final res = await _customiseService.fetchShortcutsForUser(userId: userId);
    selectedShortcuts[0] = res.favs;
    selectedShortcuts[1] = res.history;
    selectedShortcuts[2] = res.camera;
    selectedShortcuts[3] = res.games;
    selectedShortcuts[4] = res.yes;
    selectedShortcuts[5] = res.no;
    selectedShortcuts[6] = res.share;
    print(res.toString());
    notifyListeners();
  }

  Future<void> fetchUserGroups({required String userId}) async {
    final locale = _i18n.locale;

    final languageCode = "${locale.languageCode}_${locale.countryCode}";
    final res = await _customiseService.fetchUserGroups(languageCode: languageCode, userId: userId);
    groups = res;
    notify();
  }

  Future<void> fetchUserPictos({required String userId}) async {
    final locale = _i18n.locale;

    final languageCode = "${locale.languageCode}_${locale.countryCode}";
    pictograms = await _customiseService.fetchDefaultPictos(languageCode: languageCode);
  }
}

final customiseProvider = ChangeNotifierProvider<CustomiseProvider>((ref) {
  final CustomiseRepository customiseService = GetIt.I.get<CustomiseRepository>();
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  final i18N = GetIt.I<I18N>();
  return CustomiseProvider(pictogramService, groupService, customiseService, i18N);
});
