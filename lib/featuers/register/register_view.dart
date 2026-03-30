import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:opporto_project/featuers/profile/create_profile.dart';
import 'package:opporto_project/core/ui/onboarding3.dart';
import 'package:opporto_project/core/utils/app_assets.dart';
import 'package:opporto_project/core/utils/app_colors.dart';
import 'package:opporto_project/core/utils/app_fonts.dart';
import 'package:opporto_project/core/widget/Custom_text_form_field.dart';
import 'package:opporto_project/core/widget/custom_buttom.dart';
import 'package:opporto_project/core/widget/drop_down_button.dart';
import 'package:opporto_project/core/services/auth_service.dart';
import 'package:opporto_project/core/provider/user_provider.dart';
import 'package:opporto_project/l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool isLoading = false;
  bool _isEmailValid = true;
  String? selectedRole;
  Timer? _debounceTimer;
  final List<String> roles = ['Job Seeker', 'Employer'];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _nameFocus.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _debugPrintFormState() {
    print('=== DEBUG FORM STATE ===');
    print('Form valid: ${_formKey.currentState?.validate() ?? false}');
    print('Name: "${nameController.text}"');
    print('Email: "${emailController.text}"');
    print('Phone: "${phoneController.text}"');
    print('Password: "${passwordController.text.length} chars"');
    print('Role: $selectedRole');
    print('=======================');
  }

  Future<void> _handleRegister() async {
    print(' REGISTER BUTTON PRESSED');
    _debugPrintFormState();


    if (!_formKey.currentState!.validate() || selectedRole == null) {
      print(' Validation Failed');
      _showError('Please fill all fields correctly and select a role');
      return;
    }

    setState(() => isLoading = true);

    try {
      final email = emailController.text.trim();

      print(' Calling AuthService.register...');

      final result = await AuthService.register(
        name: nameController.text.trim(),
        email: email,
        phone: phoneController.text.trim(),
        password: passwordController.text,
        rolePreference: selectedRole!,
      );

      print(' API Response: $result');

      if (result['success']) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final responseData = result['data'];

        await userProvider.setUser(responseData['user'], responseData['token']);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                selectedRole == 'Job Seeker'
                    ? 'Welcome Job Seeker! '
                    : 'Welcome Employer! ',
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => CreateProfile(
                fullName: responseData['user']['name'] ?? '',
                address: responseData['user']['address'] ?? '',
                phone: responseData['user']['phone'] ?? '',
                email: responseData['user']['email'] ?? '',
                role: selectedRole!,
              ),
            ),
          );
        }
      } else {
        _showError(result['message'] ?? 'Registration Failed');
      }
    } catch (e) {
      print(' Error: $e');
      _showError('Connection Error: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _onEmailChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _isEmailValid = value.isEmpty ||
            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim());
      });
    });
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.movColor),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Onboarding3()),
          ),
        ),
        title:  Text(
          'Create New Account',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.05),
                 Column(
                   children: [
                     Image.asset(AppAssets.register,width: double.infinity,fit: BoxFit.fill,)
                   ],
                 ),


                SizedBox(height: height * 0.02),


                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Choose Your Role ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        padding:  EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          border: selectedRole != null
                              ? Border.all(color: AppColors.movColor, width: 2)
                              : Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                          color: selectedRole != null
                              ? AppColors.movColor
                              : Colors.grey.shade50,
                          boxShadow: selectedRole != null
                              ? [BoxShadow(
                              color: AppColors.movColor,

                          )]
                              : null,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: CustomDropDownButton(
                            hint: selectedRole ?? 'Tap to select Job Seeker or Employer',
                            value: selectedRole,
                            items: roles
                                .map((role) => DropdownMenuItem(
                              value: role,
                              child: Row(
                                children: [
                                  Icon(
                                    role == 'Job Seeker' ? Icons.work : Icons.business,
                                    color: AppColors.movColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(role, style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedRole = value;
                              });
                              print(' Role selected: $value');
                            },
                          ),
                        ),
                      ),
                      if (selectedRole == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 8, left: 16),
                          child: Text(
                            'Role selection is required *',
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ),
                      SizedBox(height: height * 0.03),


                      ...[

                        {
                          'label': 'Full Name *',
                          'controller': nameController,
                          'focus': _nameFocus,
                          'hint': 'Enter your full name',
                          'icon': CupertinoIcons.person,
                          'nextFocus': _emailFocus,
                          'validator': (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Full Name is required ';
                            }
                            if (value.trim().length < 3) {
                              return 'Name must be at least 3 characters';
                            }
                            return null;
                          },
                        },

                        {
                          'label': 'Email *',
                          'controller': emailController,
                          'focus': _emailFocus,
                          'hint': 'example@email.com',
                          'icon': CupertinoIcons.mail,
                          'keyboard': TextInputType.emailAddress,
                          'nextFocus': _phoneFocus,
                          'onChanged': _onEmailChanged,
                          'validator': (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required *';
                            }
                            if (!_isEmailValid) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        },

                        {
                          'label': 'Phone Number *',
                          'controller': phoneController,
                          'focus': _phoneFocus,
                          'hint': '+201000000000',
                          'icon': CupertinoIcons.phone,
                          'keyboard': TextInputType.phone,
                          'nextFocus': _passwordFocus,
                          'validator': (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Phone is required *';
                            }
                            if (!RegExp(r'^\+?\d{10,15}$')
                                .hasMatch(value.trim().replaceAll(' ', ''))) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        },

                        {
                          'label': 'Password *',
                          'controller': passwordController,
                          'focus': _passwordFocus,
                          'hint': 'Minimum 8 characters',
                          'icon': CupertinoIcons.padlock_solid,
                          'isPassword': true,
                          'validator': (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required *';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                        },
                      ].map((field) => _buildField(field)).toList(),

                      SizedBox(height: height * 0.05),

                      SizedBox(
                        width: width * 0.95,
                        height: height * 0.08,
                        child: ElevatedButton(
                          onPressed: isLoading || selectedRole == null
                              ? null
                              : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.movColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: selectedRole != null ? 8 : 2,
                            shadowColor: AppColors.movColor.withOpacity(0.4),
                          ),
                          child: isLoading
                              ? const SizedBox(
                            height: 22,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_circle, size: 24),
                              SizedBox(width: 12),
                              Text(
                                "Create ${selectedRole ?? 'Account'} Now",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.1),
                    ],
                  ),
                ),
              ],
            ),
          ),


          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.movColor),
                    SizedBox(height: 16),
                    Text(
                      'Creating your account...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildField(Map<String, dynamic> field) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field['label'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: height * 0.01),
        CustomTextFormField(
          controller: field['controller'],
          focusNode: field['focus'],
          hintText: field['hint'],
          prefixIconData: field['icon'],
          keyboardType: field['keyboard'],
          isPassword: field['isPassword'] ?? false,
          textInputAction: field['nextFocus'] != null
              ? TextInputAction.next
              : TextInputAction.done,
          onFieldSubmitted: field['nextFocus'] != null
              ? (_) => field['nextFocus'].requestFocus()
              : null,

          validator: field['validator'],
        ),
        SizedBox(height: height * 0.015),
      ],
    );
  }
}