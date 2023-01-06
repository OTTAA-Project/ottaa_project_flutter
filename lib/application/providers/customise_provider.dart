import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/core/models/groups_model.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'package:ottaa_project_flutter/core/repositories/customise_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';

class CustomiseProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  final CustomiseRepository _customiseService;
  List<Pict> pictograms = [];
  List<Groups> groups = [];
  List<Pict> selectedGruposPicts = [];
  bool pictosFetched = false;
  int selectedGroup = 00;
  String selectedGroupName = '';
  String selectedGroupImage = '';
  bool selectedGroupStatus = false;

  CustomiseProvider(
    this._pictogramsService,
    this._groupsService,
    this._customiseService,
  );

  List<bool> selectedShortcuts = List.generate(7, (index) => true);

  Future<void> setGrupoData({required int index}) async {
    selectedGroup = index;
    selectedGroupImage =
        (groups[index].imagen.pictoEditado ?? groups[index].imagen.picto);
    //todo: set the language here too
    selectedGroupName = groups[index].texto.es;
    selectedGroupStatus = groups[index].blocked!;
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
      'share': selectedShortcuts[6]
    };
    await _customiseService.setShortcutsForUser(shortcuts: map, userId: userId);
  }

  Future<void> fetchDesiredPictos() async {
    selectedGruposPicts = [];
    for (int i = 0; i < groups[selectedGroup].relacion.length; i++) {
      for (var e in pictograms) {
        if (e.id == groups[selectedGroup].relacion[i].id) {
          selectedGruposPicts.add(e);
        }
      }
    }
  }

  Future<void> fetchPictograms() async {
    pictograms = await _pictogramsService.getAllPictograms();
    groups = await _groupsService.getAllGroups();
    pictosFetched = true;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<void> getDefaultGroups() async {
    final res = await _customiseService.fetchDefaultGroups(languageCode: 'en');
    print(res.length);
  }
}

final customiseProvider = ChangeNotifierProvider<CustomiseProvider>((ref) {
  final CustomiseRepository customiseService =
      GetIt.I.get<CustomiseRepository>();
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  return CustomiseProvider(pictogramService, groupService, customiseService);
});
