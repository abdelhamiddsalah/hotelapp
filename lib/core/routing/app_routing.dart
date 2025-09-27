import 'package:go_router/go_router.dart';
import 'package:hotelapp/core/routing/routes.dart';
import 'package:hotelapp/features/clientsauth/view/client_auth_view.dart';
import 'package:hotelapp/features/clientsauth/view/client_login_view.dart';
import 'package:hotelapp/features/clientsdashboard/view/client_dashboard_view.dart';
import 'package:hotelapp/features/clientsdashboard/view/widgets/room_details.dart';
import 'package:hotelapp/features/employersauth/view/employers_login_view.dart';
import 'package:hotelapp/features/employersdashboard/view/employers_dashboard_view.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/add_room_widget.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/checkin_view.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/house_keeping.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/maintaince_view.dart';
import 'package:hotelapp/features/employersdashboard/view/widgets/pending_reversation.dart';
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
      ),
      GoRoute(path: Routes.employersDashboard,
      builder: (context, state) => const EmployersDashboardView(),
      ),
       GoRoute(path: Routes.pendingReservations,
       builder: (context, state) => const PendingReservationsView(),
     ),
     GoRoute(path: Routes.checkoutIn,
       builder: (context, state) => const CheckInOutView(),
     ),
      GoRoute(path: Routes.housekeeping,
        builder: (context, state) => const HousekeepingView(),
      ),
      GoRoute(path: Routes.maintenance,
        builder: (context, state) => const MaintenanceView(),
      ),
      GoRoute(path: Routes.addRoom,
        builder: (context, state) => const AddRoomWidget(),
      ),
      GoRoute(path: Routes.clientsDashboard,
        builder: (context, state) => const ClientDashboardView(),
      ),
      GoRoute(path: Routes.roomDetails,
        builder: (context, state) => RoomDetailsPage(),
      ),
    ],
  );
}
