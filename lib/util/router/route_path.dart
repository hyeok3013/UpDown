import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/component/page_not_found.dart';
import 'package:up_down/component/scaffold_with_nav_bar.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';
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
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/router/route_names.dart';

part 'route_path.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter route(RouteRef ref) {
  final authState = ref.watch(authStateStreamProvider);

  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/splash',

      ///웹에서 다른 주소로 접속을 할 때 redirect을 사용해서 잘못된 접근을 막을 수 있음.
      ///앱에서는 상대적으로 덜 중요해서 로그인의 여부만 잘 관리해도 될 것 같음.

      redirect: (context, state) {
        if (authState is AsyncLoading<User?>) {
          return '/splash';
        }

        if (authState is AsyncError<User?>) {
          return '/firebaseError';
        }

        ///AsyncData
        final authenticated = authState.valueOrNull != null;

        final authenticating = (state.matchedLocation == '/signin') ||
            (state.matchedLocation == '/signup') ||
            (state.matchedLocation == 'resetPassword');

        if (authenticated == false) {
          return authenticating ? null : '/signin';
        }

        if (!fbAuth.currentUser!.emailVerified) {
          return '/verifyEmail';
        }

        final verifyingEmail = state.matchedLocation == '/verifyEmail';
        final splashing = state.matchedLocation == '/splash';

        return (authenticating || verifyingEmail || splashing) ? '/home' : null;
      },
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
