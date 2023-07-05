import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/create_picto_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

class ViewBoardProvider extends ChangeNotifier {
  final GroupsRepository _groupsService;
  final LocalDatabaseRepository _localDatabaseRepository;
  final I18N _i18n;
  final UserNotifier userState;
  final PictogramsRepository _pictogramsService;
  final CreatePictoRepository _createPictoServices;

  ViewBoardProvider(this._i18n, this._groupsService, this._pictogramsService, this._localDatabaseRepository, this._createPictoServices, this.userState);

  String userID = '';
  bool isUser = true;
  String selectedAlphabet = 'A';
  bool isSearching = false;
  bool isDataFetched = false;
  int selectedBoardID = -1;
  List<Group> boards = [];
  List<Picto> pictograms = [];
  List<Picto> filteredPictos = [];
  List<Picto> filteredSearchPictos = [];
  List<Group> filteredBoards = [];
  String selectedType = '';

  Future<void> init({required String userId}) async {
    await fetchUserGroups(userId: userId);
    await fetchUserPictos(userId: userId);
    await filterPictosForView();
    userID = userId;
    notifyListeners();
  }

  Future<void> fetchDesiredPictos() async {
    filteredPictos = [];
    for (int i = 0; i < boards[selectedBoardID].relations.length; i++) {
      for (var e in pictograms) {
        if (e.id == boards[selectedBoardID].relations[i].id) {
          filteredPictos.add(e);
        }
      }
    }
  }

  Future<void> filterPictosForView() async {
    filteredPictos.clear();
    for (var pict in pictograms) {
      if (pict.text.toUpperCase().startsWith(selectedAlphabet.toUpperCase())) {
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
    filteredSearchPictos.clear();
    filteredBoards.clear();
    for (var pict in pictograms) {
      if (pict.text.toUpperCase().contains(
            text.toUpperCase(),
          )) {
        filteredSearchPictos.add(pict);
      }
    }
    for (var board in boards) {
      if (board.text.toUpperCase().contains(text.toUpperCase())) {
        filteredBoards.add(board);
      }
    }
    isDataFetched = true;
    print(filteredSearchPictos.length);
    print(filteredBoards.length);
    notifyListeners();
  }

  Future<void> fetchUserGroups({required String userId}) async {
    final res = await _createPictoServices.fetchUserGroups(languageCode: _i18n.currentLocale.toString(), userId: userId);
    if (res.isEmpty) {
      final res = await _createPictoServices.fetchDefaultGroups(languageCode: _i18n.currentLocale.toString());
      boards = res;
    } else {
      boards = res;
    }
    notifyListeners();
  }

  Future<void> fetchUserPictos({required String userId}) async {
    final locale = _i18n.currentLocale.toString();
    pictograms = await _createPictoServices.fetchUserPictos(languageCode: locale, userId: userId);
    if (pictograms.isEmpty) {
      pictograms = await _createPictoServices.fetchDefaultPictos(languageCode: locale);
    }
  }

  void notify() {
    notifyListeners();
  }

  Future<void> uploadGroups() async {
    await _groupsService.uploadGroups(boards, 'type', _i18n.currentLocale.toString(), userId: userID);

    if (userState.user!.type == UserType.user) {
      final newUser = userState.user!.patient;
      newUser.groups[_i18n.currentLocale.toString()] = boards;
      userState.user!.patient.groups[_i18n.currentLocale.toString()] = boards;
      await _localDatabaseRepository.setUser(newUser);
    }
  }

  Future<void> uploadPictos() async {
    await _pictogramsService.uploadPictograms(pictograms, _i18n.currentLocale.toString(), userId: userID);

    if (userState.user!.type == UserType.user) {
      //todo: emir can you check this
      final newUser = userState.user!.patient;
      newUser.pictos[_i18n.currentLocale.toString()] = pictograms;
      newUser.groups[_i18n.currentLocale.toString()] = boards;
      await _localDatabaseRepository.setUser(newUser);
    }
  }

  Future<void> deleteBoard() async {
    boards.removeAt(selectedBoardID);
    await uploadGroups();
  }
}

final viewBoardProvider = ChangeNotifierProvider<ViewBoardProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  final i18N = GetIt.I<I18N>();
  final CreatePictoRepository createPictoServices = GetIt.I.get<CreatePictoRepository>();
  final localDatabase = GetIt.I<LocalDatabaseRepository>();
  final userState = ref.watch(userProvider);
  return ViewBoardProvider(i18N, groupService, pictogramService, localDatabase, createPictoServices, userState);
});
