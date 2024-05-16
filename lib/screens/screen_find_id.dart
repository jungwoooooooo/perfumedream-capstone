import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkk_shop/service/Find_Id_Service.dart';
import 'package:kkk_shop/service/Find_id_password_Service.dart';

class IdRecoveryScreen extends StatelessWidget {

  IdCheckService idCheckService = IdCheckService();
  FindService findService = FindService(); // Add this line

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController(); // Add this line

    return Scaffold(
      appBar: AppBar(title: Text('아이디 찾기')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('가입 시 등록한 이름과 이메일 주소를 입력하세요.'), // Update this line
            SizedBox(height: 20),

            SizedBox(height: 20),
            TextField( // Add this widget
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: '이름',
              ),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: '이메일',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {

                idCheckService.findIdWithEmailAndName(
                  nameController.text.trim(),
                  emailController.text.trim(),
                );

                String email = emailController.text.trim();
                String name = nameController.text.trim(); // Retrieve name
                String? id = await findService.findIdWithEmail(name, email); // Update this line
                bool emailSent = await findService.sendUserInfoByEmail(email, name); // Update this line
                if (id != null && emailSent) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('찾은 아이디: $id, 정보를 이메일로 전송했습니다.')), // Update this line
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('입력한 정보로 등록된 아이디가 없거나 이메일 전송에 실패했습니다.')), // Update this line
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
