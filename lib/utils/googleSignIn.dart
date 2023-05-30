import 'package:google_sign_in/google_sign_in.dart';

class MyGoogleSignIn {
  static MyGoogleSignIn? _instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  MyGoogleSignIn._();
  MyGoogleSignIn.signInSilently();

  static MyGoogleSignIn get instance {
    print(_instance);
    _instance ??= MyGoogleSignIn._();
    return _instance!;
  }

  Stream<GoogleSignInAccount?> get onCurrentUserChanged {
    return _googleSignIn.onCurrentUserChanged;
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
      print('로그인 성공');
    } catch (error) {
      print('로그인 실패');
      print(error);
    }
  }

  Future<void> signOut(onSuccess) async {
    try {
      await _googleSignIn.disconnect();
      print('로그이웃 성공');
      if (onSuccess != null) onSuccess();
    } catch (error) {
      print('로그이웃 실패');
      print(error);
    }
  }
}
