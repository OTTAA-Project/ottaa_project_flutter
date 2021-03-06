import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ottaa_project_flutter/app/global_widgets/step_button.dart';

class CustomAnalyticsEvents{
  static void setEventWithParameters(String name,Map<String,dynamic> value){
    FirebaseAnalytics.instance.logEvent(name: name,parameters: value);
  }

  static void setEvent(String name){
    FirebaseAnalytics.instance.logEvent(name: name);
  }

  static Map<String,dynamic> createMyMap(String name,dynamic value){
    return <String,dynamic>{'$name':value};
  }
}