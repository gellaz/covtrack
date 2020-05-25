import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/messages_all.dart';

class AppLocalizations {
  final String localeName;

  AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Messages that have to be translated.
  String get createAccount {
    return Intl.message(
      'Create a new account',
      name: 'createAccount',
      desc: 'Create new account button label',
      locale: localeName,
    );
  }

  String get differentPasswords {
    return Intl.message(
      'The two passwords are not the same',
      name: 'differentPasswords',
      desc: 'Error message when the entered passwords are not the same',
      locale: localeName,
    );
  }

  String get donate {
    return Intl.message(
      'Donate',
      name: 'donate',
      desc: 'Donate section label',
      locale: localeName,
    );
  }

  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: 'Done button label',
      locale: localeName,
    );
  }

  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'Home section label',
      locale: localeName,
    );
  }

  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: 'Info section label',
      locale: localeName,
    );
  }

  String get insertPasswordAgain {
    return Intl.message(
      'Insert password again',
      name: 'insertPasswordAgain',
      desc:
          'Hint message of the InputField for the second password in the RegisterScreen',
      locale: localeName,
    );
  }

  String get insertPlace {
    return Intl.message(
      'Insert a place...',
      name: 'insertPlace',
      desc: 'Hint message of the InputField DestinationPickerScreen',
      locale: localeName,
    );
  }

  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: 'Error message of the Email InputField',
      locale: localeName,
    );
  }

  String get invalidPassword {
    return Intl.message(
      'Invalid password',
      name: 'invalidPassword',
      desc: 'Hint message of the Password InputField',
      locale: localeName,
    );
  }

  String get loggingIn {
    return Intl.message(
      'Logging in...',
      name: 'loggingIn',
      desc: 'Snackbar message for the login process loading',
      locale: localeName,
    );
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Login button label',
      locale: localeName,
    );
  }

  String get loginFailure {
    return Intl.message(
      'Login failure',
      name: 'loginFailure',
      desc: 'Snackbar message for the login process failure',
      locale: localeName,
    );
  }

  String get loginWithYourAccount {
    return Intl.message(
      'Login with your account',
      name: 'loginWithYourAccount',
      desc: 'Login with your account button label',
      locale: localeName,
    );
  }

  String get objective {
    return Intl.message(
      'Objective',
      name: 'objective',
      desc: 'First onboarding screen title',
      locale: localeName,
    );
  }

  String get onboarding1 {
    return Intl.message(
      'The main functionality of CovTrack is replacing the mandatory self-certification form',
      name: 'onboarding1',
      desc: 'First onboarding screen body',
      locale: localeName,
    );
  }

  String get onboarding2 {
    return Intl.message(
      'In the Home section you can view the active trip or create a new one',
      name: 'onboarding2',
      desc: 'Second onboarding screen body',
      locale: localeName,
    );
  }

  String get onboarding3 {
    return Intl.message(
      'In the Info section you can read the latest information regarding the sanitary situation in your country and in the world',
      name: 'onboarding3',
      desc: 'Third onboarding screen body',
      locale: localeName,
    );
  }

  String get onboarding4 {
    return Intl.message(
      'In the Donate section you will find a list of the main health associations and hospitals to which you can make a donation to help in the fight against Covid-19',
      name: 'onboarding4',
      desc: 'Fourth onboarding screen body',
      locale: localeName,
    );
  }

  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: 'Text found in the TextDivider widget',
      locale: localeName,
    );
  }

  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: 'Register button label',
      locale: localeName,
    );
  }

  String get registering {
    return Intl.message(
      'Registering...',
      name: 'registering',
      desc: 'Snackbar message for the register process loading',
      locale: localeName,
    );
  }

  String get registrationFailure {
    return Intl.message(
      'Registration failure',
      name: 'registrationFailure',
      desc: 'Snackbar message for the registration process failure',
      locale: localeName,
    );
  }

  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: 'Skip button label',
      locale: localeName,
    );
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'it'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
