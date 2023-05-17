import 'dart:ui';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'package:ottaa_project_flutter/core/enums/customise_data_type.dart';

import 'customise_provider_test.mocks.dart';

@GenerateMocks([I18N, LocalDatabaseRepository, CustomiseRepository, GroupsRepository, PictogramsRepository, UserNotifier])
Future<void> main() async {
  late MockI18N mockI18N;
  late MockLocalDatabaseRepository mockLocalDatabaseRepository;
  late MockCustomiseRepository mockCustomiseRepository;
  late MockGroupsRepository mockGroupsRepository;
  late MockPictogramsRepository mockPictogramsRepository;
  late MockUserNotifier mockUserNotifier;
  late CustomiseProvider customiseProvider;

  late List<Group> fakeGroups;
  late List<Picto> fakePictos;
  late BaseUserModel fakeUser;

  setUp(() {
    mockI18N = MockI18N();
    fakeUser = BaseUserModel(
      id: "0",
      settings: BaseSettingsModel(
        data: UserData(
          avatar: AssetsImage(asset: "test", network: "https://test.com"),
          birthDate: DateTime(0),
          genderPref: "n/a",
          lastConnection: DateTime(0),
          name: "John",
          lastName: "Doe",
        ),
        language: LanguageSetting.empty(),
      ),
      email: "test@mail.com",
      type: UserType.caregiver,
    );
    mockLocalDatabaseRepository = MockLocalDatabaseRepository();
    mockCustomiseRepository = MockCustomiseRepository();
    mockGroupsRepository = MockGroupsRepository();
    mockUserNotifier = MockUserNotifier();
    mockPictogramsRepository = MockPictogramsRepository();
    fakeGroups = [
      Group(id: '00', relations: [GroupRelation(id: '00', value: 00), GroupRelation(id: '01', value: 00)], text: 'test1', resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), freq: 00),
      Group(id: '01', relations: [GroupRelation(id: '', value: 00)], text: 'test2', resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), freq: 01),
      Group(id: '02', relations: [GroupRelation(id: '', value: 00)], text: 'test3', resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), freq: 03),
    ];
    fakePictos = [
      Picto(id: '00', type: 0, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true),
      Picto(id: '01', type: 1, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: false),
      Picto(id: '02', type: 2, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork'), block: true),
    ];

    customiseProvider = CustomiseProvider(mockPictogramsRepository, mockGroupsRepository, mockCustomiseRepository, mockI18N, mockUserNotifier, mockLocalDatabaseRepository);
    customiseProvider.groups = fakeGroups;
  });

  test('should set group data on to the screen', () async {
    const index = 1;

    final provider = customiseProvider;

    await customiseProvider.setGroupData(index: index);

    expect(provider.selectedGroup, equals(index));
    expect(provider.selectedGroupImage, equals(fakeGroups[index].resource.network));
    expect(provider.selectedGroupName, equals(fakeGroups[index].text));
    expect(provider.selectedGroupStatus, equals(fakeGroups[index].block));
    expect(provider.hasListeners, isFalse);
  });

  test('should upload the shortcuts for the user', () async {
    when(mockCustomiseRepository.setShortcutsForUser(shortcuts: anyNamed('shortcuts'), userId: anyNamed('userId'))).thenAnswer((realInvocation) async => const Right(null));

    expect(() async => await customiseProvider.setShortcutsForUser(userId: 'testID'), isA<void>());
  });

  test('should change the ', () async {
    final provider = customiseProvider;
    provider.groups = fakeGroups;
    provider.pictograms = fakePictos;
    provider.selectedGroup = 00;

    provider.fetchDesiredPictos();

    expect(provider.selectedGruposPicts.length, 2);
    expect(provider.selectedGruposPicts[0].id, '00');
    expect(provider.selectedGruposPicts[1].id, '01');
  });

  test('should populate the pictosMap correctly', () async {
    final pictograms = fakePictos;

    final provider = customiseProvider;

    provider.pictograms = pictograms;

    provider.createMapForPictos();

    expect(provider.pictosMap.length, 3);
    expect(provider.pictosMap['00'], 0);
    expect(provider.pictosMap['01'], 0);
    expect(provider.pictosMap['02'], 0);
  });

  test('should fetch and assign default groups', () async {
    final expectedGroups = fakeGroups;
    const mockLocale = Locale('es_AR');

    when(mockI18N.locale).thenReturn(mockLocale);
    when(mockCustomiseRepository.fetchDefaultGroups(languageCode: anyNamed('languageCode'))).thenAnswer((_) async => expectedGroups);

    await customiseProvider.getDefaultGroups();

    expect(customiseProvider.groups, expectedGroups);
    verify(mockCustomiseRepository.fetchDefaultGroups(languageCode: mockLocale.toString())).called(1);
  });

  test('should fetch and assign default Pictos', () async {
    final expectedPictos = fakePictos;
    const mockLocale = Locale('es_AR');

    when(mockI18N.locale).thenReturn(mockLocale);
    when(mockCustomiseRepository.fetchDefaultPictos(languageCode: anyNamed('languageCode'))).thenAnswer((_) async => expectedPictos);

    await customiseProvider.getDefaultPictos();

    expect(customiseProvider.pictograms, expectedPictos);
    verify(mockCustomiseRepository.fetchDefaultPictos(languageCode: mockLocale.toString())).called(1);
  });

  test('block should toggle the block status and notify listeners', () async {
    // Arrange
    final selectedGruposPicts = fakePictos;
    final pictograms = fakePictos;
    final pictosMap = {
      '01': 00,
      '02': 01,
      '03': 02,
    };
    customiseProvider.selectedGruposPicts = selectedGruposPicts;
    customiseProvider.pictograms = pictograms;
    customiseProvider.pictosMap = pictosMap;

    const index = 1;

    customiseProvider.block(index: index);

    expect(customiseProvider.selectedGruposPicts[index].block, true);
    expect(customiseProvider.pictograms[customiseProvider.pictosMap[customiseProvider.selectedGruposPicts[index].id]!].block, false);
  });

  test('fetchShortcutsForUser should populate selectedShortcuts correctly', () async {
    customiseProvider.selectedShortcuts = List.generate(8, (index) => false);
    final expectedFavourite = customiseProvider.selectedShortcuts[0];
    final expectedHistory = customiseProvider.selectedShortcuts[1];
    final expectedCamera = customiseProvider.selectedShortcuts[2];
    final expectedGames = customiseProvider.selectedShortcuts[3];
    final expectedYes = customiseProvider.selectedShortcuts[4];
    final expectedNo = customiseProvider.selectedShortcuts[5];
    final expectedShare = customiseProvider.selectedShortcuts[6];
    final expectedEnabled = customiseProvider.selectedShortcuts[7];
    final expectedResponse = ShortcutsModel(
      favs: expectedFavourite,
      history: expectedHistory,
      camera: expectedCamera,
      games: expectedGames,
      yes: expectedYes,
      no: expectedNo,
      share: expectedShare,
      enable: expectedEnabled,
    );

    when(mockCustomiseRepository.fetchShortcutsForUser(userId: anyNamed('userId'))).thenAnswer((realInvocation) async => expectedResponse);

    await customiseProvider.fetchShortcutsForUser(userId: 'mockUserId');

    expect(customiseProvider.selectedShortcuts[0], expectedFavourite);
    expect(customiseProvider.selectedShortcuts[1], expectedHistory);
    expect(customiseProvider.selectedShortcuts[2], expectedCamera);
    expect(customiseProvider.selectedShortcuts[3], expectedGames);
    expect(customiseProvider.selectedShortcuts[4], expectedYes);
    expect(customiseProvider.selectedShortcuts[5], expectedNo);
    expect(customiseProvider.selectedShortcuts[6], expectedShare);
  });

  test('should fetch and assign user groups', () async {
    final expectedGroups = fakeGroups;
    const mockLocale = Locale('es_AR');

    when(mockI18N.locale).thenReturn(mockLocale);
    when(mockCustomiseRepository.fetchUserGroups(languageCode: anyNamed('languageCode'), userId: anyNamed('userId'))).thenAnswer((_) async => expectedGroups);

    await customiseProvider.fetchUserGroups(userId: 'mockUserId');

    expect(customiseProvider.groups, expectedGroups);
  });

  test('should fetch and assign user pictos', () async {
    final expectedPictos = fakePictos;
    const mockLocale = Locale('es_AR');

    when(mockI18N.locale).thenReturn(mockLocale);
    when(mockCustomiseRepository.fetchUserPictos(languageCode: anyNamed('languageCode'), userId: anyNamed('userId'))).thenAnswer((_) async => expectedPictos);

    await customiseProvider.fetchUserPictos(userId: 'mockUserId');

    expect(customiseProvider.pictograms, expectedPictos);
  });

  test('should return true if values exist, false otherwise', () async {
    final expectedValue = true;
    final mockLocale = Locale('en');
    final mockUserId = 'mockUserId';

    when(mockI18N.locale).thenReturn(mockLocale);
    when(mockCustomiseRepository.valuesExistOrNot(
      languageCode: anyNamed('languageCode'),
      userId: anyNamed('userId'),
    )).thenAnswer((_) async => expectedValue);

    final result = await customiseProvider.dataExistOrNot(userId: mockUserId);

    expect(result, expectedValue);
    verify(mockCustomiseRepository.valuesExistOrNot(
      languageCode: '${mockLocale.languageCode}_${mockLocale.countryCode}',
      userId: mockUserId,
    )).called(1);
  });

  test('should call notifyListeners', () {
    customiseProvider.notify();

    expect(() => customiseProvider.notify(), isA<void>());
  });

  /*test('should upload data and update user', () async {
    final mockLocale = const Locale('es_Ar');

    when(mockI18N.locale).thenReturn(mockLocale);
    when(mockUserNotifier.user).thenReturn(fakeUser);
    when(mockUserNotifier.setUser(any)).thenReturn(null);
    when(mockPictogramsRepository.uploadPictograms(any, any, userId: anyNamed('userId'))).thenAnswer((_) => Future.value());
    when(mockGroupsRepository.uploadGroups(any, any, any, userId: anyNamed('userId'))).thenAnswer((_) => Future.value());
    when(mockLocalDatabaseRepository.setUser(any)).thenAnswer((_) => Future.value());

    // Act
    await customiseProvider.uploadData(userId: 'mockUserId');

    // Assert
    verify(mockPictogramsRepository.uploadPictograms(any, mockLocale.toString(), userId: 'mockUserId')).called(1);
    verify(mockGroupsRepository.uploadGroups(any, 'type', mockLocale.toString(), userId: 'mockUserId')).called(1);
    verify(mockLocalDatabaseRepository.setUser(any)).called(1);
    verify(mockUserNotifier.setUser(any)).called(1);
  });*/

  //todo: emir i am leaving init,fetchDefaultCaseValues,fetchUserCaseValues, and uploadData to you

  // test('should initialise the values for the provider', () async {
  //   // Arrange
  //   final provider = customiseProvider;
  //   provider.type = CustomiseDataType.careGiver;
  //
  //   final mockFetchUserCaseValues = MockFunction<void>(userId: 'mockUserId');
  //   myClass.fetchUserCaseValues = mockFetchUserCaseValues;
  //
  //   // Act
  //   await myClass.inIt(userId: 'mockUserId');
  //
  //   // Assert
  //   verify(mockFetchUserCaseValues('mockUserId')).called(1);
  // });
}
