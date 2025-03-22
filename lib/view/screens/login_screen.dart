import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_sales/app_styles.dart';
import 'package:test_sales/controller/lang_controller.dart';
import 'package:test_sales/controller/login_provider.dart';
import 'package:test_sales/controller/secure_storage_controller.dart';
import 'package:test_sales/view/widgets/button_widget.dart';
import 'package:test_sales/view/widgets/custom_header.dart';
import 'package:test_sales/view/widgets/input_widget.dart';
import '../../l10n/app_localizations.dart';

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
            child: Selector<LoginProvider, bool>(
              selector: (context, loginProvider) => loginProvider.isLoginMode,
              builder: (context, isLoginMode, _) {
                return SingleChildScrollView(
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
    final loginProvider = context.watch<LoginProvider>();

    final List<Widget> formChildren = [
      _buildTitle(context, isLoginMode),
      _buildSubtitle(context, isLoginMode),
      _buildEmailInput(context, loginProvider),
      if (!isLoginMode) _buildNameInput(context, loginProvider),
      _buildPasswordInput(context, loginProvider),
      if (!isLoginMode) _buildConfirmPasswordInput(context, loginProvider),
      if (isLoginMode) _buildRememberMeButton(context, loginProvider),
      _buildSubmitButton(context, isLoginMode, loginProvider),
      if (isLoginMode) _buildForgotPasswordButton(context),
      const SizedBox(height: 20),
      _buildSwitchModeRow(context, isLoginMode, loginProvider),
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
            fontSize: 24,
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
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context, LoginProvider loginProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Selector<LoginProvider, String?>(
        selector: (context, loginProvider) => loginProvider.errors['email'],
        builder: (context, errorText, _) {
          return InputWidget(
            textEditingController: loginProvider.emailController,
            obscureText: false,
            prefixIcon: const Icon(Icons.email),
            label: AppLocalizations.of(context)!.email,
            keyboardType: TextInputType.emailAddress,
            hintText: "demo@demo.com",
            onChanged: (value) => loginProvider.validateField(
              field: 'email',
              value: value,
              context: context,
            ),
            errorText: errorText,
          );
        },
      ),
    );
  }

  Widget _buildNameInput(BuildContext context, LoginProvider loginProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Selector<LoginProvider, String?>(
        selector: (context, loginProvider) => loginProvider.errors['name'],
        builder: (context, errorText, _) {
          return InputWidget(
            textEditingController: loginProvider.nameController,
            obscureText: false,
            keyboardType: TextInputType.name,
            prefixIcon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.user_name,
            hintText: AppLocalizations.of(context)!.enter_name,
            onChanged: (value) => loginProvider.validateField(
              field: 'name',
              value: value,
              context: context,
            ),
            errorText: errorText,
          );
        },
      ),
    );
  }

  Widget _buildPasswordInput(BuildContext context, LoginProvider loginProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Selector<LoginProvider, bool>(
        selector: (context, loginProvider) => loginProvider.obscureText,
        builder: (context, obscureText, _) {
          return InputWidget(
            textEditingController: loginProvider.passwordController,
            obscureText: obscureText,
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
              onPressed: () => loginProvider.togglePasswordVisibility(),
              icon: obscureText
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            label: AppLocalizations.of(context)!.password,
            hintText: AppLocalizations.of(context)!.password_hint,
            onChanged: (value) => loginProvider.validateField(
              field: 'password',
              value: value,
              context: context,
            ),
            errorText: loginProvider.errors['password'],
          );
        },
      ),
    );
  }

  Widget _buildConfirmPasswordInput(BuildContext context, LoginProvider loginProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 22),
      child: Selector<LoginProvider, bool>(
        selector: (context, loginProvider) => loginProvider.obscureText2,
        builder: (context, obscureText, _) {
          return InputWidget(
            textEditingController: loginProvider.confirmPasswordController,
            obscureText: obscureText,
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
              onPressed: () => loginProvider.toggleConfirmPasswordVisibility(),
              icon: obscureText
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            label: AppLocalizations.of(context)!.confirm,
            hintText: AppLocalizations.of(context)!.confirm_hint,
            onChanged: (value) => loginProvider.validateField(
              field: 'confirmPassword',
              value: value,
              context: context,
            ),
            errorText: loginProvider.errors['confirmPassword'],
          );
        },
      ),
    );
  }

  Widget _buildRememberMeButton(BuildContext context, LoginProvider loginProvider) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Selector<LoginProvider, bool>(
      selector: (context, loginProvider) => loginProvider.isRememberMeChecked,
      builder: (context, isRememberMeChecked, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 0),
          child: CheckboxListTile(
            title: Text(
              AppLocalizations.of(context)!.remember_me,
              style: AppStyles.getFontStyle(
                langController,
                color: const Color(0xFF170F4C),
                fontSize: 14,
              ),
            ),
            value: isRememberMeChecked,
            onChanged: (bool? value) async {
              loginProvider.setRememberMe(value ?? false);
              final secureStorageProvider = Provider.of<SecureStorageProvider>(context, listen: false);
              if (value == true) {
                await secureStorageProvider.saveCredentials(
                  loginProvider.emailController.text,
                  loginProvider.passwordController.text,
                );
              } else {
                await secureStorageProvider.clearCredentials();
              }
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context, bool isLoginMode, LoginProvider loginProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Selector<LoginProvider, bool>(
        selector: (context, loginProvider) => loginProvider.isLoading,
        builder: (context, isLoading, _) {
          return isLoading
              ? const Center(child: CircularProgressIndicator(color: Color(0xFF170F4C),))
              : ButtonWidget(
            buttonName: isLoginMode
                ? AppLocalizations.of(context)!.login_button
                : AppLocalizations.of(context)!.signup_button,
            buttonColor: const Color(0xFF170F4C),
            textColor: Colors.white,
            onPressed: () async {
              FocusScope.of(context).unfocus();
              loginProvider.setLoading(true);
              try {
                loginProvider.validateForm(
                  email: loginProvider.emailController.text,
                  password: loginProvider.passwordController.text,
                  confirmPassword: isLoginMode ? null : loginProvider.confirmPasswordController.text,
                  name: isLoginMode ? null : loginProvider.nameController.text,
                  context: context,
                );
                if (loginProvider.isFormValid()) {
                  final secureStorageProvider = Provider.of<SecureStorageProvider>(context, listen: false);
                  if (loginProvider.isRememberMeChecked) {
                    await secureStorageProvider.saveCredentials(
                      loginProvider.emailController.text,
                      loginProvider.passwordController.text,
                    );
                  } else {
                    await secureStorageProvider.clearCredentials();
                  }
                  if (isLoginMode) {
                    await loginProvider.signInWithEmail(
                      context,
                      loginProvider.emailController.text,
                      loginProvider.passwordController.text,
                    );
                    print("Login");

                  } else {
                    await loginProvider.signUpWithEmail(
                      context,
                      loginProvider.emailController.text,
                      loginProvider.passwordController.text,
                      loginProvider.nameController.text,
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
                loginProvider.setLoading(false);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    final langController = Provider.of<LangController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: TextButton(
        onPressed: () {
          // Implement forgot password functionality
        },
        child: Text(
          AppLocalizations.of(context)!.forgot_password,
          style: AppStyles.getFontStyle(
            langController,
            color: const Color(0xFF170F4C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchModeRow(BuildContext context, bool isLoginMode, LoginProvider loginProvider) {
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
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            _clearFields(loginProvider);
            loginProvider.setLoginMode(!isLoginMode);
          },
          child: Text(
            isLoginMode
                ? AppLocalizations.of(context)!.signup_button
                : AppLocalizations.of(context)!.login_button,
            style: AppStyles.getFontStyle(
              langController,
              color: const Color(0xFF170F4C),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _clearFields(LoginProvider loginProvider) {
    loginProvider.emailController.clear();
    loginProvider.passwordController.clear();
    loginProvider.confirmPasswordController.clear();
    loginProvider.nameController.clear();
  }

}