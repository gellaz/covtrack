// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(lastUpdate) => "Last update: ${lastUpdate}";

  static m1(tot) => "Total number of trips: ${tot}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "activeTrip" : MessageLookupByLibrary.simpleMessage("Active Trip"),
    "changePassword" : MessageLookupByLibrary.simpleMessage("Change Password"),
    "changePasswordFailure" : MessageLookupByLibrary.simpleMessage("Change password failure"),
    "changePasswordScreenBody" : MessageLookupByLibrary.simpleMessage("As soon as you change your password you will have to log in again using your new credentials"),
    "changePasswordScreenTitle" : MessageLookupByLibrary.simpleMessage("Change your password"),
    "changePasswordSuccess" : MessageLookupByLibrary.simpleMessage("Password updated successfully. Log in with your new credentials"),
    "changeTheme" : MessageLookupByLibrary.simpleMessage("Change Theme"),
    "changeThemeDialogContent" : MessageLookupByLibrary.simpleMessage("Choose your favourite theme for the application"),
    "changeThemeDialogTitle" : MessageLookupByLibrary.simpleMessage("Change App Theme"),
    "changingPassword" : MessageLookupByLibrary.simpleMessage("Changing password..."),
    "confirmed" : MessageLookupByLibrary.simpleMessage("Confirmed"),
    "createAccount" : MessageLookupByLibrary.simpleMessage("Create a new account"),
    "deaths" : MessageLookupByLibrary.simpleMessage("Deaths"),
    "deleteAccount" : MessageLookupByLibrary.simpleMessage("Delete Account"),
    "deleteAccountDialogContent" : MessageLookupByLibrary.simpleMessage("All saved data about your trips will be deleted. This action is not reversible."),
    "deleteAccountDialogTitle" : MessageLookupByLibrary.simpleMessage("Are you sure you want to delete your account?"),
    "deleteAccountFailure" : MessageLookupByLibrary.simpleMessage("Error in deleting the account"),
    "deleteAccountScreenBody" : MessageLookupByLibrary.simpleMessage("Insert your password and press on Delete Account to permanently delete your account"),
    "deleteAccountScreenTitle" : MessageLookupByLibrary.simpleMessage("Delete Account"),
    "deleteAccountSuccess" : MessageLookupByLibrary.simpleMessage("Account successfully deleted"),
    "deletingAccount" : MessageLookupByLibrary.simpleMessage("Deleting account..."),
    "destination" : MessageLookupByLibrary.simpleMessage("Destination:"),
    "differentPasswords" : MessageLookupByLibrary.simpleMessage("The two passwords are not the same"),
    "done" : MessageLookupByLibrary.simpleMessage("Done"),
    "elapsedTime" : MessageLookupByLibrary.simpleMessage("Elapsed Time:"),
    "global" : MessageLookupByLibrary.simpleMessage("Global"),
    "home" : MessageLookupByLibrary.simpleMessage("Home"),
    "insertDestination" : MessageLookupByLibrary.simpleMessage("Insert a destination..."),
    "insertPasswordAgain" : MessageLookupByLibrary.simpleMessage("Insert password again"),
    "invalidEmail" : MessageLookupByLibrary.simpleMessage("Invalid email"),
    "invalidPassword" : MessageLookupByLibrary.simpleMessage("Invalid password"),
    "italy" : MessageLookupByLibrary.simpleMessage("Italy"),
    "lastUpdate" : m0,
    "loggingIn" : MessageLookupByLibrary.simpleMessage("Logging in..."),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginFailure" : MessageLookupByLibrary.simpleMessage("Login failure"),
    "loginWithGoogle" : MessageLookupByLibrary.simpleMessage("Login with Google"),
    "loginWithYourAccount" : MessageLookupByLibrary.simpleMessage("Login with your account"),
    "newPassword" : MessageLookupByLibrary.simpleMessage("New password"),
    "newTrip" : MessageLookupByLibrary.simpleMessage("New Trip"),
    "newTripDialogContent" : MessageLookupByLibrary.simpleMessage("Do you want to create a new trip? The current trip will be stopped and then stored."),
    "newTripDialogTitle" : MessageLookupByLibrary.simpleMessage("Create new trip"),
    "news" : MessageLookupByLibrary.simpleMessage("News"),
    "newsDescription" : MessageLookupByLibrary.simpleMessage("Below you can find a summary of the sanitary situation in your country and in the world. These data do not claim to be 100% reliable but can be considered a good estimate of the current health situation."),
    "newsDisclaimer" : MessageLookupByLibrary.simpleMessage("All data presented in this section are fetched from the API"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noActiveTrips" : MessageLookupByLibrary.simpleMessage("At the moment there is no active trip. If you need to go somewhere create a new trip or select one from the list of your previous trips."),
    "noPreviousTripsBody" : MessageLookupByLibrary.simpleMessage("To create a new trip go back and tap on the \"New Trip\" button"),
    "noPreviousTripsTitle" : MessageLookupByLibrary.simpleMessage("No previous trips"),
    "numStops" : MessageLookupByLibrary.simpleMessage("Number of stops:"),
    "objective" : MessageLookupByLibrary.simpleMessage("Objective"),
    "oldPassword" : MessageLookupByLibrary.simpleMessage("Old password"),
    "oldTrips" : MessageLookupByLibrary.simpleMessage("Old Trips"),
    "onboarding1" : MessageLookupByLibrary.simpleMessage("CovTrack replaces the paper self-certification form by generating a QR Code and it records your stops cause of potential contagion"),
    "onboarding2" : MessageLookupByLibrary.simpleMessage("In this section you can create a trip, view the active one or the list of previous ones"),
    "onboarding3" : MessageLookupByLibrary.simpleMessage("In this section you can read the latest information regarding the sanitary situation in your country and around the world"),
    "onboarding4" : MessageLookupByLibrary.simpleMessage("In this section you can change the password of your account, delete your account or change the application theme"),
    "or" : MessageLookupByLibrary.simpleMessage("or"),
    "reason1" : MessageLookupByLibrary.simpleMessage("Proven work needs"),
    "reason2" : MessageLookupByLibrary.simpleMessage("Situations of need"),
    "reason3" : MessageLookupByLibrary.simpleMessage("Health reasons"),
    "reasonPickerDesc" : MessageLookupByLibrary.simpleMessage("Reason:"),
    "recovered" : MessageLookupByLibrary.simpleMessage("Recovered"),
    "register" : MessageLookupByLibrary.simpleMessage("Register"),
    "registering" : MessageLookupByLibrary.simpleMessage("Registering..."),
    "registrationFailure" : MessageLookupByLibrary.simpleMessage("Registration failure"),
    "returnTrip" : MessageLookupByLibrary.simpleMessage("Start Return Trip"),
    "returnTripDialogContent" : MessageLookupByLibrary.simpleMessage("Do you want to start the return trip?"),
    "returnTripDialogTitle" : MessageLookupByLibrary.simpleMessage("Start return trip"),
    "selectReason" : MessageLookupByLibrary.simpleMessage("Select a reason..."),
    "selectedDestination" : MessageLookupByLibrary.simpleMessage("Selected Destination"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "settingsFailure" : MessageLookupByLibrary.simpleMessage("Failed loading settings"),
    "showQr" : MessageLookupByLibrary.simpleMessage("Show QR Code"),
    "skip" : MessageLookupByLibrary.simpleMessage("Skip"),
    "source" : MessageLookupByLibrary.simpleMessage("Source:"),
    "startTrip" : MessageLookupByLibrary.simpleMessage("Start Trip"),
    "stayHome" : MessageLookupByLibrary.simpleMessage("Stay Home, stay safe"),
    "stopTrip" : MessageLookupByLibrary.simpleMessage("Stop Trip"),
    "stopTripDialogContent" : MessageLookupByLibrary.simpleMessage("Are you sure you want to stop the current trip?"),
    "stopTripDialogTitle" : MessageLookupByLibrary.simpleMessage("Stop current trip"),
    "tripDetails" : MessageLookupByLibrary.simpleMessage("Trip Details"),
    "tripsLoadFailure" : MessageLookupByLibrary.simpleMessage("Error retrieving your previous trips"),
    "tripsTotal" : m1,
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
