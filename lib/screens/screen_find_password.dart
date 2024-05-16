import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkk_shop/service/Find_id_password_Service.dart';
import 'package:kkk_shop/service/Find_Password_Service.dart';

import '../service/LoginService.dart';

class PasswordRecoveryScreen extends StatelessWidget {

  PasswordCheckService passwordCheckService = PasswordCheckService();

  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController(); // Add this line

    return Scaffold(
      appBar: AppBar(title: Text('비밀번호 찾기')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('가입 시 등록한 정보를 입력하세요.'), // Update this line
            SizedBox(height: 20),
            TextField(
              controller: idController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: '아이디',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: '이름',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone, // Change keyboard type
              decoration: InputDecoration(
                labelText: '핸드폰 번호',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {

                passwordCheckService.findPasswordWithIdAndNameAndPhone(
                  idController.text.trim(),
                  nameController.text.trim(),
                  phoneController.text.trim(),
                );

                String id = idController.text.trim();
                String name = nameController.text.trim();
                String phone = phoneController.text.trim(); // Retrieve phone number
                bool emailSent = await FindService().sendPasswordByEmail(id, name, phone); // Update this line
                if (emailSent) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('비밀번호 재설정 링크를 이메일로 전송했습니다.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('입력한 정보로 등록된 계정이 없습니다.')),
                  );
                }
              },
              child: Text('이메일 전송'),
            ),
          ],
        ),
      ),
    );
  }
}
