import 'package:flutter/material.dart' hide Shortcuts;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
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
  List<Picto> pictograms = [];
  List<Group> groups = [];
  List<Picto> selectedGruposPicts = [];
  bool pictosFetched = false;
  int selectedGroup = 00;
  String selectedGroupName = '';
  String selectedGroupImage = '';
  bool selectedGroupStatus = false;
  Map<int, int> pictosMap = {};

  CustomiseProvider(
    this._pictogramsService,
    this._groupsService,
    this._customiseService,
  );

  List<bool> selectedShortcuts = List.generate(7, (index) => true);

  Future<void> setGrupoData({required int index}) async {
    selectedGroup = index;
    selectedGroupImage = (groups[index].resource.network ?? groups[index].resource.asset)!; //TODO: Check this with asimA
    //todo: set the language here too
    selectedGroupName = groups[index].text["es"]!; //TODO: Change it to user language
    selectedGroupStatus = groups[index].block;
    fetchDesiredPictos();
    notifyListeners();
  }

  Future<void> setShortcutsForUser({required String userId}) async {
    final map = {
      'favourite': selectedShortcuts[0],
      'history': selectedShortcuts[1],
      'camera': selectedShortcuts[2],
      'random': selectedShortcuts[3],
      'yes': selectedShortcuts[4],
      'no': selectedShortcuts[5],
      'share': selectedShortcuts[6],
    };
    await _customiseService.setShortcutsForUser(
      shortcuts: Shortcuts(
        favs: selectedShortcuts[0],
        gallery: selectedShortcuts[1],
        games: selectedShortcuts[2],
        share: selectedShortcuts[3],
        shuffle: selectedShortcuts[4],
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
    groups = await _groupsService.getAllGroups();
    pictosFetched = true;
    notifyListeners();
    pictograms = await _pictogramsService.getAllPictograms();
    await createMapForPictos();
  }

  Future<void> uploadData({required String userId}) async {
    //todo: change the languages
    await _pictogramsService.uploadPictograms(pictograms, 'es');
    await _groupsService.uploadGroups(groups, 'type', 'es');
    await setShortcutsForUser(userId: userId);
  }

  void notify() {
    notifyListeners();
  }

  Future<void> getDefaultGroups() async {
    final res = await _customiseService.fetchDefaultGroups(languageCode: 'en');
    print(res.length);
  }

  Future<void> createMapForPictos() async {
    int i = 0;
    for (var element in pictograms) {
      pictosMap[element.id] = i;
    }
  }

  void block({required int index}) async {
    selectedGruposPicts[index].block = !selectedGruposPicts[index].block;

    pictograms[pictosMap[selectedGruposPicts[index].id]!].block = !pictograms[pictosMap[selectedGruposPicts[index].id]!].block;
    notifyListeners();
  }
}

final customiseProvider = ChangeNotifierProvider<CustomiseProvider>((ref) {
  final CustomiseRepository customiseService = GetIt.I.get<CustomiseRepository>();
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  return CustomiseProvider(pictogramService, groupService, customiseService);
});
