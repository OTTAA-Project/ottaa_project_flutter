import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/customise_provider.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

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

  setUp(() {
    mockI18N = MockI18N();
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
      Picto(id: '00', type: 0, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork')),
      Picto(id: '01', type: 1, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork')),
      Picto(id: '02', type: 2, resource: AssetsImage(asset: 'testAsset', network: 'testNetwork')),
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

  test('should initialise the values for the provider', () async {});
}
