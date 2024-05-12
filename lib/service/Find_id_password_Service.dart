// LoginService.dart

import 'package:firebase_auth/firebase_auth.dart';

class FindService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // 이메일로 등록된 아이디 찾기
  Future<String?> findIdWithEmail(String email, String name) async {
    try {
      var result = await _auth.fetchSignInMethodsForEmail(email);
      if (result.isNotEmpty) {
        return result.first;
      } else {
        return null;
      }
    } catch (e) {
      print('아이디 찾기 오류: $e');
      return null;
    }
  }

  // 비밀번호 재설정 이메일 보내기
  Future<bool> sendPasswordResetEmail(String email, String name, String phone) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print('비밀번호 재설정 이메일 보내기 오류: $e');
      return false;
    }
  }
}
