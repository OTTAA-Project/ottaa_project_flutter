import 'dart:ui';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';

import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/accessibility_setting.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/layout_setting.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/payment_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/models/tts_setting.dart';
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
  late CustomiseProvider customiseNotifier;

  late List<Group> fakeGroups;
  late List<Picto> fakePictos;
  late UserModel fakeUser;

  setUp(() {
    mockI18N = MockI18N();
    fakeUser = PatientUserModel(
      id: "0",
      groups: {},
      phrases: {},
      pictos: {},
      settings: PatientSettings(
        payment: Payment.none(),
        accessibility: AccessibilitySetting.empty(),
        layout: LayoutSetting.empty(),
        tts: TTSSetting.empty(),
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
      type: UserType.user,
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

    customiseNotifier = CustomiseProvider(mockPictogramsRepository, mockGroupsRepository, mockCustomiseRepository, mockI18N, mockUserNotifier, mockLocalDatabaseRepository);
    customiseNotifier.groups = fakeGroups;
  });

  test('should set group data on to the screen', () async {
    const index = 1;

    final provider = customiseNotifier;

    await customiseNotifier.setGroupData(index: index);

    expect(provider.selectedGroup, equals(index));
    expect(provider.selectedGroupImage, equals(fakeGroups[index].resource.network));
    expect(provider.selectedGroupName, equals(fakeGroups[index].text));
    expect(provider.selectedGroupStatus, equals(fakeGroups[index].block));
    expect(provider.hasListeners, isFalse);
  });

  test('should upload the shortcuts for the user', () async {
    when(mockCustomiseRepository.setShortcutsForUser(shortcuts: anyNamed('shortcuts'), userId: anyNamed('userId'))).thenAnswer((realInvocation) async => const Right(null));

    await customiseNotifier.setShortcutsForUser(userId: 'testID');

    verify(mockCustomiseRepository.setShortcutsForUser(shortcuts: anyNamed('shortcuts'), userId: anyNamed('userId')));
  });

  test('should change the ', () async {
    final provider = customiseNotifier;
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

    final provider = customiseNotifier;

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

    when(mockI18N.currentLocale).thenReturn(mockLocale);
    when(mockCustomiseRepository.fetchDefaultGroups(languageCode: anyNamed('languageCode'))).thenAnswer((_) async => expectedGroups);

    await customiseNotifier.getDefaultGroups();

    expect(customiseNotifier.groups, expectedGroups);
    verify(mockCustomiseRepository.fetchDefaultGroups(languageCode: mockLocale.toString())).called(1);
  });

  test('should fetch and assign default Pictos', () async {
    final expectedPictos = fakePictos;
    const mockLocale = Locale('es_AR');

    when(mockI18N.currentLocale).thenReturn(mockLocale);
    when(mockCustomiseRepository.fetchDefaultPictos(languageCode: anyNamed('languageCode'))).thenAnswer((_) async => expectedPictos);

    await customiseNotifier.getDefaultPictos();

    expect(customiseNotifier.pictograms, expectedPictos);
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
    customiseNotifier.selectedGruposPicts = selectedGruposPicts;
    customiseNotifier.pictograms = pictograms;
    customiseNotifier.pictosMap = pictosMap;

    const index = 1;

    customiseNotifier.block(index: index);

    expect(customiseNotifier.selectedGruposPicts[index].block, true);
    expect(customiseNotifier.pictograms[customiseNotifier.pictosMap[customiseNotifier.selectedGruposPicts[index].id]!].block, false);
  });

  test('fetchShortcutsForUser should populate selectedShortcuts correctly', () async {
    customiseNotifier.selectedShortcuts = List.generate(8, (index) => false);
    final expectedFavourite = customiseNotifier.selectedShortcuts[0];
    final expectedHistory = customiseNotifier.selectedShortcuts[1];
    final expectedCamera = customiseNotifier.selectedShortcuts[2];
    final expectedGames = customiseNotifier.selectedShortcuts[3];
    final expectedYes = customiseNotifier.selectedShortcuts[4];
    final expectedNo = customiseNotifier.selectedShortcuts[5];
    final expectedShare = customiseNotifier.selectedShortcuts[6];
    final expectedEnabled = customiseNotifier.selectedShortcuts[7];
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

    await customiseNotifier.fetchShortcutsForUser(userId: 'mockUserId');

    expect(customiseNotifier.selectedShortcuts[0], expectedFavourite);
    expect(customiseNotifier.selectedShortcuts[1], expectedHistory);
    expect(customiseNotifier.selectedShortcuts[2], expectedCamera);
    expect(customiseNotifier.selectedShortcuts[3], expectedGames);
    expect(customiseNotifier.selectedShortcuts[4], expectedYes);
    expect(customiseNotifier.selectedShortcuts[5], expectedNo);
    expect(customiseNotifier.selectedShortcuts[6], expectedShare);
  });

  test('should fetch and assign user groups', () async {
    final expectedGroups = fakeGroups;
    const mockLocale = Locale('es_AR');

    when(mockI18N.currentLocale).thenReturn(mockLocale);
    when(mockCustomiseRepository.fetchUserGroups(languageCode: anyNamed('languageCode'), userId: anyNamed('userId'))).thenAnswer((_) async => expectedGroups);

    await customiseNotifier.fetchUserGroups(userId: 'mockUserId');

    expect(customiseNotifier.groups, expectedGroups);
  });

  test('should fetch and assign user pictos', () async {
    final expectedPictos = fakePictos;
    const mockLocale = Locale('es_AR');

    when(mockI18N.currentLocale).thenReturn(mockLocale);
    when(mockCustomiseRepository.fetchUserPictos(languageCode: anyNamed('languageCode'), userId: anyNamed('userId'))).thenAnswer((_) async => expectedPictos);

    await customiseNotifier.fetchUserPictos(userId: 'mockUserId');

    expect(customiseNotifier.pictograms, expectedPictos);
  });

  test('should return true if values exist, false otherwise', () async {
    final expectedValue = true;
    final mockLocale = Locale('en');
    final mockUserId = 'mockUserId';

    when(mockI18N.currentLocale).thenReturn(mockLocale);
    when(mockCustomiseRepository.valuesExistOrNot(
      languageCode: anyNamed('languageCode'),
      userId: anyNamed('userId'),
    )).thenAnswer((_) async => expectedValue);

    final result = await customiseNotifier.dataExistOrNot(userId: mockUserId);

    expect(result, expectedValue);
    verify(mockCustomiseRepository.valuesExistOrNot(
      languageCode: '${mockLocale.languageCode}_${mockLocale.countryCode}',
      userId: mockUserId,
    )).called(1);
  });

  test('should call notifyListeners', () {
    customiseNotifier.notify();

    expect(() => customiseNotifier.notify(), isA<void>());
  });

  group("init", () {
    test("should init with user or caregiver", () async {
      when(mockCustomiseRepository.fetchShortcutsForUser(userId: anyNamed("userId"))).thenAnswer((realInvocation) async {
        return ShortcutsModel.all();
      });

      when(mockCustomiseRepository.fetchUserGroups(languageCode: anyNamed("languageCode"), userId: anyNamed("userId"))).thenAnswer((realInvocation) async {
        return fakeGroups;
      });

      when(mockCustomiseRepository.fetchUserPictos(languageCode: anyNamed("languageCode"), userId: anyNamed("userId"))).thenAnswer((realInvocation) async {
        return fakePictos;
      });

      when(mockI18N.currentLocale).thenReturn(const Locale("en", "US"));

      customiseNotifier.type = CustomiseDataType.user;
      await customiseNotifier.inIt(userId: "mockUserId");

      verify(mockCustomiseRepository.fetchShortcutsForUser(userId: "mockUserId")).called(1);
      verify(mockCustomiseRepository.fetchUserGroups(languageCode: "en_US", userId: "mockUserId")).called(1);
      verify(mockCustomiseRepository.fetchUserPictos(languageCode: "en_US", userId: "mockUserId")).called(1);
    });

    test("should init with default case", () async {
      when(mockI18N.currentLocale).thenReturn(const Locale("en", "US"));

      when(mockCustomiseRepository.fetchDefaultGroups(languageCode: anyNamed("languageCode"))).thenAnswer((realInvocation) async {
        return fakeGroups;
      });

      when(mockCustomiseRepository.fetchDefaultPictos(languageCode: anyNamed("languageCode"))).thenAnswer((realInvocation) async {
        return fakePictos;
      });

      await customiseNotifier.inIt(userId: "mockUserId");

      expect(customiseNotifier.pictosMap.length, greaterThan(1));
      verify(mockCustomiseRepository.fetchDefaultGroups(languageCode: "en_US")).called(1);
      verify(mockCustomiseRepository.fetchDefaultPictos(languageCode: "en_US")).called(1);
    });

    test("should init with default case", () async {
      when(mockI18N.currentLocale).thenReturn(const Locale("en", "US"));

      when(mockCustomiseRepository.fetchDefaultGroups(languageCode: anyNamed("languageCode"))).thenAnswer((realInvocation) async {
        return fakeGroups;
      });

      when(mockCustomiseRepository.fetchDefaultPictos(languageCode: anyNamed("languageCode"))).thenAnswer((realInvocation) async {
        return fakePictos;
      });

      customiseNotifier.dataExist = false;

      await customiseNotifier.inIt(userId: "mockUserId");

      expect(customiseNotifier.pictosMap.length, greaterThan(1));
      verify(mockCustomiseRepository.fetchDefaultGroups(languageCode: "en_US")).called(1);
      verify(mockCustomiseRepository.fetchDefaultPictos(languageCode: "en_US")).called(1);
    });
  });

  test("should upload data", () async {
    when(mockI18N.currentLocale).thenReturn(const Locale("en", "US"));

    when(mockPictogramsRepository.uploadPictograms(any, any, userId: anyNamed("userId"))).thenAnswer((realInvocation) async {});
    when(mockGroupsRepository.uploadGroups(any, any, any, userId: anyNamed("userId"))).thenAnswer((realInvocation) async {});

    when(mockCustomiseRepository.setShortcutsForUser(shortcuts: anyNamed("shortcuts"), userId: anyNamed("userId"))).thenAnswer((realInvocation) async => Right(null));

    when(mockLocalDatabaseRepository.setUser(any)).thenAnswer((realInvocation) async {});

    when(mockUserNotifier.setUser(any)).thenAnswer((realInvocation) {});

    when(mockUserNotifier.user).thenReturn(fakeUser);

    await customiseNotifier.uploadData(userId: "", savePictograms: true, saveGroups: true, saveShortcuts: true);

    verify(mockPictogramsRepository.uploadPictograms(any, any, userId: anyNamed("userId"))).called(1);
    verify(mockGroupsRepository.uploadGroups(any, any, any, userId: anyNamed("userId"))).called(1);
    verify(mockCustomiseRepository.setShortcutsForUser(shortcuts: anyNamed("shortcuts"), userId: anyNamed("userId"))).called(1);
    verify(mockLocalDatabaseRepository.setUser(any)).called(1);
    verify(mockUserNotifier.setUser(any)).called(1);

    expect(customiseNotifier.dataExist, true);
  });

  test("Should return customise Provider", () {
    GetIt.I.registerSingleton<CustomiseRepository>(mockCustomiseRepository);
    GetIt.I.registerSingleton<PictogramsRepository>(mockPictogramsRepository);
    GetIt.I.registerSingleton<GroupsRepository>(mockGroupsRepository);
    GetIt.I.registerSingleton<LocalDatabaseRepository>(mockLocalDatabaseRepository);
    GetIt.I.registerSingleton<I18N>(mockI18N);
    final container = ProviderContainer();

    final refProvider = container.read(customiseProvider);

    expect(refProvider, isA<CustomiseProvider>());
  });
}
