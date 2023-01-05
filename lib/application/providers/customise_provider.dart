import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/core/models/groups_model.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';

class CustomiseProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;
  final GroupsRepository _groupsService;
  List<Pict> pictograms = [];
  List<Groups> groups = [];
  bool pictosFetched = false;
  String selectedGroup = '';

  CustomiseProvider(this._pictogramsService, this._groupsService);

  List<bool> selectedShortcuts = List.generate(7, (index) => true);

  Future<void> setShortcutsForUser(
      {required Map<String, dynamic> shortcuts, required String userId}) async {
    final map = {};
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
}

final customiseProvider = ChangeNotifierProvider<CustomiseProvider>((ref) {
  // final CustomiseRepository customiseService = GetIt.I.get<CustomiseRepository>();
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  return CustomiseProvider(pictogramService, groupService);
});
