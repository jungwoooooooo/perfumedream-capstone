import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/model_item_provider.dart';
import '../models/product_model.dart';

class LoginService {
  //static const _url = "$baseUrl/member";
  //FirebaseAuth _auth = FirebaseAuth.instance;
  //AuthService._();

  Future<void> saveMember(User user) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/member/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Not-Using-Xquare-Auth': 'true',
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        print("User Data sent successfully");
        Get.to(ItemProvider());
      }
    } catch (e) {
      print("Failed to send user data: ${e}");
    }
  }
}

/*  String memberId, String password, String age, String name,String phone, String email) async {
    var uri = Uri.parse("http://10.0.2.2:3306/join");
    Map<String, String> headers = {"Content-Type": "member/json"};

    Map data = {
      'memberId': '$memberId',
      'password': '$password',
      'age': '$age',
      'phone': '$phone',
      'email': '$email',
      'name': '$name'
    };
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    print("${response.body}");

    return response;
  }
*/
