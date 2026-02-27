import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @yourdream.
  ///
  /// In en, this message translates to:
  /// **'Your ideal job awaits.'**
  String get yourdream;

  /// No description provided for @getsmartjop.
  ///
  /// In en, this message translates to:
  /// **'Receive smart job recommendations based on your professional experience and take the next step in your career journey.'**
  String get getsmartjop;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @findtheright.
  ///
  /// In en, this message translates to:
  /// **'Find the Right Role for You'**
  String get findtheright;

  /// No description provided for @customizeyoursearch.
  ///
  /// In en, this message translates to:
  /// **'Customize your search to explore job opportunities that align with your professional goals and aspirations.'**
  String get customizeyoursearch;

  /// No description provided for @findajob.
  ///
  /// In en, this message translates to:
  /// **'Find a position that matches your skills and interests.'**
  String get findajob;

  /// No description provided for @discoverjobopport.
  ///
  /// In en, this message translates to:
  /// **'Explore career opportunities tailored to your expertise and passion. Connect with employers seeking talented professionals like you.'**
  String get discoverjobopport;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get register;

  /// No description provided for @registeras.
  ///
  /// In en, this message translates to:
  /// **'Register As'**
  String get registeras;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select Type'**
  String get select;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get name;

  /// No description provided for @entername.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get entername;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @enterphone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterphone;

  /// No description provided for @livejob.
  ///
  /// In en, this message translates to:
  /// **'Active Job Listings'**
  String get livejob;

  /// No description provided for @companies.
  ///
  /// In en, this message translates to:
  /// **'Companies'**
  String get companies;

  /// No description provided for @jobseeker.
  ///
  /// In en, this message translates to:
  /// **'Job Seekers'**
  String get jobseeker;

  /// No description provided for @employers.
  ///
  /// In en, this message translates to:
  /// **'Employers'**
  String get employers;

  /// No description provided for @welcomeback.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeback;

  /// No description provided for @loginas.
  ///
  /// In en, this message translates to:
  /// **'Log In As'**
  String get loginas;

  /// No description provided for @emailaddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailaddress;

  /// No description provided for @enteremail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enteremail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterpass.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterpass;

  /// No description provided for @forget.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forget;

  /// No description provided for @registernow.
  ///
  /// In en, this message translates to:
  /// **'Create an Account'**
  String get registernow;

  /// No description provided for @createpro.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get createpro;

  /// No description provided for @topskills.
  ///
  /// In en, this message translates to:
  /// **'Top Skills'**
  String get topskills;

  /// No description provided for @mypdf.
  ///
  /// In en, this message translates to:
  /// **'My PDF Document'**
  String get mypdf;

  /// No description provided for @pdffile.
  ///
  /// In en, this message translates to:
  /// **'PDF File'**
  String get pdffile;

  /// No description provided for @personal.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personal;

  /// No description provided for @fullname.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullname;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @othersetting.
  ///
  /// In en, this message translates to:
  /// **'Other Setting'**
  String get othersetting;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Helpm Center'**
  String get help;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'LogOut'**
  String get logout;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
