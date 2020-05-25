// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
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
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "createAccount" : MessageLookupByLibrary.simpleMessage("Create a new account"),
    "differentPasswords" : MessageLookupByLibrary.simpleMessage("The two passwords are not the same"),
    "donate" : MessageLookupByLibrary.simpleMessage("Donate"),
    "done" : MessageLookupByLibrary.simpleMessage("Done"),
    "home" : MessageLookupByLibrary.simpleMessage("Home"),
    "info" : MessageLookupByLibrary.simpleMessage("Info"),
    "insertPasswordAgain" : MessageLookupByLibrary.simpleMessage("Insert password again"),
    "insertPlace" : MessageLookupByLibrary.simpleMessage("Insert a place..."),
    "invalidEmail" : MessageLookupByLibrary.simpleMessage("Invalid email"),
    "invalidPassword" : MessageLookupByLibrary.simpleMessage("Invalid password"),
    "loggingIn" : MessageLookupByLibrary.simpleMessage("Logging in..."),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginFailure" : MessageLookupByLibrary.simpleMessage("Login failure"),
    "loginWithYourAccount" : MessageLookupByLibrary.simpleMessage("Login with your account"),
    "objective" : MessageLookupByLibrary.simpleMessage("Objective"),
    "onboarding1" : MessageLookupByLibrary.simpleMessage("The main functionality of CovTrack is replacing the mandatory self-certification form"),
    "onboarding2" : MessageLookupByLibrary.simpleMessage("In the Home section you can view the active trip or create a new one"),
    "onboarding3" : MessageLookupByLibrary.simpleMessage("In the Info section you can read the latest information regarding the sanitary situation in your country and in the world"),
    "onboarding4" : MessageLookupByLibrary.simpleMessage("In the Donate section you will find a list of the main health associations and hospitals to which you can make a donation to help in the fight against Covid-19"),
    "or" : MessageLookupByLibrary.simpleMessage("or"),
    "register" : MessageLookupByLibrary.simpleMessage("Register"),
    "registering" : MessageLookupByLibrary.simpleMessage("Registering..."),
    "registrationFailure" : MessageLookupByLibrary.simpleMessage("Registration failure"),
    "skip" : MessageLookupByLibrary.simpleMessage("Skip")
  };
}
