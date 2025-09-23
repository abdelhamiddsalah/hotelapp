import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelapp/core/routing/routes.dart';
import 'package:hotelapp/core/styling/colors.dart';
import 'package:hotelapp/core/validations/validations.dart';
import 'package:hotelapp/core/widgets/custom_appbar.dart';
import 'package:hotelapp/core/widgets/custom_text_formfield.dart';
import 'package:hotelapp/features/clientsauth/view/widgets/header_in_client_login.dart';
import 'package:hotelapp/features/clientsauth/view/widgets/last_row_in_auth.dart';
import 'package:hotelapp/features/employersauth/view/widgets/employer_auth_button.dart';

class ClientLoginViewBody extends StatefulWidget {
  const ClientLoginViewBody({super.key});

  @override
  _ClientLoginViewBodyState createState() => _ClientLoginViewBodyState();
}

class _ClientLoginViewBodyState extends State<ClientLoginViewBody>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();

  bool _isPasswordVisible = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: 'Join Grand Hotel',),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                HeaderInClientLogin(),
                const SizedBox(height: 40),
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
              CustomTextFormField(
                  label: 'Phone Number',
                  hintText: '+20 123 456 7890',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: AppColors.primaryColor.withOpacity(0.6),
                  ),
                  validator: Validations.phoneRegExp
                ),
                const SizedBox(height: 20),
                // Password Field
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                 CustomTextFormField(
                  label: 'Password',
                  hintText: 'Create a strong password',
                  obscureText: !_isPasswordVisible,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.primaryColor.withOpacity(0.6),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.primaryColor.withOpacity(0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: Validations.passwordRegExp
                ),
                EmployerAuthButton(onPressed: () {}, title: 'Login',),
                const SizedBox(height: 20),
                // Login Link
                LastRowInAuth(
                  text1: 'Create an account?',
                  text2: 'Sign Up',
                  onPressed: () {
                    context.go(Routes.clientSignup);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
