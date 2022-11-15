import 'package:test/test.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_avatar_notifier.dart';

void main(){
  var userNotifier = UserAvatarNotifier();
  group('User Avatar Notifier Coverage',(){
    test('Change Avatar', (){
      userNotifier.changeAvatar(2);
      expect(userNotifier.getAvatar(),'2');
    });
  });
}