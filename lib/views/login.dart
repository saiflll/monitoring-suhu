import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testv1/blocs/auth/bloc.dart';
import 'package:testv1/widgets/layouts/responsive_layout.dart';
import '../config/app_routes_constants.dart'; // Import AppRoutes
import '../config/color.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ResponsiveLayout(
          mobileBody: _buildMobileLayout(context), 
          tabletBody: _buildTabletLayout(context), 
          desktopBody: _buildDesktopLayout(context), 
          tvBody: _buildTvLayout(context), 
        ),
      ),
    );
  }

  // Desktop
  Widget _buildDesktopLayout(BuildContext context) {
    return Stack(
      children: [
        
        Positioned.fill(
          child: Image.asset(
            'assets/bg_login.png',
            fit: BoxFit.cover,
          ),
        ),
        // Logo
        Positioned(
          top: 32,
          left: 32,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              'assets/logo.png', 
              fit: BoxFit.contain,
            ),
          ),
        ),
        // Form
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.50),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              // ignore: deprecated_member_use
                              color: Colors.white.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(32),
                          child: const _LoginForm(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // kolom kanan
              const Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: _Illustration(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Mobile
  Widget _buildMobileLayout(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0), 
              child: _Illustration(),
            ),
            SizedBox(height: 40),
            _LoginForm(), 
          ],
        ),
      ),
    );
  }


  Widget _buildTabletLayout(BuildContext context) {
   
    return _buildMobileLayout(context);
  }


  Widget _buildTvLayout(BuildContext context) {
   
    return _buildDesktopLayout(context);
  }
}

// isi gambar
class _Illustration extends StatelessWidget {
  const _Illustration();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 250), 
      child: Image.asset(
        'assets/bg_awal.png', 
        fit: BoxFit.contain,
        height: MediaQuery.of(context).size.width * 0.5, 
      ),
    );
  }
}


class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failure && state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
        }
        if (state.status == LoginStatus.success) {
          GoRouter.of(context).goNamed(AppRoutes.home); 
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Access your account by logging in with your email and password',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          const Text('Email', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextFormField(
            onChanged: (email) => context.read<LoginBloc>().add(LoginEmailChanged(email)),
            decoration: InputDecoration(
              hintText: 'xxxxx',
              suffixIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '.miegacoan.id',
                      style: TextStyle(color:AppColors.black),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.pri,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.person, color: AppColors.white, size: 20),
                    ),
                  ],
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.pri),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Password', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextFormField(
            obscureText: true,
            onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            decoration: InputDecoration(
              hintText: '********',
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.pri,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.lock, color: Colors.white, size: 20),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.pri),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) => previous.rememberMe != current.rememberMe,
                builder: (context, state) {
                  return Row(
                    children: [
                      Checkbox(
                        value: state.rememberMe,
                        onChanged: (bool? value) {
                          context.read<LoginBloc>().add(LoginRememberMeChanged(value ?? false));
                        },
                        activeColor: AppColors.pri,
                      ),
                      const Text('Remember Me'),
                    ],
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: AppColors.pri),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.status == LoginStatus.loading
                      ? null
                      : () {
                          context.read<LoginBloc>().add(const LoginSubmitted());
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pri,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: state.status == LoginStatus.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 3, color: AppColors.white),
                        )
                      : const Text('Login Now', style: TextStyle(color: AppColors.white),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
