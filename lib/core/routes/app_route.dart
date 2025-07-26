import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home_page/home_page.dart';

abstract class AppRouter {
  static const kHomePage = '/HomePage';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: kHomePage, builder: (context, state) => const HomePage()),
    ],
  );
}
// GoRouter.of(context).push(AppRouter.kHomeView);