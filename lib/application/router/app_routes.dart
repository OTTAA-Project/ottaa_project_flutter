class AppRoutes {
  ///
  /// General Routes
  ///

  static const splash = "/splash";
  static const login = "/login";
  static const loginWait = "/login/waiting";
  static const home = "/home";

  static const onboarding = "/onboarding";

  ///
  /// User General Routes
  ///

  static const userWait = "/home/loading";
  static const userProfile = "/home/profile";
  static const userProfileRole = "/home/profile/role";
  static const userProfileAccounts = "/home/profile/accounts";
  static const userProfileTips = "/home/profile/tips";
  static const userProfileEdit = "/home/profile/edit";
  static const userProfileHelp = "/home/profile/help";
  static const userProfileHelpFaq = "/home/profile/help/faq";
  static const userCustomize = "/home/customize";
  static const userCustomizeBoard = "/home/customize/board";
  static const userCustomizePicto = "/home/customize/picto";
  static const userCustomizeWait = "/home/customize/wait";
  static const userTalk = "/home/talk";

  ///
  /// User Caregiver Routes
  ///
  static const caregiverAccount = "/home/account";
  static const caregiverAccountLayout = "/home/account/layout";
  static const caregiverAccountAccessibility = "/home/account/accessibility";
  static const caregiverAccountTTS = "/home/account/tts";
  static const caregiverAccountLanguage = "/home/account/language";
  static const caregiverLink = "/home/link";
  static const caregiverLinkToken = "/home/link/token";
  static const caregiverLinkWait = "/home/link/wait";
  static const caregiverLinkSuccess = "/home/link/success";

  ///
  /// User Patient routes
  ///
  static const patientSettings = "/home/settings";
  static const patientSettingsLayout = "/home/settings/layout";
  static const patientSettingsAccessibilty = "/home/settings/accessibility";
  static const patientSettingsTTS = "/home/settings/tts";
  static const patientSettingsLanguage = "/home/settings/language";
}
