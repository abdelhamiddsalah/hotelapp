import 'package:go_router/go_router.dart';
import 'package:hotelapp/core/routing/routes.dart';
import 'package:hotelapp/features/clientsauth/view/client_auth_view.dart';
import 'package:hotelapp/features/clientsauth/view/client_login_view.dart';
import 'package:hotelapp/features/employersauth/view/employers_login_view.dart';
import 'package:hotelapp/features/onboarding/view/onboarding_view.dart';
import 'package:hotelapp/features/onboarding/view/widgets/learn_more.dart';
import 'package:hotelapp/features/splash/view/splash_view.dart';
import 'package:hotelapp/features/userchoice/view/userchoice_view.dart';

class AppRouting {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splah,
    routes: <GoRoute>[
      GoRoute(
        path: Routes.splah,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: Routes.learnMore,
        builder: (context, state) => const ExploreMoreScreen(),
      ),
      GoRoute(
        path: Routes.clientSignup,
        builder: (context, state) => const ClientAuthView(),
      ),
      GoRoute(
        path: Routes.clientLogin,
        builder: (context, state) => const ClientLoginView(),
      ),
      GoRoute(
        path: Routes.userChoice,
        builder: (context, state) => const UserchoiceView(),
      ),
      GoRoute(path: Routes.employerLogin,
      builder: (context, state) => const EmployersLoginView(),
      )
    ],
  );
}
