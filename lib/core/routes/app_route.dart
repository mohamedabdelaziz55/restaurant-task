import 'package:go_router/go_router.dart';
import 'package:res_task/core/Dashboard/presentation/pages/Dashboard/Dashboard.dart';
import 'package:res_task/features/auth/presentation/pages/login.dart';
import '../../features/splash/presentation/page/on_boarding_screen.dart';
import '../../features/auth/presentation/pages/sign_up.dart';
import '../../features/home/data/models/home_model/product_model.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/product_details.dart';
import '../../features/splash/presentation/page/splash_screen.dart';

abstract class AppRouter {
  static const kSplash = '/';
  static const kOnBoarding = '/onBoarding';
  static const kHomePage = '/home';
  static const kSignUp = '/signUp';
  static const kLogin = '/login';
  static const kDashboard = '/dashBoard';
  static const kProductDetailsPage = '/productDetails';

  static final router = GoRouter(
    initialLocation: kSplash,
    routes: [
      GoRoute(
        path: kOnBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ), GoRoute(
        path: kSplash,
        builder: (context, state) =>  SecondPage(),
      ),
      GoRoute(
        path: kDashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(path: kSignUp, builder: (context, state) => const SignUp()),
      GoRoute(path: kHomePage, builder: (context, state) => const HomePage()),
      GoRoute(
        path: kProductDetailsPage,
        builder: (context, state) {
          final product = state.extra as ProductModel;
          return ProductDetailsPage(product: product);
        },
      ),
      GoRoute(path: kLogin, builder: (context, state) => const Login()),
    ],
  );
}

// GoRouter.of(context).push(AppRouter.kHomeView);
