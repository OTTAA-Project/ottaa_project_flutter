import 'package:test/test.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';

void main(){
  var notifier = LoadingNotifier();
  group('notifier coverage', (){
    test('Show Loading', (){
      notifier.showLoading();
      expect(notifier.getState(), true);
    });
    test('Hide Loading', (){
      notifier.hideLoading();
      expect(notifier.getState(), false);
    });
    test('toogle Loading', (){
      notifier.showLoading();
      notifier.toggleLoading();
      expect(notifier.getState(), false);
    });
  });
}