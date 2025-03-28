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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcome_back;

  /// No description provided for @create_an_account.
  ///
  /// In en, this message translates to:
  /// **'Create An Account'**
  String get create_an_account;

  /// No description provided for @please_login.
  ///
  /// In en, this message translates to:
  /// **'Please login to your account'**
  String get please_login;

  /// No description provided for @please_fill.
  ///
  /// In en, this message translates to:
  /// **'Please fill in your details'**
  String get please_fill;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get user_name;

  /// No description provided for @enter_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enter_name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @phone_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phone_hint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get password_hint;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm;

  /// No description provided for @confirm_hint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirm_hint;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_button;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forget password?'**
  String get forgot_password;

  /// No description provided for @signup_prompt.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get signup_prompt;

  /// No description provided for @login_prompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get login_prompt;

  /// No description provided for @signup_button.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup_button;

  /// No description provided for @email_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get email_error;

  /// No description provided for @phone_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get phone_error;

  /// No description provided for @password_error.
  ///
  /// In en, this message translates to:
  /// **'Password must be strong'**
  String get password_error;

  /// No description provided for @password_mismatch_error.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get password_mismatch_error;

  /// No description provided for @name_error.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get name_error;

  /// No description provided for @fix_errors_message.
  ///
  /// In en, this message translates to:
  /// **'Please fix the errors before proceeding'**
  String get fix_errors_message;

  /// No description provided for @main_screen.
  ///
  /// In en, this message translates to:
  /// **'Main Screen'**
  String get main_screen;

  /// No description provided for @hi.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get hi;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get morning;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @monthly_target.
  ///
  /// In en, this message translates to:
  /// **'Monthly Target'**
  String get monthly_target;

  /// No description provided for @daily_sales.
  ///
  /// In en, this message translates to:
  /// **'Daily Sales'**
  String get daily_sales;

  /// No description provided for @active_rep.
  ///
  /// In en, this message translates to:
  /// **'Active Sales Representatives'**
  String get active_rep;

  /// No description provided for @num_active_rep.
  ///
  /// In en, this message translates to:
  /// **'Number of Active Representatives:'**
  String get num_active_rep;

  /// No description provided for @total_rep.
  ///
  /// In en, this message translates to:
  /// **''**
  String get total_rep;

  /// No description provided for @debts.
  ///
  /// In en, this message translates to:
  /// **'Debts'**
  String get debts;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @debts_num.
  ///
  /// In en, this message translates to:
  /// **'Number of unpaid invoices:'**
  String get debts_num;

  /// No description provided for @total_debts.
  ///
  /// In en, this message translates to:
  /// **'Total Debts:'**
  String get total_debts;

  /// No description provided for @quick_access.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quick_access;

  /// No description provided for @create_invoice.
  ///
  /// In en, this message translates to:
  /// **'Create Invoice'**
  String get create_invoice;

  /// No description provided for @create_invoice_prompt.
  ///
  /// In en, this message translates to:
  /// **'Fill in the fields to create an invoice:'**
  String get create_invoice_prompt;

  /// No description provided for @invoice_type.
  ///
  /// In en, this message translates to:
  /// **'Invoice Type:'**
  String get invoice_type;

  /// No description provided for @invoice_num.
  ///
  /// In en, this message translates to:
  /// **'Invoice NO.'**
  String get invoice_num;

  /// No description provided for @select_invoice_type.
  ///
  /// In en, this message translates to:
  /// **'Select Invoice Type:'**
  String get select_invoice_type;

  /// No description provided for @cash_invoice.
  ///
  /// In en, this message translates to:
  /// **'Cash Invoice'**
  String get cash_invoice;

  /// No description provided for @debt_invoice.
  ///
  /// In en, this message translates to:
  /// **'Debt Invoice'**
  String get debt_invoice;

  /// No description provided for @account_statement.
  ///
  /// In en, this message translates to:
  /// **'Account Statement'**
  String get account_statement;

  /// No description provided for @accept_debts.
  ///
  /// In en, this message translates to:
  /// **'Accept Debts'**
  String get accept_debts;

  /// No description provided for @set_path.
  ///
  /// In en, this message translates to:
  /// **'Set Paths'**
  String get set_path;

  /// No description provided for @add_goal.
  ///
  /// In en, this message translates to:
  /// **'Add New Target'**
  String get add_goal;

  /// No description provided for @goal_amount.
  ///
  /// In en, this message translates to:
  /// **'Target Amount'**
  String get goal_amount;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get fill_all_fields;

  /// No description provided for @invalid_amount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get invalid_amount;

  /// No description provided for @email_already_taken.
  ///
  /// In en, this message translates to:
  /// **'Email already taken'**
  String get email_already_taken;

  /// No description provided for @signup_successful_message.
  ///
  /// In en, this message translates to:
  /// **'Sign up successfully'**
  String get signup_successful_message;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'an error occurred'**
  String get error;

  /// No description provided for @signup_failed.
  ///
  /// In en, this message translates to:
  /// **'Sign up failed'**
  String get signup_failed;

  /// No description provided for @verify_email.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verify_email;

  /// No description provided for @verification_message.
  ///
  /// In en, this message translates to:
  /// **'A verification email has been sent to your inbox. Please verify your email to continue.'**
  String get verification_message;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get remember_me;

  /// No description provided for @empty_monthly_target.
  ///
  /// In en, this message translates to:
  /// **'No monthly targets found. Please add a new target to get started.'**
  String get empty_monthly_target;

  /// No description provided for @error_loading_data.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Data'**
  String get error_loading_data;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @fill_in.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the fields below to add a new goal'**
  String get fill_in;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @success_target.
  ///
  /// In en, this message translates to:
  /// **'Monthly target inserted successfully'**
  String get success_target;

  /// No description provided for @client_name.
  ///
  /// In en, this message translates to:
  /// **'Client Name'**
  String get client_name;

  /// No description provided for @select_client_name.
  ///
  /// In en, this message translates to:
  /// **'Select Client Name'**
  String get select_client_name;

  /// No description provided for @select_products.
  ///
  /// In en, this message translates to:
  /// **'Select Products'**
  String get select_products;

  /// No description provided for @select_product.
  ///
  /// In en, this message translates to:
  /// **'Select Product'**
  String get select_product;

  /// No description provided for @add_item.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get add_item;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item:'**
  String get item;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @tax_number.
  ///
  /// In en, this message translates to:
  /// **'Tax number'**
  String get tax_number;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @no_clients.
  ///
  /// In en, this message translates to:
  /// **'No Clients'**
  String get no_clients;

  /// No description provided for @no_products.
  ///
  /// In en, this message translates to:
  /// **'No Products'**
  String get no_products;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @select_category.
  ///
  /// In en, this message translates to:
  /// **'Select category:'**
  String get select_category;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount:'**
  String get amount;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @enter_discount.
  ///
  /// In en, this message translates to:
  /// **'Enter discount amount:'**
  String get enter_discount;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax amount:'**
  String get tax;

  /// No description provided for @enter_tax.
  ///
  /// In en, this message translates to:
  /// **'Enter tax amount'**
  String get enter_tax;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'SubTotal:'**
  String get subtotal;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get date;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total:'**
  String get total;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @debt.
  ///
  /// In en, this message translates to:
  /// **'Debt'**
  String get debt;

  /// No description provided for @add_item_prompt.
  ///
  /// In en, this message translates to:
  /// **'Fill in all fields to add an item:'**
  String get add_item_prompt;

  /// No description provided for @unit_price.
  ///
  /// In en, this message translates to:
  /// **'Unit price:'**
  String get unit_price;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
