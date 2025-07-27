import 'package:go_router/go_router.dart';
import 'package:res_task/features/auth/presentation/pages/login.dart';

import '../../features/OnBoard/presentation/page/on_boarding_screen.dart';
import '../../features/auth/presentation/pages/sign_up.dart';
import '../../features/home/presentation/pages/home_page/home_page.dart';

abstract class AppRouter {
  static const kOnBoarding = '/';
  static const kHomePage = '/home';
  static const kSignUp = '/signUp';
  static const kLogin = '/login';

  static final router = GoRouter(
    initialLocation: kOnBoarding,
    routes: [
      GoRoute(
        path: kOnBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),GoRoute(
        path: kSignUp,
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: kHomePage,
        builder: (context, state) => const HomePage(),
      ),GoRoute(
        path: kLogin,
        builder: (context, state) => const Login(),
      ),
    ],
  );
}

// GoRouter.of(context).push(AppRouter.kHomeView);