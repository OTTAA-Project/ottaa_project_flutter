import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/profile_services.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'profile_services_test.mocks.dart';

@GenerateMocks([
  ServerRepository,
])
Future<void> main() async {
  late MockServerRepository mockServerRepository;

  late ProfileRepository profileRepository;

  late Map<String, dynamic> fakeConnectedUserData;
  late Map<String, dynamic> fakeUserData;

  setUp(() {
    mockServerRepository = MockServerRepository();
    profileRepository = ProfileService(mockServerRepository);
    fakeConnectedUserData = {
      'fakeUser1': {'name': 'testName1'},
      'fakeUser2': {'name': 'testName1'}
    };
    fakeUserData = {'name': 'john doe', 'id': '1234'};
  });

  test('should update user Settings', () async {
    Map<String, dynamic> oldData = {"name": "rben"};
    Map<String, dynamic> newData = {"name": "ruben"};

    when(mockServerRepository.updateUserSettings(data: anyNamed('data'), userId: anyNamed('userId'))).thenAnswer((realInvocation) async {
      oldData = realInvocation.namedArguments[#data];
    });

    await profileRepository.updateUserSettings(data: newData, userId: 'TestUserId');

    expect(oldData, newData);
  });

  test('should return a link to the user image after uploading it', () async {
    when(mockServerRepository.uploadUserImage(path: anyNamed('path'), name: anyNamed('name'), userId: anyNamed('userId'))).thenAnswer((_) async => 'image uploaded');

    final response = await profileRepository.uploadUserImage(path: 'TestPath', name: 'TestName', userId: 'TestUserId');

    expect(response, 'image uploaded');
  });

  test('should return connected users', () async {
    when(mockServerRepository.getConnectedUsers(userId: anyNamed('userId'))).thenAnswer((value) async => Right(fakeConnectedUserData));

    final response = await profileRepository.getConnectedUsers(userId: 'testUserId');

    expect(response.right.entries.length, 2);
  });

  test('should return a string when no connected users are present', () async {
    when(mockServerRepository.getConnectedUsers(userId: anyNamed('userId'))).thenAnswer((value) async => const Left('no user are connected'));

    final response = await profileRepository.getConnectedUsers(userId: 'testUserId');

    expect(response.left, 'no user are connected');
  });

  test('should return a connected user data', () async {
    when(mockServerRepository.fetchConnectedUserData(userId: anyNamed('userId'))).thenAnswer((realInvocation) async => Right(fakeUserData));

    final response = await profileRepository.fetchConnectedUserData(userId: 'testUserid');

    expect(response.right.entries.length, 2);
  });

  test('should return a string when connected user is not present', () async {
    when(mockServerRepository.fetchConnectedUserData(userId: anyNamed('userId'))).thenAnswer((realInvocation) async => const Left('no user'));

    final response = await profileRepository.fetchConnectedUserData(userId: 'testUserid');

    expect(response.left, 'no user');
  });

  test('should remove the connected user from the caregiver list of users', () async {
    List connectedData = ["testUserid"];

    when(mockServerRepository.removeCurrentUser(userId: anyNamed('userId'), careGiverId: anyNamed('careGiverId'))).thenAnswer((realInvocation) async {
      connectedData.remove(realInvocation.namedArguments[#userId]);
    });

    await profileRepository.removeCurrentUser(userId: 'testUserid', careGiverId: 'testCareGiverId');

    expect(connectedData, equals([]));
    expect(connectedData.length, 0);
  });

  test('should return a user from the given id of the patient', () async {
    when(mockServerRepository.getProfileById(id: anyNamed('id'))).thenAnswer((realInvocation) async => Right(fakeUserData));

    final response = await profileRepository.getProfileById(id: 'testId');

    expect(response.right.entries.length, 2);
  });

  test('should return a String from the give id of the patient if no data is found', () async {
    when(mockServerRepository.getProfileById(id: anyNamed('id'))).thenAnswer((realInvocation) async => const Left('No User'));

    final response = await profileRepository.getProfileById(id: 'testId');

    expect(response.left, 'No User');
  });

  test('should update user information', () async {
    Map<String, dynamic> oldData = {};
    Map<String, dynamic> newData = {"name": "emir"};

    when(mockServerRepository.uploadUserInformation(any, any)).thenAnswer((realInvocation) async {
      oldData = realInvocation.positionalArguments[1];
      return const Right(null);
    });

    await profileRepository.updateUser(data: newData, userId: 'TestUserId');

    expect(oldData, newData);
  });
}
