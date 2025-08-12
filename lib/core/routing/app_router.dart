import 'package:fit_x/features/demographics/presentation/health_connect.dart';
import 'package:fit_x/features/demographics/presentation/height_selection.dart';
import 'package:fit_x/features/demographics/presentation/medical_condition.dart';
import 'package:fit_x/features/demographics/presentation/set_things_up.dart';
import 'package:fit_x/features/demographics/presentation/setup_demographics.dart';
import 'package:fit_x/features/demographics/presentation/target_goal.dart';
import 'package:fit_x/features/demographics/presentation/target_weight.dart';
import 'package:fit_x/features/demographics/presentation/weight_selection.dart';
import 'package:fit_x/features/home/category/overview.dart';
import 'package:fit_x/features/home/presentation/home_screen.dart';
import 'package:fit_x/features/main/presentation/main_screen.dart';
import 'package:fit_x/features/device_setup/presentation/bluetooth_screen.dart';
import 'package:fit_x/features/device_setup/presentation/connection_progress.dart';
import 'package:fit_x/features/device_setup/presentation/device_onboarding1.dart';
import 'package:fit_x/features/device_setup/presentation/device_onboarding2..dart';
import 'package:fit_x/features/device_setup/presentation/device_onboarding3.dart';
import 'package:fit_x/features/auth/presentation/splash_screen.dart';
import 'package:fit_x/features/profile/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:go_router/go_router.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() => _instance;

  AppRouter._internal();

  final GoRouter _router = GoRouter(
    initialLocation: '/splashScreen',
    routes: [
      GoRoute(
        path: '/splashScreen',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/mainScreen',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/overviewScreen',
        builder: (context, state) => const Overview(),
      ),
      GoRoute(
        path: '/setupDemographics',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SetupDemographics(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      GoRoute(
        path: '/setThingsUp',
        builder: (context, state) => const SetThingsUp(),
      ),
      GoRoute(
        path: '/targetGoal',
        builder: (context, state) => const TargetGoal(),
      ),
      GoRoute(
        path: '/targetWeight',
        builder: (context, state) => const TargetWeightScreen(),
      ),
      GoRoute(
        path: '/weightSelection',
        builder: (context, state) => const WeightSelection(),
      ),
      GoRoute(
        path: '/heightSelection',
        builder: (context, state) => const HeightSelection(),
      ),
      GoRoute(
        path: '/medicalCondition',
        builder: (context, state) => const MedicalConditionsScreen(),
      ),

      GoRoute(
        path: '/appConnect',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const AppleHealthSyncScreen(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),
      GoRoute(
        path: '/onboarding1',
        builder: (context, state) => const DeviceOnboarding1(),
      ),
      GoRoute(
        path: '/onboarding2',
        builder: (context, state) => const DeviceOnboarding2(),
      ),
      GoRoute(
        path: '/onboarding3',
        builder: (context, state) => const DeviceOnboarding3(),
      ),
      GoRoute(
        path: '/bluetoothScreen',
        builder: (context, state) => const BluetoothStatusScreen(),
      ),
      GoRoute(
        path: '/profileScreen',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/homeScreen',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/connectionProgress',
        builder: (context, state) => const ConnectionProgress(),
      ),

      // Add other routes here
    ],
  );

  GoRouter get router => _router;
}
