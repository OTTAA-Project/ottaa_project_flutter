import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/create_picto_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

class ViewBoardProvider extends ChangeNotifier {
  final GroupsRepository _groupsService;
  final LocalDatabaseRepository _localDatabaseRepository;
  final I18N _i18n;
  final PictogramsRepository _pictogramsService;
  final CreatePictoRepository _createPictoServices;

  ViewBoardProvider(this._i18n, this._groupsService, this._pictogramsService, this._localDatabaseRepository, this._createPictoServices);

  String userID = '';
  bool isUser = true;
  String selectedAlphabet = 'A';
  bool isSearching = false;
  bool isDataFetched = false;
  int selectedBoardID = -1;
  List<Group> boards = [];
  List<Picto> pictograms = [];
  List<Picto> selectedBoardPicts = [];
  List<Picto> filteredPictos = [];
  List<Group> filteredBoards = [];

  Future<void> init({required String userId}) async {
    await fetchUserGroups(userId: userId);
    await fetchUserPictos(userId: userId);
    await filterPictosForView();
  }

  Future<void> fetchDesiredPictos() async {
    selectedBoardPicts = [];
    for (int i = 0; i < boards[selectedBoardID].relations.length; i++) {
      for (var e in pictograms) {
        if (e.id == boards[selectedBoardID].relations[i].id) {
          selectedBoardPicts.add(e);
        }
      }
    }
  }

  Future<void> filterPictosForView() async {
    print(pictograms.length);
    filteredPictos.clear();
    for (var pict in pictograms) {
      if (pict.text.toUpperCase().startsWith(
            selectedAlphabet.toUpperCase(),
          )) {
        filteredPictos.add(pict);
      }
    }
    notifyListeners();
  }

  Future<void> hideCurrentPicto({required String id, required int index}) async {
    int i = -1;
    final res = pictograms.firstWhere((element) {
      i++;
      return element.id == id;
    });
    pictograms[i].block = !pictograms[i].block;
    filteredPictos[index].block = filteredPictos[index].block;
    notifyListeners();
  }

  Future<void> searchForMatchingData({required String text}) async {
    isSearching = true;
    isDataFetched = false;
    filteredPictos.clear();
    filteredBoards.clear();
    for (var pict in pictograms) {
      if (pict.text.toUpperCase().contains(
            text.toUpperCase(),
          )) {
        filteredPictos.add(pict);
      }
    }
    for (var board in boards) {
      if (board.text.toUpperCase().contains(text.toUpperCase())) {
        filteredBoards.add(board);
      }
    }
    isDataFetched = true;
    print(filteredPictos.length);
    print(filteredBoards.length);
    notifyListeners();
  }

  Future<void> fetchUserGroups({required String userId}) async {
    final res = await _createPictoServices.fetchUserGroups(languageCode: _i18n.currentLocale.toString(), userId: userId);
    boards = res;
    notifyListeners();
  }

  Future<void> fetchUserPictos({required String userId}) async {
    final locale = _i18n.currentLocale;
    pictograms = await _createPictoServices.fetchUserPictos(languageCode: _i18n.currentLocale.toString(), userId: userId);
  }

  void notify() {
    notifyListeners();
  }
}

final viewBoardProvider = ChangeNotifierProvider<ViewBoardProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  final i18N = GetIt.I<I18N>();
  final CreatePictoRepository createPictoServices = GetIt.I.get<CreatePictoRepository>();
  final localDatabase = GetIt.I<LocalDatabaseRepository>();
  return ViewBoardProvider(i18N, groupService, pictogramService, localDatabase, createPictoServices);
});
