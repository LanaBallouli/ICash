import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/login_controller.dart';
import 'package:test_sales/controller/secure_storage_controller.dart';
import 'package:test_sales/view/screens/registration_screens/forget_pass_screen.dart';
import 'package:test_sales/view/widgets/home_widgets/button_widget.dart';
import 'package:test_sales/view/widgets/custom_header.dart';
import 'package:test_sales/view/widgets/main_widgets/input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/email_field_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/name_input_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/password_field_widget.dart';
import 'package:test_sales/view/widgets/management_widgets/add_salesman_widgets/phone_input_widget.dart';
import '../../../app_constants.dart';
import '../../../l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomHeader(),
          Expanded(
            child: Selector<LoginController, bool>(
              selector: (context, loginController) =>
                  loginController.isLoginMode,
              builder: (context, isLoginMode, _) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: _buildLoginForm(context, isLoginMode),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, bool isLoginMode) {
    final loginController = context.watch<LoginController>();

    final List<Widget> formChildren = [
      _buildTitle(context, isLoginMode),
      _buildSubtitle(context, isLoginMode),
      EmailFieldWidget(),
      if (!isLoginMode)
        NameInputWidget(
          nameController: loginController.nameController,
          title: AppLocalizations.of(context)!.name,
          hintText: AppLocalizations.of(context)!.enter_name,
        ),
      if (!isLoginMode)
        PhoneInputWidget(
          phoneController: loginController.phoneNumberController,
        ),
      PasswordFieldWidget(),
      if (!isLoginMode) _buildConfirmPasswordInput(context, loginController),
      if (isLoginMode) _rememberMeAndForgetPassword(context),
      _buildSubmitButton(context, isLoginMode, loginController),
      const SizedBox(height: 20),
      _buildSwitchModeRow(context, isLoginMode, loginController),
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: formChildren.length,
      itemBuilder: (context, index) => formChildren[index],
    );
  }

  Widget _buildTitle(BuildContext context, bool isLoginMode) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: Text(
          isLoginMode
              ? AppLocalizations.of(context)!.welcome_back
              : AppLocalizations.of(context)!.create_an_account,
          style: AppStyles.getFontStyle(
            langController,
            color: const Color(0xFF170F4C),
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context, bool isLoginMode) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Center(
        child: Text(
          isLoginMode
              ? AppLocalizations.of(context)!.please_login
              : AppLocalizations.of(context)!.please_fill,
          style: AppStyles.getFontStyle(
            langController,
            color: const Color(0xFFBBBFC5),
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordInput(
      BuildContext context, LoginController loginController) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 22),
      child: Selector<LoginController, bool>(
        selector: (context, loginController) => loginController.obscureText2,
        builder: (context, obscureText, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.confirm,
                style: AppStyles.getFontStyle(
                  langController,
                  color: Color(0xFF6C7278),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InputWidget(
                textEditingController:
                    loginController.confirmPasswordController,
                obscureText: obscureText,
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () =>
                      loginController.toggleConfirmPasswordVisibility(),
                  icon: obscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
                labelColor: Colors.grey,
                hintText: AppLocalizations.of(context)!.confirm_hint,
                onChanged: (value) => loginController.validateField(
                  field: 'confirmPassword',
                  value: value,
                  context: context,
                ),
                errorText: loginController.errors['confirmPassword'],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _rememberMeAndForgetPassword(BuildContext context) {
    LoginController loginController = Provider.of<LoginController>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: _buildRememberMeButton(context, loginController),
          ),
          _buildForgotPasswordButton(context),
        ],
      ),
    );
  }

  Widget _buildRememberMeButton(
      BuildContext context, LoginController loginController) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Selector<LoginController, bool>(
      selector: (context, loginController) =>
          loginController.isRememberMeChecked,
      builder: (context, isRememberMeChecked, _) {
        return CheckboxListTile(
          title: Text(
            AppLocalizations.of(context)!.remember_me,
            style: AppStyles.getFontStyle(
              langController,
              color: const Color(0xFF170F4C),
              fontSize: 14.sp,
            ),
          ),
          value: isRememberMeChecked,
          onChanged: (bool? value) async {
            loginController.setRememberMe(value ?? false);
            final secureStorageProvider =
                Provider.of<SecureStorageProvider>(context, listen: false);
            if (value == true) {
              await secureStorageProvider.saveCredentials(
                loginController.emailController.text,
                loginController.passwordController.text,
              );
            } else {
              await secureStorageProvider.clearCredentials();
            }
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        );
      },
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgetPassScreen(),
          ),
        );
      },
      child: Text(
        AppLocalizations.of(context)!.forgot_password,
        style: AppStyles.getFontStyle(
          langController,
          color: AppConstants.primaryColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
      BuildContext context, bool isLoginMode, LoginController loginController) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Selector<LoginController, bool>(
        selector: (context, loginController) => loginController.isLoading,
        builder: (context, isLoading, _) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Color(0xFF170F4C),
                ))
              : ButtonWidget(
                  buttonName: isLoginMode
                      ? AppLocalizations.of(context)!.login_button
                      : AppLocalizations.of(context)!.signup_button,
                  buttonColor: const Color(0xFF170F4C),
                  textColor: Colors.white,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    loginController.setLoading(true);
                    try {
                      loginController.validateForm(
                          email: loginController.emailController.text,
                          password: loginController.passwordController.text,
                          confirmPassword: isLoginMode
                              ? null
                              : loginController.confirmPasswordController.text,
                          name: isLoginMode
                              ? null
                              : loginController.nameController.text,
                          context: context,
                          phone: isLoginMode
                              ? null
                              : loginController.phoneNumberController.text);
                      if (loginController.isFormValid()) {
                        final secureStorageProvider =
                            Provider.of<SecureStorageProvider>(context,
                                listen: false);
                        if (loginController.isRememberMeChecked) {
                          await secureStorageProvider.saveCredentials(
                            loginController.emailController.text,
                            loginController.passwordController.text,
                          );
                        } else {
                          await secureStorageProvider.clearCredentials();
                        }
                        if (isLoginMode) {
                          await loginController.signInWithEmail(
                            context,
                            loginController.emailController.text,
                            loginController.passwordController.text,
                          );
                          print("Login");
                        } else {
                          await loginController.signUpWithEmail(
                            context,
                            loginController.emailController.text,
                            loginController.passwordController.text,
                            loginController.nameController.text,
                          );
                          print("sign up");
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFFE7F4FF),
                            content: Text(
                              AppLocalizations.of(context)!.error,
                              style: GoogleFonts.cabin(
                                color: const Color(0xFF170F4C),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }
                    } finally {
                      loginController.setLoading(false);
                    }
                  },
                );
        },
      ),
    );
  }

  Widget _buildSwitchModeRow(
      BuildContext context, bool isLoginMode, LoginController loginController) {
    final langController = Provider.of<LangController>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLoginMode
              ? AppLocalizations.of(context)!.signup_prompt
              : AppLocalizations.of(context)!.login_prompt,
          style: AppStyles.getFontStyle(
            langController,
            color: Colors.grey,
            fontSize: 14.sp,
          ),
        ),
        TextButton(
          onPressed: () {
            _clearFields(loginController);
            loginController.setLoginMode(!isLoginMode);
          },
          child: Text(
            isLoginMode
                ? AppLocalizations.of(context)!.signup_button
                : AppLocalizations.of(context)!.login_button,
            style: AppStyles.getFontStyle(
              langController,
              color: const Color(0xFF170F4C),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _clearFields(LoginController loginController) {
    loginController.emailController.clear();
    loginController.passwordController.clear();
    loginController.confirmPasswordController.clear();
    loginController.nameController.clear();
  }
}
