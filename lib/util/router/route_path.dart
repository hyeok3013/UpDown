import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:up_down/component/page_not_found.dart';
import 'package:up_down/component/scaffold_with_nav_bar.dart';
import 'package:up_down/src/provider/auth_repository_provider.dart';
import 'package:up_down/src/view/auth/auth_view.dart';
import 'package:up_down/src/view/setting/setting_view.dart';
import 'package:up_down/src/view/chat/chat_view.dart';
import 'package:up_down/src/view/chat/vote/vote_view.dart';
import 'package:up_down/src/view/home/create_room/create_room_view.dart';
import 'package:up_down/src/view/home/home_view.dart';
import 'package:up_down/src/view/result/result_view.dart';
import 'package:up_down/src/view/splash/firebase_error_view.dart';
import 'package:up_down/src/view/splash/splash_view.dart';
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

      redirect: (context, state) async {
        if (authState is AsyncLoading<User?>) {
          return '/splash';
        }

        if (authState is AsyncError<User?>) {
          return '/firebaseError';
        }

        ///AsyncData
        final authenticated = authState.valueOrNull != null;

        final authenticating = (state.matchedLocation == '/auth');

        if (authenticated == false) {
          return authenticating ? null : '/auth';
        }

        final splashing = state.matchedLocation == '/splash';

        return (authenticating || splashing) ? '/home' : null;
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
          path: '/auth',
          name: RouteNames.auth,
          builder: (context, state) {
            return const AuthView();
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
                GoRoute(
                  path: '/create-room', // 방 생성 페이지 경로
                  name: RouteNames.createRoom,
                  builder: (context, state) {
                    return const CreateRoomView(); // 방 생성 페이지
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
                  routes: [
                    GoRoute(
                      path: 'vote/:roomId',
                      name: RouteNames.vote,
                      builder: (context, state) {
                        // extra에서 roomId, roomName, personName, participants 값을 가져옴
                        final extraData = state.extra as Map<String, dynamic>;

                        // 각각의 값들을 명시적으로 String 또는 List<String>으로 변환
                        final roomId = extraData['roomId'] as String;
                        final roomName = extraData['roomName'] as String;
                        final personName = extraData['personName'] as String;

                        // participants는 List<String> 타입으로 캐스팅
                        final participants = List<String>.from(
                            extraData['participants'] as List);

                        return VoteView(
                          roomId: roomId,
                          roomName: roomName,
                          personName: personName,
                          participants: participants,
                        );
                      },
                    ),
                  ],
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
                    return const SettingView();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) =>
          PageNotFound(errMsg: state.error.toString()));
}
