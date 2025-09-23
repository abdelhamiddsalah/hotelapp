import 'package:flutter/material.dart';
import 'package:hotelapp/core/styling/colors.dart';
import 'package:hotelapp/core/validations/validations.dart';
import 'package:hotelapp/core/widgets/custom_appbar.dart';
import 'package:hotelapp/core/widgets/custom_text_formfield.dart';
import 'package:hotelapp/features/employersauth/view/widgets/employer_auth_button.dart';
import 'package:hotelapp/features/employersauth/view/widgets/header_in_employer_aut.dart';

class EmployersLoginViewBody extends StatefulWidget {
  const EmployersLoginViewBody({super.key});

  @override
  _EmployersLoginViewBodyState createState() => _EmployersLoginViewBodyState();
}

class _EmployersLoginViewBodyState extends State<EmployersLoginViewBody> with TickerProviderStateMixin {
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
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: 'Login Employer Account'),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                HeaderInEmployerAuth(),
                const SizedBox(height: 40),
                CustomTextFormField(
                  label: 'Phone Number',
                  hintText: '+20 123 456 7890',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: AppColors.primaryColor.withOpacity(0.6),
                  ),
                  validator: Validations.phoneRegExp,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 40),
                EmployerAuthButton(onPressed: () {

                }, title: 'Login',),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
