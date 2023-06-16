import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/locator.dart';
import 'package:ottaa_project_flutter/application/providers/tts_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/application/service/create_picto_services.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/repositories/create_picto_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';

class CreatePictoProvider extends ChangeNotifier {
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

  /// 6 is the default color for black and Miscellaneous
  int borderColor = 6;
  List<Group> boards = [];
  late XFile imageForPicto;
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController nameController = TextEditingController();

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

//todo: arsaac images fetching and showing api
/*Future<List<SearchModel>> fetchPhotoFromGlobalSymbols({required String text}) async {
    final String languageFormat = lang == 'en' ? '639-3' : '639-1';
    final language = lang == 'en' ? 'eng' : 'es';
    url = 'https://globalsymbols.com/api/v1/labels/search?query=${text.replaceAll(' ', '+')}&language=$language&language_iso_format=$languageFormat&limit=60';
    var urlF = Uri.parse(url);
    http.Response response = await http.get(
      urlF,
      headers: {"Accept": "application/json"},
    );
    // print(url);
    if (response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      // print(data['symbols'][0]['name']);
      final res = (jsonDecode(response.body) as List).map((e) => SearchModel.fromJson(e)).toList();
      // SearchModel searchModel = SearchModel.fromJson(jsonDecode(response.body));
      // print(searchModel.itemCount);
      // print(searchModel.symbols[0].name);
      // print(jsonDecode(response.body));
      return res;
    } else {
      throw 'error';
    }
  }*/
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
