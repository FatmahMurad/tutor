import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutor/app/config/routes/named_routes.dart';
import 'package:tutor/app/modules/chats/domain/models/user_model.dart';
import 'package:tutor/app/modules/navbar/views/navbar_screen.dart';
import 'package:tutor/app/modules/navbar/widgets/bottom_nav_bar_tabs.dart';
import 'package:tutor/app/modules/one_to_one_chat/views/message_screen.dart';
import 'package:tutor/app/views/home.dart';
import 'package:tutor/app/views/locations.dart';
import 'package:tutor/app/views/profile.dart';
import 'package:tutor/app/views/register.dart';
import 'package:tutor/app/views/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const SizedBox();

  static final _router = GoRouter(
    initialLocation: MyNamedRoutes.root,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: MyNamedRoutes.root,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.register}",
        name: MyNamedRoutes.register,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: RegisterScreen(),
        ),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(
            tabs: BottomNavBarTabs.tabs(context),
            child: child,
          );
        },
        routes: [
          // home
          GoRoute(
              path: "/${MyNamedRoutes.homePage}",
              name: MyNamedRoutes.homePage,
              pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: const HomePage(),
                  ),
              routes: [
                //chatDetails
                GoRoute(
                  path: MyNamedRoutes.chatDetails,
                  name: MyNamedRoutes.chatDetails,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child:
                        OneToOneMessagingScreen(user: state.extra as UserModel),
                  ),
                ),
              ]),
          // locations
          GoRoute(
            path: "/${MyNamedRoutes.locations}",
            name: MyNamedRoutes.locations,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const LocationsScreen(),
            ),
          ),
          // profile
          GoRoute(
            path: "/${MyNamedRoutes.profile}",
            name: MyNamedRoutes.profile,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
