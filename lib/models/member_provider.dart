import 'package:flutter/material.dart';
import 'package:kkk_shop/models/user_model/user_model.dart';

class MemberProvider extends ChangeNotifier {
  Member? _member;

  Member? get member => _member;

  void setMember(Member member) {
    _member = member;
    notifyListeners();
  }
}
