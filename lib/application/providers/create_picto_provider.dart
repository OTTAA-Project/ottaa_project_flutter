import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/application/providers/view_board_provider.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/arsaac_data_model.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/create_picto_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:path/path.dart';

class CreatePictoProvider extends ChangeNotifier {
  final Map<int, int> dataSetMapId = {
    0: 0,
    1: 17,
    2: 84,
    3: 14,
    4: 13,
    5: 82,
    6: 83,
    7: 81,
    8: 66,
    9: 95,
    10: 75,
    11: 16,
    12: 67,
    13: 74,
    14: 86,
    15: 88,
    16: 15,
    17: 97,
    18: 76,
  };

  final Map<int, String> dataSetMapStrings = {
    0: 'All',
    17: 'ARASAAC',
    84: 'Gumeil',
    14: 'Jellow',
    13: 'mulberry',
    82: 'OCHA Humanitarian Icons',
    83: 'OpenMoji',
    81: 'Sclera Symbols',
    66: 'Srbija Simboli',
    95: 'Typical Bulgarian Symbols',
    75: 'Adam Urdu Symbols',
    16: 'Blissymbolics',
    67: 'Cma Gora',
    74: 'Hrvatski simboli za PK',
    86: 'Mulberry Plus',
    88: 'Otsmin Turkish',
    15: 'Tawasol',
    97: 'Typical Bulgarian Symbols SVG',
    76: 'DoeDY',
  };
  final CreatePictoRepository _createPictoServices;
  final GroupsRepository _groupsService;
  final LocalDatabaseRepository _localDatabaseRepository;
  final I18N _i18n;
  final PictogramsRepository _pictogramsService;
  final UserNotifier userState;
  final TTSProvider _ttsProvider;
  final ViewBoardProvider _viewBoardProvider;

  PageController controller = PageController(initialPage: 0);

  int currentIndex = 0;
  bool isImageSelected = false;
  String userID = '';
  int selectedBoardID = -1;
  bool isBoardFetched = false;
  List<ArsaacDataModel> searchedData = [];
  bool isArsaacSearched = false;
  bool isEditBoard = false;
  bool isUrl = false;
  List<String> daysToUsePicto = [];
  List<String> timeForPicto = [];
  String daysString = '';
  String timeString = '';
  String selectedPictoForEditId = '';
  String userIdByCareGiver = '';
  List<int> pictoInBoards = [];

  /// 6 is the default color for black and Miscellaneous
  int borderColor = 6;
  List<Group> boards = [];
  List<Picto> pictograms = [];
  List<Picto> filteredPictograms = [];
  XFile imageForPicto = XFile('');
  String imageUrlForPicto = '';
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController arsaacController = TextEditingController();

  CreatePictoProvider(this._createPictoServices, this._i18n, this._groupsService, this._pictogramsService, this.userState, this._localDatabaseRepository, this._ttsProvider, this._viewBoardProvider);

  Future<void> init({required String userId, bool isFromBoard = false}) async {
    userID = userId;
    await fetchUserGroups(userId: userId);
    await fetchUserPictos(userId: userId);
    if (isFromBoard) {
      controller = PageController(initialPage: 1);
      currentIndex = 1;
    } else {}
    controller.addListener(setIndex);
  }

  void setToSecondPage() async {
    controller.jumpToPage(1);
  }

  Future<bool> captureImageFromCamera() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (image != null) {
      imageForPicto = image;
      isImageSelected = true;
      return true;
    } else {
      //todo:handle the error if image is not picked
      return false;
    }
  }

  Future<bool> captureImageFromGallery() async {
    // todo: implement for web too
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageForPicto = image;
      isImageSelected = true;
      return true;
    } else {
      //todo:handle the error if image is not picked
      return false;
    }
  }

  void resetCreateBoardScreen() {
    isImageSelected = false;
    nameController.text = '';
    timeForPicto.clear();
    daysToUsePicto.clear();
  }

  Future<void> speakWord() async {
    await _ttsProvider.speak(nameController.text);
  }

  @override
  void dispose() {
    controller.removeListener(setIndex);
    controller.dispose();
    super.dispose();
  }

  setIndex() {
    final index = controller.page;
    currentIndex = (index ?? 0).toInt();
    notifyListeners();
  }

  void nextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void previousPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void goToPage(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> fetchUserGroups({required String userId}) async {
    final res = await _createPictoServices.fetchUserGroups(languageCode: _i18n.currentLocale.toString(), userId: userId);
    if (res.isEmpty) {
      final res = await _createPictoServices.fetchDefaultGroups(languageCode: _i18n.currentLocale.toString());
      boards = res;
    } else {
      boards = res;
    }
    isBoardFetched = true;
    notifyListeners();
  }

  Future<void> fetchUserPictos({required String userId}) async {
    pictograms = await _createPictoServices.fetchUserPictos(languageCode: _i18n.currentLocale.toString(), userId: userId);
    if (pictograms.isEmpty) {
      pictograms = await _createPictoServices.fetchDefaultPictos(languageCode: _i18n.currentLocale.toString());
    }
  }

  void notify() {
    notifyListeners();
  }

  Future<void> fetchPhotoFromGlobalSymbols({required String text}) async {
    isArsaacSearched = false;
    searchedData.clear();
    final res = await _createPictoServices.fetchPhotosFromGlobalSymbols(
      searchText: text,
      languageCode: _i18n.currentLocale.languageCode,
    );
    if (res.isRight) {
      searchedData = res.right;
    } else {
      searchedData = [];
    }
    isArsaacSearched = true;
    notifyListeners();
  }

  Future<void> saveAndUploadPictogram() async {
    final id = '$userID-${pictograms.length.toString()}';
    final url = await getImageUrl();
    Picto pict = Picto(
      id: id,
      type: borderColor,
      resource: AssetsImage(asset: '', network: url),
      tags: {
        "WEEKDAY": daysToUsePicto,
        "HORA": timeForPicto,
      },
      text: nameController.text,
    );
    pictograms.add(pict);
    _viewBoardProvider.pictograms.add(pict);
    _viewBoardProvider.filteredPictos.add(pict);
    _viewBoardProvider.boards[selectedBoardID].relations.add(
      GroupRelation(id: id, value: 0),
    );
    _viewBoardProvider.notify();
    boards[selectedBoardID].relations.add(
          GroupRelation(id: id, value: 0),
        );
    await _pictogramsService.uploadPictograms(pictograms, _i18n.currentLocale.toString(), userId: userID);
    await _groupsService.uploadGroups(boards, _i18n.currentLocale.toString(), 'type', userId: userID);

    if (userState.user!.type == UserType.user) {
      //todo: emir can you check this
      final newUser = userState.user!.patient;
      newUser.pictos[_i18n.currentLocale.toString()] = pictograms;
      newUser.groups[_i18n.currentLocale.toString()] = boards;
      await _localDatabaseRepository.setUser(newUser);
    }
  }

  Future<void> saveAndUploadGroup() async {
    final url = await getImageUrl(isPicto: false);
    Group group = Group(
      id: '$userID-${boards.length.toString()}',
      block: false,
      resource: AssetsImage(asset: '', network: url),
      text: nameController.text,
      relations: [],
      freq: 0,
    );
    boards.add(group);
    _viewBoardProvider.boards.add(group);
    _viewBoardProvider.notify();
    await _groupsService.uploadGroups(boards, 'type', _i18n.currentLocale.toString(), userId: userID);

    if (userState.user!.type == UserType.user) {
      final newUser = userState.user!.patient;
      newUser.groups[_i18n.currentLocale.toString()] = boards;
      userState.user!.patient.groups[_i18n.currentLocale.toString()] = boards;
      await _localDatabaseRepository.setUser(newUser);
    }
  }

  Future<void> saveChangesInPicto({required String id}) async {
    final url = await getImageUrl();
    int index = -1;
    final res = pictograms.firstWhere((element) {
      index++;
      return element.id == id;
    });
    pictograms[index].tags["WEEKDAY"] = daysToUsePicto;
    pictograms[index].tags["HORA"] = timeForPicto;
    Picto pict = Picto(
      id: id,
      type: borderColor,
      resource: AssetsImage(asset: pictograms[index].resource.asset, network: url),
      tags: pictograms[index].tags,
      text: nameController.text,
      freq: pictograms[index].freq,
    );

    pictograms[index] = pict;
    _viewBoardProvider.pictograms[index] = pict;
    _viewBoardProvider.notify();
    await _pictogramsService.uploadPictograms(pictograms, _i18n.currentLocale.toString(), userId: userID);

    if (userState.user!.type == UserType.user) {
      //todo: emir can you check this
      final newUser = userState.user!.patient;
      newUser.pictos[_i18n.currentLocale.toString()] = pictograms;
      await _localDatabaseRepository.setUser(newUser);
    }
  }

  Future<void> saveChangesInBoard() async {
    final url = await getImageUrl(isPicto: false);
    final oldBoard = boards[selectedBoardID];
    Group newBoard = Group(
      id: oldBoard.id,
      relations: oldBoard.relations,
      text: nameController.text,
      resource: AssetsImage(
        asset: oldBoard.resource.asset,
        network: url,
      ),
      freq: oldBoard.freq,
      block: oldBoard.block,
    );
    boards[selectedBoardID] = newBoard;
    _viewBoardProvider.boards[selectedBoardID] = newBoard;
    _viewBoardProvider.notify();
    await _groupsService.uploadGroups(boards, 'type', _i18n.currentLocale.toString(), userId: userID);

    if (userState.user!.type == UserType.user) {
      final newUser = userState.user!.patient;
      newUser.groups[_i18n.currentLocale.toString()] = boards;
      userState.user!.patient.groups[_i18n.currentLocale.toString()] = boards;
      await _localDatabaseRepository.setUser(newUser);
    }
    isEditBoard = false;
  }

  Future<String> getImageUrl({bool isPicto = true}) async {
    final userId = userIdByCareGiver.isEmpty ? userState.user!.id : userIdByCareGiver;

    String pictoPath = isPicto ? "images/$userId/pictos" : "images/$userId/boards";

    if (imageForPicto.path.isNotEmpty) {
      return await _createPictoServices.uploadOtherImages(
        imagePath: imageForPicto.path,
        directoryPath: pictoPath,
        name: imageForPicto.name,
        userId: userId,
      );
    } else {
      return imageUrlForPicto;
    }
    // Asim, please stop of repeat yourself :c
    // if (userIdByCareGiver.isEmpty) {
    //   if (imageUrlForPicto.isNotEmpty) {
    //     return imageUrlForPicto;
    //   } else {
    //     return _createPictoServices.uploadOtherImages(
    //       imagePath: imageForPicto.path,
    //       directoryPath: 'images/${userState.user!.id}/pictos',
    //       name: imageForPicto.name,
    //       userId: userState.user!.id,
    //     );
    //   }
    // } else {
    //   if (imageUrlForPicto.isNotEmpty) {
    //     return imageUrlForPicto;
    //   } else {
    //     return _createPictoServices.uploadOtherImages(
    //       imagePath: imageForPicto.path,
    //       directoryPath: 'images/$userIdByCareGiver/pictos',
    //       name: imageForPicto.name,
    //       userId: userIdByCareGiver,
    //     );
    //   }
    // }
  }

  /* Future<void> hideCurrentPicto({required String id, required int index}) async {
    int i = -1;
    final res = pictograms.firstWhere((element) {
      i++;
      return element.id == id;
    });
    pictograms[i].block = !pictograms[i].block;
    filteredPictograms[index].block = !filteredPictograms[index].block;
    notifyListeners();
  }*/

  Future<void> setForPictoEdit({required Picto pict}) async {
    daysToUsePicto.clear();
    timeForPicto.clear();
    selectedPictoForEditId = pict.id;
    borderColor = pict.type;
    imageUrlForPicto = pict.resource.network!;
    nameController.text = pict.text;
    isImageSelected = true;
    if (pict.tags.containsKey('WEEKDAY')) {
      daysToUsePicto = pict.tags['WEEKDAY']!;
    }
    if (pict.tags.containsKey('HORA')) {
      timeForPicto = pict.tags['HORA']!;
    }
    await searchBoard(id: pict.id);
    notifyListeners();
  }

  Future<void> setForBoardEdit({required int index}) async {
    selectedBoardID = index;
    final board = boards[index];
    isImageSelected = true;
    isUrl = true;
    isEditBoard = true;
    imageUrlForPicto = board.resource.network!;
    nameController.text = board.text;
  }

  Future<void> searchBoard({required String id}) async {
    pictoInBoards.clear();
    int boardIndex = -1;
    for (var board in boards) {
      boardIndex++;
      for (var relation in board.relations) {
        if (relation.id == id) {
          pictoInBoards.add(boardIndex);
        }
      }
    }
  }
}

final createPictoProvider = ChangeNotifierProvider<CreatePictoProvider>((ref) {
  final CreatePictoRepository createPictoServices = GetIt.I.get<CreatePictoRepository>();
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  final i18N = GetIt.I<I18N>();
  final tts = ref.watch(ttsProvider);
  final viewBoard = ref.watch(viewBoardProvider);
  final localDatabase = GetIt.I<LocalDatabaseRepository>();

  final userState = ref.watch(userProvider);
  return CreatePictoProvider(createPictoServices, i18N, groupService, pictogramService, userState, localDatabase, tts, viewBoard);
});
