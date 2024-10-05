import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kUser;
import 'package:up_down/util/helper/firebase_helper.dart';
import 'package:up_down/util/helper/handle_exception.dart';

class AuthRepository {
  User? get currentUser => fbAuth.currentUser;
  final googleSignIn = GoogleSignIn();

  ///Auth
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await fbAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user!;

      await usersCollection.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
        // 'photo': photo.url,
        'isAdmin': false,
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> signInWithKakao() async {
    try {
      kUser.OAuthToken token;

      // 카카오톡 실행 가능 여부 확인 후 로그인 진행
      if (await kUser.isKakaoTalkInstalled()) {
        token = await kUser.UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
      } else {
        token = await kUser.UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      }

      // 카카오 로그인 후 토큰 확인
      final accessToken = token.accessToken; // 액세스 토큰
      final idToken = token.idToken; // ID 토큰 (null일 수 있음, OIDC 설정에 따라 다름)

      // Firebase OAuthProvider 설정
      var provider = OAuthProvider("oidc.updown");

      // 자격 증명 생성
      final credential = provider.credential(
        idToken: idToken, // OIDC 설정에서 ID 토큰이 필요하다면 사용
        accessToken: accessToken,
      );

      // Firebase 인증 완료
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final firebaseUser = userCredential.user;
      print('Firebase 인증 성공');

      // 카카오 사용자 정보 가져오기
      kUser.User kakaoUser = await kUser.UserApi.instance.me();

      // Firestore에 사용자 정보 저장
      await usersCollection.doc(firebaseUser!.uid).set({
        'name': kakaoUser.kakaoAccount?.profile?.nickname ?? 'No Name',
        'email': kakaoUser.kakaoAccount?.email ?? 'No Email',
        'profileImage': kakaoUser.kakaoAccount?.profile?.profileImageUrl ?? '',
        'isAdmin': false,
      }, SetOptions(merge: true)); // 기존 데이터에 덮어쓰기하지 않고 병합

      print('Firestore에 사용자 정보 저장 완료');
    } catch (error) {
      print('카카오 로그인 실패: $error');
      throw handleException(error);
    }
  }

  Future<void> logoutWithKakao() async {
    try {
      await kUser.UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  //     if (googleUser == null) {
  //       return;
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final newUser = await _auth.signInWithCredential(credential);

  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(newUser.user!.uid)
  //         .set({
  //       'name': newUser.user!.displayName,
  //       'email': newUser.user!.email,
  //       // 'photo': photo.url,
  //       'isAdmin': false,
  //     });

  //     context.go('/home');
  //   } catch (e) {
  //     print('Error signing in with Google: $e');

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to sign in with Google: $e')),
  //     );
  //   }
  // }
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in aborted');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final newUser = await fbAuth.signInWithCredential(credential);

      await usersCollection.doc(newUser.user!.uid).set({
        'name': newUser.user!.displayName,
        'email': newUser.user!.email,
        // 'photo': photo.url,
        'isAdmin': false,
      });
    } catch (e) {
      print('google error: $e');
      throw handleException(e);
    }
  }

  //페이스북 로그인
  Future<void> signInWithFacebook() async {
    //^
    try {
      final LoginResult result = await FacebookAuth.instance.login(); //^

      if (result.status == LoginStatus.success) {
        //^
        final AccessToken accessToken = result.accessToken!; //^

        final credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        final newUser = await fbAuth.signInWithCredential(credential); //^

        if (newUser.additionalUserInfo?.isNewUser ?? false) {
          //^
          await usersCollection.doc(newUser.user!.uid).set({
            //^
            'name': newUser.user!.displayName, //^
            'email': newUser.user!.email, //^
            'isAdmin': false, //^
          }); //^
        }
      } else {
        throw Exception('Facebook sign in failed: ${result.status}'); //^
      }
    } catch (e) {
      print('facebook error: $e'); //^
      throw handleException(e); //^
    }
  }

  // Future<void> signInWithFacebook() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login();
  //     if (result.status == LoginStatus.success) {
  //       final OAuthCredential credential =
  //           FacebookAuthProvider.credential(result.accessToken!.tokenString);
  //       final userCredential = await fbAuth.signInWithCredential(credential);
  //       // 사용자 정보를 Firestore에 저장하는 로직 추가
  //     } else {
  //       throw Exception('Facebook sign in failed: ${result.status}');
  //     }
  //   } catch (e) {
  //     print('Facebook error: $e');
  //     throw handleException(e);
  //   }
  // }

  Future<void> signout() async {
    try {
      await fbAuth.signOut();
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> changePassword(String password) async {
    try {
      await currentUser!.updatePassword(password);
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> changeName(String newName) async {
    try {
      await currentUser!.updateProfile(displayName: newName);
      await currentUser!.reload();

      // Firestore에서 사용자 이름 업데이트
      await usersCollection.doc(currentUser!.uid).update({
        'name': newName,
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await fbAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw handleException(e);
    }
  }

// Future<void> sendEmailVerification() async {
//   try {
//     await currentUser!.sendEmailVerification();
//   } catch (e) {
//     throw handleException(e);
//   }
// }

  Future<void> reloadUser() async {
    try {
      await currentUser!.reload();
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> reauthenticateWithCredential(
    String email,
    String password,
  ) async {
    try {
      await currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: password),
      );
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await usersCollection.doc(currentUser!.uid).delete();
      await currentUser!.delete();
    } catch (e) {
      throw handleException(e);
    }
  }
}
