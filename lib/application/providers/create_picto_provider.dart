import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/locator.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/application/service/create_picto_services.dart';
import 'package:ottaa_project_flutter/core/models/arsaac_data_model.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/repositories/create_picto_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';

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

  final PageController controller = PageController(initialPage: 0);

  int currentIndex = 0;
  bool isImageSelected = false;
  String selectedBoardName = '';
  bool isBoardFetched = false;
  List<ArsaacDataModel> searchedData = [];
  bool isArsaacSearched = false;
  List<String> daysToUsePicto = [];
  String timeForPicto = '';

  /// 6 is the default color for black and Miscellaneous
  int borderColor = 6;
  List<Group> boards = [];
  late XFile imageForPicto;
  String imageUrlForPicto = '';
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController arsaacController = TextEditingController();

  CreatePictoProvider(
    this._createPictoServices,
    this._i18n,
    this._groupsService,
    this._pictogramsService,
    this.userState,
    this._localDatabaseRepository,
    this._ttsProvider,
  ) {
    controller.addListener(setIndex);
  }

  Future<void> init({required String userId}) async {
    await fetchUserGroups(userId: userId);
  }

  Future<bool> captureImageFromCamera() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
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
    boards = res;
    isBoardFetched = true;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<void> fetchPhotoFromGlobalSymbols({required String text}) async {
    isArsaacSearched = false;
    final res = await _createPictoServices.fetchPhotosFromGlobalSymbols(
      searchText: 'hola',
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
}

final createPictoProvider = ChangeNotifierProvider<CreatePictoProvider>((ref) {
  final CreatePictoRepository createPictoServices = GetIt.I.get<CreatePictoRepository>();
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  final i18N = GetIt.I<I18N>();
  final tts = ref.watch(ttsProvider);
  final localDatabase = GetIt.I<LocalDatabaseRepository>();

  final userState = ref.watch(userProvider);
  return CreatePictoProvider(createPictoServices, i18N, groupService, pictogramService, userState, localDatabase, tts);
});
