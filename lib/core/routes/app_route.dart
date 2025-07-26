import 'package:go_router/go_router.dart';

import '../../features/OnBoard/presentation/page/on_boarding_screen.dart';
import '../../features/home/presentation/pages/home_page/home_page.dart';

abstract class AppRouter {
  static const kOnBoarding = '/';
  static const kHomePage = '/home';

  static final router = GoRouter(
    initialLocation: kOnBoarding,
    routes: [
      GoRoute(
        path: kOnBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: kHomePage,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}

// GoRouter.of(context).push(AppRouter.kHomeView);