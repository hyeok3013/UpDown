import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/component/page_not_found.dart';
import 'package:up_down/component/scaffold_with_nav_bar.dart';
import 'package:up_down/src/view/auth/reset_password/reset_password_view.dart';
import 'package:up_down/src/view/auth/signin/signin_view.dart';
import 'package:up_down/src/view/auth/signup/signup_view.dart';
import 'package:up_down/src/view/auth/verify_email/verify_email_view.dart';
import 'package:up_down/src/view/chat/chat_view.dart';
import 'package:up_down/src/view/home/home_view.dart';
import 'package:up_down/src/view/result/result_view.dart';
import 'package:up_down/src/view/setting/change_password/change_password_view.dart';
import 'package:up_down/src/view/splash/firebase_error_view.dart';
import 'package:up_down/src/view/splash/splash_view.dart';
import 'package:up_down/util/router/route_names.dart';

part 'route_path.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter route(RouteRef ref) {
  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/splash',
          name: RouteNames.splash,
          builder: (context, state) {
            print('##### Splash #####');
            return const SplashView();
          },
        ),
        GoRoute(
          path: '/firebaseError',
          name: RouteNames.firebaseError,
          builder: (context, state) {
            return const FirebaseErrorView();
          },
        ),
        GoRoute(
          path: '/signin',
          name: RouteNames.signin,
          builder: (context, state) {
            return const SigninView();
          },
        ),
        GoRoute(
          path: '/signup',
          name: RouteNames.signup,
          builder: (context, state) {
            return const SignupView();
          },
        ),
        GoRoute(
          path: '/resetPassword',
          name: RouteNames.resetPassword,
          builder: (context, state) {
            return const ResetPasswordView();
          },
        ),
        GoRoute(
          path: '/verifyEmail',
          name: RouteNames.verifyEmail,
          builder: (context, state) {
            return const VerifyEmailView();
          },
        ),

        ///Bottom Navigation
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNavBar(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  name: RouteNames.home,
                  builder: (context, state) {
                    return const HomeView();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/chat',
                  name: RouteNames.chat,
                  builder: (context, state) {
                    return const ChatView();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/result',
                  name: RouteNames.result,
                  builder: (context, state) {
                    return const ResultView();
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/setting',
                  name: RouteNames.setting,
                  builder: (context, state) {
                    return const Placeholder();
                  },
                  routes: [
                    GoRoute(
                      path: 'changePassword',
                      name: RouteNames.changePassword,
                      builder: (context, state) {
                        return const ChangePasswordView();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) =>
          PageNotFound(errMsg: state.error.toString()));
}
