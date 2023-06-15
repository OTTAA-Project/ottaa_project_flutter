import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
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

  final PageController controller = PageController(initialPage: 0);

  int currentIndex = 0;
  bool isImageSelected = false;
  String selectedBoardName = '';
  bool isBoardFetched = false;
  List<Group> boards = [];

  CreatePictoProvider(this._createPictoServices, this._i18n, this._groupsService, this._pictogramsService, this.userState, this._localDatabaseRepository) {
    controller.addListener(setIndex);
  }

  Future<void> init({required String userId}) async {
    await fetchUserGroups(userId: userId);
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
}

final createPictoProvider = ChangeNotifierProvider<CreatePictoProvider>((ref) {
  final CreatePictoRepository createPictoServices = GetIt.I.get<CreatePictoRepository>();
  final pictogramService = GetIt.I<PictogramsRepository>();
  final groupService = GetIt.I<GroupsRepository>();
  final i18N = GetIt.I<I18N>();

  final localDatabase = GetIt.I<LocalDatabaseRepository>();

  final userState = ref.watch(userProvider);
  return CreatePictoProvider(createPictoServices, i18N, groupService, pictogramService, userState, localDatabase);
});
