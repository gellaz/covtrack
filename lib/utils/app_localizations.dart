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
  String get activeTrip => Intl.message(
        'Active Trip',
        name: 'activeTrip',
        desc: 'Active trip Home screen description',
        locale: localeName,
      );

  String get changePassword => Intl.message(
        'Change Password',
        name: 'changePassword',
        desc: 'Change Password SettingsScreen description',
        locale: localeName,
      );

  String get changePasswordFailure => Intl.message(
        'Change password failure',
        name: 'changePasswordFailure',
        desc: 'Snackbar message for the change password process failure',
        locale: localeName,
      );

  String get changePasswordScreenBody => Intl.message(
        'As soon as you change your password you will have to log in again using your new credentials',
        name: 'changePasswordScreenBody',
        desc: 'ChangePasswordScreen body',
        locale: localeName,
      );

  String get changePasswordScreenTitle => Intl.message(
        'Change your password',
        name: 'changePasswordScreenTitle',
        desc: 'ChangePasswordScreen title',
        locale: localeName,
      );

  String get changePasswordSuccess => Intl.message(
        'Password updated successfully. Log in with your new credentials',
        name: 'changePasswordSuccess',
        desc: 'Snackbar message for the change password process success',
        locale: localeName,
      );

  String get changingPassword => Intl.message(
        'Changing password...',
        name: 'changingPassword',
        desc: 'Snackbar message for the change password process loading',
        locale: localeName,
      );

  String get changeTheme => Intl.message(
        'Change Theme',
        name: 'changeTheme',
        desc: 'Change Theme SettingsScreen description',
        locale: localeName,
      );

  String get changeThemeDialogContent => Intl.message(
        'Choose your favourite theme for the application',
        name: 'changeThemeDialogContent',
        desc: 'Change theme alert dialog content',
        locale: localeName,
      );

  String get changeThemeDialogTitle => Intl.message(
        'Change App Theme',
        name: 'changeThemeDialogTitle',
        desc: 'Change theme alert dialog title',
        locale: localeName,
      );

  String get confirmed => Intl.message(
        'Confirmed',
        name: 'confirmed',
        desc: 'Confirmed Info screen list tile description',
        locale: localeName,
      );

  String get createAccount => Intl.message(
        'Create a new account',
        name: 'createAccount',
        desc: 'Create new account button label',
        locale: localeName,
      );

  String get deaths => Intl.message(
        'Deaths',
        name: 'deaths',
        desc: 'Deaths Info screen list tile description',
        locale: localeName,
      );

  String get deleteAccount => Intl.message(
        'Delete Account',
        name: 'deleteAccount',
        desc: 'Delete Account SettingsScreen description',
        locale: localeName,
      );

  String get deleteAccountDialogContent => Intl.message(
        'All saved data about your trips will be deleted. This action is not reversible.',
        name: 'deleteAccountDialogContent',
        desc: 'DeleteAccountDialog content',
        locale: localeName,
      );

  String get deleteAccountDialogTitle => Intl.message(
        'Are you sure you want to delete your account?',
        name: 'deleteAccountDialogTitle',
        desc: 'DeleteAccountDialog title',
        locale: localeName,
      );

  String get deleteAccountFailure => Intl.message(
        'Error in deleting the account',
        name: 'deleteAccountFailure',
        desc: 'DeleteAccountScreen title',
        locale: localeName,
      );

  String get deleteAccountScreenBody => Intl.message(
        'Insert your password and press on Delete Account to permanently delete your account',
        name: 'deleteAccountScreenBody',
        desc: 'DeleteAccountScreen body',
        locale: localeName,
      );

  String get deleteAccountScreenTitle => Intl.message(
        'Delete Account',
        name: 'deleteAccountScreenTitle',
        desc: 'DeleteAccountScreen title',
        locale: localeName,
      );

  String get deleteAccountSuccess => Intl.message(
        'Account successfully deleted',
        name: 'deleteAccountSuccess',
        desc: 'Snackbar message for the delete account process success',
        locale: localeName,
      );

  String get deletingAccount => Intl.message(
        'Deleting account...',
        name: 'deletingAccount',
        desc: 'Snackbar message for the delete account process loading',
        locale: localeName,
      );

  String get destination => Intl.message(
        'Destination:',
        name: 'destination',
        desc: 'Destination description text',
        locale: localeName,
      );

  String get differentPasswords => Intl.message(
        'The two passwords are not the same',
        name: 'differentPasswords',
        desc: 'Error message when the entered passwords are not the same',
        locale: localeName,
      );

  String get done => Intl.message(
        'Done',
        name: 'done',
        desc: 'Done button label',
        locale: localeName,
      );

  String get elapsedTime => Intl.message(
        'Elapsed Time:',
        name: 'elapsedTime',
        desc: 'Elapsed time Home screen description',
        locale: localeName,
      );

  String get global => Intl.message(
        'Global',
        name: 'global',
        desc: 'Info screen Global title',
        locale: localeName,
      );

  String get home => Intl.message(
        'Home',
        name: 'home',
        desc: 'Home section label',
        locale: localeName,
      );

  String get info => Intl.message(
        'Info',
        name: 'info',
        desc: 'Info section label',
        locale: localeName,
      );

  String get infoDescription => Intl.message(
        'Below you can find a summary of the sanitary situation in your country and in the world. These data do not claim to be 100% reliable but can be considered a good estimate of the current health situation.',
        name: 'infoDescription',
        desc: 'Info screen body description',
        locale: localeName,
      );

  String get infoDisclaimer => Intl.message(
        'All data presented in this section are fetched from the API',
        name: 'infoDisclaimer',
        desc: 'Info screen disclaimer text',
        locale: localeName,
      );

  String get insertPasswordAgain => Intl.message(
        'Insert password again',
        name: 'insertPasswordAgain',
        desc:
            'Hint message of the InputField for the second password in the RegisterScreen',
        locale: localeName,
      );

  String get insertPlace => Intl.message(
        'Insert a place...',
        name: 'insertPlace',
        desc: 'Hint message of the InputField DestinationPickerScreen',
        locale: localeName,
      );

  String get invalidEmail => Intl.message(
        'Invalid email',
        name: 'invalidEmail',
        desc: 'Error message of the Email InputField',
        locale: localeName,
      );

  String get invalidPassword => Intl.message(
        'Invalid password',
        name: 'invalidPassword',
        desc: 'Hint message of the Password InputField',
        locale: localeName,
      );

  String get italy => Intl.message(
        'Italy',
        name: 'italy',
        desc: 'Info screen Italy title',
        locale: localeName,
      );

  String lastUpdate(String lastUpdate) => Intl.message(
        'Last update: $lastUpdate',
        args: [lastUpdate],
        name: 'lastUpdate',
        desc: 'InfoListView last update description',
        locale: localeName,
      );

  String get loggingIn => Intl.message(
        'Logging in...',
        name: 'loggingIn',
        desc: 'Snackbar message for the login process loading',
        locale: localeName,
      );

  String get login => Intl.message(
        'Login',
        name: 'login',
        desc: 'Login button label',
        locale: localeName,
      );

  String get loginFailure => Intl.message(
        'Login failure',
        name: 'loginFailure',
        desc: 'Snackbar message for the login process failure',
        locale: localeName,
      );

  String get loginWithGoogle => Intl.message(
        'Login with Google',
        name: 'loginWithGoogle',
        desc: 'Login with Google button label',
        locale: localeName,
      );

  String get loginWithYourAccount => Intl.message(
        'Login with your account',
        name: 'loginWithYourAccount',
        desc: 'Login with your account button label',
        locale: localeName,
      );

  String get newPassword => Intl.message(
        'New password',
        name: 'newPassword',
        desc: 'New password TextInput label',
        locale: localeName,
      );

  String get newTrip => Intl.message(
        'New Trip',
        name: 'newTrip',
        desc: 'New Trip button label',
        locale: localeName,
      );

  String get newTripDialogTitle => Intl.message(
        'Create new trip',
        name: 'newTripDialogTitle',
        desc: 'New Trip dialog title',
        locale: localeName,
      );

  String get newTripDialogContent => Intl.message(
        'Do you want to create a new trip? The current trip will be stopped and then stored.',
        name: 'newTripDialogContent',
        desc: 'New Trip dialog title',
        locale: localeName,
      );

  String get no => Intl.message(
        'No',
        name: 'no',
        desc: 'No message',
        locale: localeName,
      );

  String get noActiveTrips => Intl.message(
        'At the moment there is no active trip. If you need to go somewhere create a new trip or select one from the list of your previous trips.',
        name: 'noActiveTrips',
        desc: 'Home Screen description text',
        locale: localeName,
      );

  String get noPreviousTripsBody => Intl.message(
        'To create a new trip go back and tap on the "New Trip" button',
        name: 'noPreviousTripsBody',
        desc: 'OldTripsScreen body when the loaded trips list is empty',
        locale: localeName,
      );

  String get noPreviousTripsTitle => Intl.message(
        'No previous trips',
        name: 'noPreviousTripsTitle',
        desc: 'OldTripsScreen title when the loaded trips list is empty',
        locale: localeName,
      );

  String get numStops => Intl.message(
        'Number of stops:',
        name: 'numStops',
        desc: 'Home Screen number of stops description text',
        locale: localeName,
      );

  String get objective => Intl.message(
        'Objective',
        name: 'objective',
        desc: 'First onboarding screen title',
        locale: localeName,
      );

  String get oldPassword => Intl.message(
        'Old password',
        name: 'oldPassword',
        desc: 'Old Password TextInput label',
        locale: localeName,
      );

  String get oldTrips => Intl.message(
        'Old Trips',
        name: 'oldTrips',
        desc: 'Old Trips button label',
        locale: localeName,
      );

  String get onboarding1 => Intl.message(
        'The main functionality of CovTrack is replacing the mandatory self-certification form',
        name: 'onboarding1',
        desc: 'First onboarding screen body',
        locale: localeName,
      );

  String get onboarding2 => Intl.message(
        'In the Home section you can view the active trip or create a new one',
        name: 'onboarding2',
        desc: 'Second onboarding screen body',
        locale: localeName,
      );

  String get onboarding3 => Intl.message(
        'In the Info section you can read the latest information regarding the sanitary situation in your country and in the world',
        name: 'onboarding3',
        desc: 'Third onboarding screen body',
        locale: localeName,
      );

  String get onboarding4 => Intl.message(
        'In the Settings section you can change different account parameters and change the application appearence',
        name: 'onboarding4',
        desc: 'Fourth onboarding screen body',
        locale: localeName,
      );

  String get or => Intl.message(
        'or',
        name: 'or',
        desc: 'Text found in the TextDivider widget',
        locale: localeName,
      );

  String get reasonPickerDesc => Intl.message(
        'Reason:',
        name: 'reasonPickerDesc',
        desc: 'Reason picker description',
        locale: localeName,
      );

  String get recovered => Intl.message(
        'Recovered',
        name: 'recovered',
        desc: 'Recovered Info screen list tile description',
        locale: localeName,
      );

  String get register => Intl.message(
        'Register',
        name: 'register',
        desc: 'Register button label',
        locale: localeName,
      );

  String get registering => Intl.message(
        'Registering...',
        name: 'registering',
        desc: 'Snackbar message for the register process loading',
        locale: localeName,
      );

  String get registrationFailure => Intl.message(
        'Registration failure',
        name: 'registrationFailure',
        desc: 'Snackbar message for the registration process failure',
        locale: localeName,
      );

  String get returnTrip => Intl.message(
        'Start Return Trip',
        name: 'returnTrip',
        desc: 'Return tooltip text',
        locale: localeName,
      );

  String get returnTripDialogTitle => Intl.message(
        'Start return trip',
        name: 'returnTripDialogTitle',
        desc: 'Return trip alert dialog title',
        locale: localeName,
      );

  String get returnTripDialogContent => Intl.message(
        'Do you want to start the return trip?',
        name: 'returnTripDialogContent',
        desc: 'Return trip alert dialog content',
        locale: localeName,
      );

  String get settings => Intl.message(
        'Settings',
        name: 'settings',
        desc: 'Settings section label',
        locale: localeName,
      );

  String get settingsFailure => Intl.message(
        'Failed loading settings',
        name: 'settingsFailure',
        desc: 'Snackbar settings loading failure text',
        locale: localeName,
      );

  String get showQr => Intl.message(
        'Show QR Code',
        name: 'showQr',
        desc: 'Show QR Code button label',
        locale: localeName,
      );

  String get skip => Intl.message(
        'Skip',
        name: 'skip',
        desc: 'Skip button label',
        locale: localeName,
      );

  String get source => Intl.message(
        'Source:',
        name: 'source',
        desc: 'Source description text',
        locale: localeName,
      );

  String get startTrip => Intl.message(
        'Start Trip',
        name: 'startTrip',
        desc: 'Start Trip button label',
        locale: localeName,
      );

  String get stayHome => Intl.message(
        'Stay Home. Stay Safe.',
        name: 'stayHome',
        desc: 'HomeScreen title when there is no active trips',
        locale: localeName,
      );

  String get stopTrip => Intl.message(
        'Stop Trip',
        name: 'stopTrip',
        desc: 'Stop Trip tooltip',
        locale: localeName,
      );

  String get stopTripDialogTitle => Intl.message(
        'Stop current trip',
        name: 'stopTripDialogTitle',
        desc: 'Stop trip alert dialog title',
        locale: localeName,
      );

  String get stopTripDialogContent => Intl.message(
        'Are you sure you want to stop the current trip?',
        name: 'stopTripDialogContent',
        desc: 'Stop trip alert dialog content',
        locale: localeName,
      );

  String get tripDetails => Intl.message(
        'Trip Details',
        name: 'tripDetails',
        desc: 'Trip Details appbar title',
        locale: localeName,
      );

  String get tripsLoadFailure => Intl.message(
        'Error retrieving your previous trips',
        name: 'tripsLoadFailure',
        desc: 'Trips load failure message',
        locale: localeName,
      );

  String tripsTotal(int tot) => Intl.message(
        'Total number of trips: $tot',
        name: 'tripsTotal',
        args: [tot],
        desc: 'It shows the user the total number of trips made',
        locale: localeName,
      );

  String get yes => Intl.message(
        'Yes',
        name: 'yes',
        desc: 'Yes message',
        locale: localeName,
      );
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
