// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static m0(lastUpdate) => "Ultimo aggiornamento: ${lastUpdate}";

  static m1(tot) => "Totale destinationi raggiunte: ${tot}";

  static m2(tot) => "Totale spostamenti: ${tot}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "activeTrip" : MessageLookupByLibrary.simpleMessage("Spostamento Attivo"),
    "changePassword" : MessageLookupByLibrary.simpleMessage("Cambia Password"),
    "changePasswordFailure" : MessageLookupByLibrary.simpleMessage("Aggiornamento password fallito"),
    "changePasswordScreenBody" : MessageLookupByLibrary.simpleMessage("Non appena cambierai la password dovrai rieseguire l\'accesso utilizzando le tue nuove credenziali"),
    "changePasswordScreenTitle" : MessageLookupByLibrary.simpleMessage("Aggiorna la tua password"),
    "changePasswordSuccess" : MessageLookupByLibrary.simpleMessage("Password aggiornata con successo. Accedi con le tue nuove credenziali"),
    "changeTheme" : MessageLookupByLibrary.simpleMessage("Cambia Tema"),
    "changeThemeDialogContent" : MessageLookupByLibrary.simpleMessage("Scegli il tuo tema preferito per l\'applicazione"),
    "changeThemeDialogTitle" : MessageLookupByLibrary.simpleMessage("Cambia il tema dell\'applicazione"),
    "changingPassword" : MessageLookupByLibrary.simpleMessage("Aggiornando la password..."),
    "confirmed" : MessageLookupByLibrary.simpleMessage("Contagiati"),
    "createAccount" : MessageLookupByLibrary.simpleMessage("Crea un nuovo account"),
    "deaths" : MessageLookupByLibrary.simpleMessage("Deceduti"),
    "deleteAccount" : MessageLookupByLibrary.simpleMessage("Elimina Account"),
    "deleteAccountDialogContent" : MessageLookupByLibrary.simpleMessage("Tutti i dati salvati riguardanti gli spostamenti verranno eliminati. Questa azione non è reversibile."),
    "deleteAccountDialogTitle" : MessageLookupByLibrary.simpleMessage("Sei sicuro di voler eliminare il tuo account?"),
    "deleteAccountFailure" : MessageLookupByLibrary.simpleMessage("Errore nell\'eliminare l\'account"),
    "deleteAccountScreenBody" : MessageLookupByLibrary.simpleMessage("Insertisci la tua password e premi sul bottone Elimina Account per eliminare in modo definitivo il tuo account"),
    "deleteAccountScreenTitle" : MessageLookupByLibrary.simpleMessage("Elimina Account"),
    "deleteAccountSuccess" : MessageLookupByLibrary.simpleMessage("Account eliminato"),
    "deletingAccount" : MessageLookupByLibrary.simpleMessage("Eliminando l\'account..."),
    "destination" : MessageLookupByLibrary.simpleMessage("Destinazione:"),
    "differentPasswords" : MessageLookupByLibrary.simpleMessage("Le due password inserite sono diverse"),
    "done" : MessageLookupByLibrary.simpleMessage("Fatto"),
    "elapsedTime" : MessageLookupByLibrary.simpleMessage("Tempo Trascorso:"),
    "global" : MessageLookupByLibrary.simpleMessage("Globale"),
    "home" : MessageLookupByLibrary.simpleMessage("Home"),
    "insertDestination" : MessageLookupByLibrary.simpleMessage("Inserisci una destinazione..."),
    "insertPasswordAgain" : MessageLookupByLibrary.simpleMessage("Reinserisci la password"),
    "invalidEmail" : MessageLookupByLibrary.simpleMessage("Email non valida"),
    "invalidPassword" : MessageLookupByLibrary.simpleMessage("Password non valida"),
    "italy" : MessageLookupByLibrary.simpleMessage("Italia"),
    "lastUpdate" : m0,
    "loggingIn" : MessageLookupByLibrary.simpleMessage("Accesso in corso..."),
    "login" : MessageLookupByLibrary.simpleMessage("Accedi"),
    "loginFailure" : MessageLookupByLibrary.simpleMessage("Accesso fallito"),
    "loginWithGoogle" : MessageLookupByLibrary.simpleMessage("Accedi con Google"),
    "loginWithYourAccount" : MessageLookupByLibrary.simpleMessage("Accedi con il tuo account"),
    "newPassword" : MessageLookupByLibrary.simpleMessage("Nuova password"),
    "newTrip" : MessageLookupByLibrary.simpleMessage("Nuovo Spostamento"),
    "newTripDialogContent" : MessageLookupByLibrary.simpleMessage("Vuoi creare un nuovo spostamento? Lo spostamento corrente verrà sospeso e memorizzato."),
    "newTripDialogTitle" : MessageLookupByLibrary.simpleMessage("Crea nuovo spostamento"),
    "news" : MessageLookupByLibrary.simpleMessage("News"),
    "newsDescription" : MessageLookupByLibrary.simpleMessage("Di seguito trovi un resoconto della situazione sanitaria nel tuo paese e nel mondo. I dati presentati non hanno la presunzione di essere affidabili al 100% ma possono essere considerati una buona stima della situazione corrente."),
    "newsDisclaimer" : MessageLookupByLibrary.simpleMessage("Tutti i dati presenti in questa sezione sono raccolti dalla API"),
    "no" : MessageLookupByLibrary.simpleMessage("No"),
    "noActiveTrips" : MessageLookupByLibrary.simpleMessage("Al momento non c\'è nessuno spostamento attivo. Se devi uscire crea un nuovo spostamento o selezionane uno dalla lista dei tuoi spostamenti precedenti."),
    "noPreviousTripsBody" : MessageLookupByLibrary.simpleMessage("Per creare un nuovo spostamento torna indietro e seleziona \"Nuovo Spostamento\""),
    "noPreviousTripsTitle" : MessageLookupByLibrary.simpleMessage("Nessuno spostamento precedente"),
    "numStops" : MessageLookupByLibrary.simpleMessage("Numero di fermate:"),
    "objective" : MessageLookupByLibrary.simpleMessage("Obiettivo"),
    "oldDestinations" : MessageLookupByLibrary.simpleMessage("Destinazioni Precedenti"),
    "oldDestinationsLoadFailure" : MessageLookupByLibrary.simpleMessage("Errore nel caricamento delle destinazioni precedenti"),
    "onboarding1" : MessageLookupByLibrary.simpleMessage("CovTrack sostituisce il modulo di autocertificazione cartaceo generando un QR Code e registrando i punti di fermata causa di potenziale contagio"),
    "onboarding2" : MessageLookupByLibrary.simpleMessage("In questa sezione puoi creare uno spostamento, visualizzare quello attivo o l\'elenco di quelli precedenti"),
    "onboarding3" : MessageLookupByLibrary.simpleMessage("In questa sezione puoi consultare le ultime informazioni sulla situazione sanitaria nel tuo paese e nel mondo"),
    "onboarding4" : MessageLookupByLibrary.simpleMessage("In questa sezione puoi cambiare la password del tuo account, eliminarlo o cambiare il tema dell\'applicazione"),
    "or" : MessageLookupByLibrary.simpleMessage("oppure"),
    "reason1" : MessageLookupByLibrary.simpleMessage("Comprovate esigenze lavorative"),
    "reason2" : MessageLookupByLibrary.simpleMessage("Situazioni di necessità"),
    "reason3" : MessageLookupByLibrary.simpleMessage("Motivi di salute"),
    "reasonPickerDesc" : MessageLookupByLibrary.simpleMessage("Motivazione:"),
    "recovered" : MessageLookupByLibrary.simpleMessage("Guariti"),
    "register" : MessageLookupByLibrary.simpleMessage("Registrati"),
    "registering" : MessageLookupByLibrary.simpleMessage("Registrazione in corso..."),
    "registrationFailure" : MessageLookupByLibrary.simpleMessage("Registrazione fallita"),
    "returnTrip" : MessageLookupByLibrary.simpleMessage("Avvia Spostamento di Ritorno"),
    "returnTripDialogContent" : MessageLookupByLibrary.simpleMessage("Vuoi avviare lo spostamento di ritorno?"),
    "returnTripDialogTitle" : MessageLookupByLibrary.simpleMessage("Avvio spostamento di ritorno"),
    "selectReason" : MessageLookupByLibrary.simpleMessage("Seleziona una motivazione..."),
    "selectedDestination" : MessageLookupByLibrary.simpleMessage("Destinazione Selezionata"),
    "settings" : MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "settingsFailure" : MessageLookupByLibrary.simpleMessage("Errore nel caricamento delle impostazioni"),
    "showQr" : MessageLookupByLibrary.simpleMessage("Mostra QR Code"),
    "skip" : MessageLookupByLibrary.simpleMessage("Salta"),
    "source" : MessageLookupByLibrary.simpleMessage("Partenza:"),
    "startTrip" : MessageLookupByLibrary.simpleMessage("Avvia Spostamento"),
    "stayHome" : MessageLookupByLibrary.simpleMessage("Rimani a casa"),
    "stopTrip" : MessageLookupByLibrary.simpleMessage("Concludi Spostamento"),
    "stopTripDialogContent" : MessageLookupByLibrary.simpleMessage("Sei sicuro di voler concludere lo spostamento corrente?"),
    "stopTripDialogTitle" : MessageLookupByLibrary.simpleMessage("Concludi spostamento corrente"),
    "totalDestinations" : m1,
    "totalTrips" : m2,
    "tripDetails" : MessageLookupByLibrary.simpleMessage("Dettagli Spostamento"),
    "tripsLoadFailure" : MessageLookupByLibrary.simpleMessage("Errore nel caricamento dei vecchi spostamenti"),
    "yes" : MessageLookupByLibrary.simpleMessage("Si")
  };
}
