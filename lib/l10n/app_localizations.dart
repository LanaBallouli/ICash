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
  /// **'Please fill in all the fields'**
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

  /// No description provided for @failed_to_create_user_profile.
  ///
  /// In en, this message translates to:
  /// **'Failed to create user profile'**
  String get failed_to_create_user_profile;

  /// No description provided for @login_failed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get login_failed;

  /// No description provided for @user_already_registered.
  ///
  /// In en, this message translates to:
  /// **'User already registered'**
  String get user_already_registered;

  /// No description provided for @management_screen.
  ///
  /// In en, this message translates to:
  /// **'Management Screen'**
  String get management_screen;

  /// No description provided for @sales_men.
  ///
  /// In en, this message translates to:
  /// **'Sales Men'**
  String get sales_men;

  /// No description provided for @clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// No description provided for @remove_from_favorites_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove it from favorites?'**
  String get remove_from_favorites_confirmation;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @more_details.
  ///
  /// In en, this message translates to:
  /// **'More details'**
  String get more_details;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile Section'**
  String get profile;

  /// No description provided for @performance.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// No description provided for @recent_activity_log.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity Log'**
  String get recent_activity_log;

  /// No description provided for @assigned_clients.
  ///
  /// In en, this message translates to:
  /// **'Assigned Clients'**
  String get assigned_clients;

  /// No description provided for @assigned_salesmen.
  ///
  /// In en, this message translates to:
  /// **'Assigned Salesmen'**
  String get assigned_salesmen;

  /// No description provided for @sales_reports.
  ///
  /// In en, this message translates to:
  /// **'Sales Reports'**
  String get sales_reports;

  /// No description provided for @attendance_and_work_hours.
  ///
  /// In en, this message translates to:
  /// **'Attendance and Work Hours'**
  String get attendance_and_work_hours;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @joining_date.
  ///
  /// In en, this message translates to:
  /// **'Joining Date'**
  String get joining_date;

  /// No description provided for @total_sales.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get total_sales;

  /// No description provided for @closed_deals.
  ///
  /// In en, this message translates to:
  /// **'Closed Deals'**
  String get closed_deals;

  /// No description provided for @targets.
  ///
  /// In en, this message translates to:
  /// **'Targets'**
  String get targets;

  /// No description provided for @latest_invoice.
  ///
  /// In en, this message translates to:
  /// **'Latest Invoice'**
  String get latest_invoice;

  /// No description provided for @latest_visit.
  ///
  /// In en, this message translates to:
  /// **'Latest Visit'**
  String get latest_visit;

  /// No description provided for @login_history.
  ///
  /// In en, this message translates to:
  /// **'Login History'**
  String get login_history;

  /// No description provided for @location_based_activities.
  ///
  /// In en, this message translates to:
  /// **'Location-Based Activities'**
  String get location_based_activities;

  /// No description provided for @task_completion.
  ///
  /// In en, this message translates to:
  /// **'Task Completion Status'**
  String get task_completion;

  /// No description provided for @monthly_sales.
  ///
  /// In en, this message translates to:
  /// **'Monthly Sales'**
  String get monthly_sales;

  /// No description provided for @product_wise_sales.
  ///
  /// In en, this message translates to:
  /// **'Product-wise Sales'**
  String get product_wise_sales;

  /// No description provided for @top_customers.
  ///
  /// In en, this message translates to:
  /// **'Top Customers'**
  String get top_customers;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @delete_user.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this user?'**
  String get delete_user;

  /// No description provided for @delete_client.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this client?'**
  String get delete_client;

  /// No description provided for @confirm_deletion.
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get confirm_deletion;

  /// No description provided for @add_salesman.
  ///
  /// In en, this message translates to:
  /// **'Add New Sales Man'**
  String get add_salesman;

  /// No description provided for @field_required.
  ///
  /// In en, this message translates to:
  /// **'Field Required'**
  String get field_required;

  /// No description provided for @salesman_added.
  ///
  /// In en, this message translates to:
  /// **'SalesMan Added'**
  String get salesman_added;

  /// No description provided for @no_assigned_clients.
  ///
  /// In en, this message translates to:
  /// **'No Assigned Clients'**
  String get no_assigned_clients;

  /// No description provided for @salesman_creation.
  ///
  /// In en, this message translates to:
  /// **'A new sales man has been created.'**
  String get salesman_creation;

  /// No description provided for @error_adding_salesman.
  ///
  /// In en, this message translates to:
  /// **'Error Adding Salesman'**
  String get error_adding_salesman;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get full_name;

  /// No description provided for @name_error_2.
  ///
  /// In en, this message translates to:
  /// **'Please enter both first and last name.'**
  String get name_error_2;

  /// No description provided for @add_salesman_prompt.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all the fields to add a new sales man'**
  String get add_salesman_prompt;

  /// No description provided for @enter_salesman_name.
  ///
  /// In en, this message translates to:
  /// **'Enter the sales man\'s name'**
  String get enter_salesman_name;

  /// No description provided for @enter_salesman_password.
  ///
  /// In en, this message translates to:
  /// **'Enter the sales man\'s password'**
  String get enter_salesman_password;

  /// No description provided for @enter_salesman_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter the sales man\'s phone number'**
  String get enter_salesman_phone;

  /// No description provided for @choose_region.
  ///
  /// In en, this message translates to:
  /// **'Choose the sales man\'s region'**
  String get choose_region;

  /// No description provided for @monthly_select_target.
  ///
  /// In en, this message translates to:
  /// **'Monthly Target'**
  String get monthly_select_target;

  /// No description provided for @next_visit.
  ///
  /// In en, this message translates to:
  /// **'Next Scheduled Visit'**
  String get next_visit;

  /// No description provided for @daily_select_target.
  ///
  /// In en, this message translates to:
  /// **'Daily Target'**
  String get daily_select_target;

  /// No description provided for @select_target_prompt.
  ///
  /// In en, this message translates to:
  /// **'Enter the sales man\'s target'**
  String get select_target_prompt;

  /// No description provided for @target_error.
  ///
  /// In en, this message translates to:
  /// **'Target must be greater than 0.'**
  String get target_error;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @choose_salesman_type.
  ///
  /// In en, this message translates to:
  /// **'Choose the sales man\'s type'**
  String get choose_salesman_type;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @add_notes.
  ///
  /// In en, this message translates to:
  /// **'Add notes'**
  String get add_notes;

  /// No description provided for @type_error.
  ///
  /// In en, this message translates to:
  /// **'The sales man\'s type can\'t be empty'**
  String get type_error;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong'**
  String get something_went_wrong;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @salesman_updated.
  ///
  /// In en, this message translates to:
  /// **'The salesman\'s information has been updated.'**
  String get salesman_updated;

  /// No description provided for @client_updated.
  ///
  /// In en, this message translates to:
  /// **'The client\'s information has been updated.'**
  String get client_updated;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @add_client.
  ///
  /// In en, this message translates to:
  /// **'Add New Client'**
  String get add_client;

  /// No description provided for @add_client_prompt.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all the fields to add a new client'**
  String get add_client_prompt;

  /// No description provided for @trade_name.
  ///
  /// In en, this message translates to:
  /// **'Trade Name'**
  String get trade_name;

  /// No description provided for @salesman_name.
  ///
  /// In en, this message translates to:
  /// **'Sales man name'**
  String get salesman_name;

  /// No description provided for @choose_client_type.
  ///
  /// In en, this message translates to:
  /// **'Choose client type'**
  String get choose_client_type;

  /// No description provided for @enter_client_trade_name.
  ///
  /// In en, this message translates to:
  /// **'Enter the client\'s trade name'**
  String get enter_client_trade_name;

  /// No description provided for @enter_client_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter the client\'s phone number'**
  String get enter_client_phone;

  /// No description provided for @enter_client_address.
  ///
  /// In en, this message translates to:
  /// **'Enter the client\'s detailed address'**
  String get enter_client_address;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @address_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid address.'**
  String get address_error;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @find_location.
  ///
  /// In en, this message translates to:
  /// **'Find a specific location'**
  String get find_location;

  /// No description provided for @set_location.
  ///
  /// In en, this message translates to:
  /// **'Set Location'**
  String get set_location;

  /// No description provided for @location_services_are_disabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled.'**
  String get location_services_are_disabled;

  /// No description provided for @location_permissions_are_denied.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are denied'**
  String get location_permissions_are_denied;

  /// No description provided for @location_permissions.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are permanently denied, we cannot request permissions.'**
  String get location_permissions;

  /// No description provided for @location_permission_required.
  ///
  /// In en, this message translates to:
  /// **'Location permission required'**
  String get location_permission_required;

  /// No description provided for @person_in_charge.
  ///
  /// In en, this message translates to:
  /// **'Name of the person in charge'**
  String get person_in_charge;

  /// No description provided for @enter_person_in_charge.
  ///
  /// In en, this message translates to:
  /// **'Enter the name of person in charge'**
  String get enter_person_in_charge;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @enter_street.
  ///
  /// In en, this message translates to:
  /// **'Enter street name'**
  String get enter_street;

  /// No description provided for @building_num.
  ///
  /// In en, this message translates to:
  /// **'Building Num.'**
  String get building_num;

  /// No description provided for @enter_building_num.
  ///
  /// In en, this message translates to:
  /// **'Enter building number'**
  String get enter_building_num;

  /// No description provided for @client_id.
  ///
  /// In en, this message translates to:
  /// **'ID photo'**
  String get client_id;

  /// No description provided for @enter_client_id.
  ///
  /// In en, this message translates to:
  /// **'Enter client\'s ID photo'**
  String get enter_client_id;

  /// No description provided for @commercial_registration.
  ///
  /// In en, this message translates to:
  /// **'Commercial Registration'**
  String get commercial_registration;

  /// No description provided for @profession_license.
  ///
  /// In en, this message translates to:
  /// **'Profession License'**
  String get profession_license;

  /// No description provided for @additional_info.
  ///
  /// In en, this message translates to:
  /// **'Additional Directions'**
  String get additional_info;

  /// No description provided for @enter_additional_info.
  ///
  /// In en, this message translates to:
  /// **'Enter additional directions of the client\'s location'**
  String get enter_additional_info;

  /// No description provided for @client_creation.
  ///
  /// In en, this message translates to:
  /// **'A new client has been created.'**
  String get client_creation;

  /// No description provided for @region_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid region'**
  String get region_error;

  /// No description provided for @building_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid building number'**
  String get building_error;

  /// No description provided for @street_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid street name'**
  String get street_error;

  /// No description provided for @choose_client_region.
  ///
  /// In en, this message translates to:
  /// **'Choose the client\'s region'**
  String get choose_client_region;

  /// No description provided for @no_photos_error.
  ///
  /// In en, this message translates to:
  /// **'Please take the required photos'**
  String get no_photos_error;

  /// No description provided for @id_photo_required.
  ///
  /// In en, this message translates to:
  /// **'ID photo required'**
  String get id_photo_required;

  /// No description provided for @commercial_registration_photo_required.
  ///
  /// In en, this message translates to:
  /// **'Commercial Registration photo required'**
  String get commercial_registration_photo_required;

  /// No description provided for @profession_license_photo_required.
  ///
  /// In en, this message translates to:
  /// **'Profession License photo required'**
  String get profession_license_photo_required;

  /// No description provided for @upload_photos.
  ///
  /// In en, this message translates to:
  /// **'Upload Photos'**
  String get upload_photos;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @current_location.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get current_location;

  /// No description provided for @sales_history.
  ///
  /// In en, this message translates to:
  /// **'Sales History'**
  String get sales_history;

  /// No description provided for @average_order_value.
  ///
  /// In en, this message translates to:
  /// **'Average Order Value'**
  String get average_order_value;

  /// No description provided for @documents_section.
  ///
  /// In en, this message translates to:
  /// **'Documents and Attachments'**
  String get documents_section;

  /// No description provided for @daily_target.
  ///
  /// In en, this message translates to:
  /// **'Daily Target'**
  String get daily_target;

  /// No description provided for @monthly_target_achievement.
  ///
  /// In en, this message translates to:
  /// **'Monthly Target Achievement'**
  String get monthly_target_achievement;

  /// No description provided for @summary_of_top_customers.
  ///
  /// In en, this message translates to:
  /// **'Summary of Top Customers'**
  String get summary_of_top_customers;

  /// No description provided for @load_more.
  ///
  /// In en, this message translates to:
  /// **'Load More ..'**
  String get load_more;

  /// No description provided for @no_clients_found.
  ///
  /// In en, this message translates to:
  /// **'No clients found'**
  String get no_clients_found;

  /// No description provided for @northAmman.
  ///
  /// In en, this message translates to:
  /// **'North Amman'**
  String get northAmman;

  /// No description provided for @southAmman.
  ///
  /// In en, this message translates to:
  /// **'South Amman'**
  String get southAmman;

  /// No description provided for @eastAmman1.
  ///
  /// In en, this message translates to:
  /// **'East Amman 1'**
  String get eastAmman1;

  /// No description provided for @eastAmman2.
  ///
  /// In en, this message translates to:
  /// **'East Amman 2'**
  String get eastAmman2;

  /// No description provided for @westAmman1.
  ///
  /// In en, this message translates to:
  /// **'West Amman 1'**
  String get westAmman1;

  /// No description provided for @westAmman2.
  ///
  /// In en, this message translates to:
  /// **'West Amman 2'**
  String get westAmman2;

  /// No description provided for @zarqaAndRusseifa.
  ///
  /// In en, this message translates to:
  /// **'Zarqa and Russeifa'**
  String get zarqaAndRusseifa;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @no_invoices_available.
  ///
  /// In en, this message translates to:
  /// **'No invoices available'**
  String get no_invoices_available;

  /// No description provided for @no_visits_yet.
  ///
  /// In en, this message translates to:
  /// **'No visits yet'**
  String get no_visits_yet;

  /// No description provided for @no_next_visits_scheduled.
  ///
  /// In en, this message translates to:
  /// **'No next visits scheduled'**
  String get no_next_visits_scheduled;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;
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
