import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotelapp/core/routing/routes.dart';
import 'package:hotelapp/core/styling/colors.dart';
import 'package:hotelapp/core/validations/validations.dart';
import 'package:hotelapp/core/widgets/custom_appbar.dart';
import 'package:hotelapp/core/widgets/custom_text_formfield.dart';
import 'package:hotelapp/features/clientsauth/view/widgets/header_in_client_auth.dart';
import 'package:hotelapp/features/clientsauth/view/widgets/last_row_in_auth.dart';
import 'package:hotelapp/features/employersauth/view/widgets/employer_auth_button.dart';

class ClientAuthViewBody extends StatefulWidget {
  const ClientAuthViewBody({super.key});

  @override
  _ClientAuthViewBodyState createState() => _ClientAuthViewBodyState();
}

class _ClientAuthViewBodyState extends State<ClientAuthViewBody>
    with TickerProviderStateMixin {
  String? _selectedState;
  bool _isPasswordVisible = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<String> _states = [
    'Single', // أعزب / أنسة
    'Married', // متزوج / متزوجة
    'Divorced', // مطلق / مطلقة
    'Widowed', // أرمل / أرملة
    'Separated', // منفصل
  ];

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
      appBar: CustomAppBar(title: 'Join Grand Hotel'),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                HeaderInClientAuth(),
                const SizedBox(height: 40),
                // Name Field
                Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppColors.primaryColor.withOpacity(0.6),
                  ),
                  validator: Validations.nameRegExp
                ),
                const SizedBox(height: 20),
                // Phone Field
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
                // Age Field
                Text(
                  'Age',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  label: 'Age',
                  hintText: 'Enter your age',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(
                    Icons.cake_outlined,
                    color: AppColors.primaryColor.withOpacity(0.6),
                  ),
                  validator: Validations.ageRegExp
                ),
                const SizedBox(height: 20),
                // State Dropdown
                Text(
                  'State',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedState,
                  decoration: InputDecoration(
                    hintText: 'Select your state',
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primaryColor.withOpacity(0.6),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.secondaryColor,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.cardColor,
                  ),
                  items: _states.map((String state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedState = newValue;
                    });
                  },
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
                const SizedBox(height: 40),
             EmployerAuthButton(onPressed: () {}, title: 'Create Account',),
                const SizedBox(height: 20),
                LastRowInAuth(
                  text1: 'Already have an account?',
                  text2: 'Sign in',
                  onPressed: () {
                    context.go(Routes.clientLogin);
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
