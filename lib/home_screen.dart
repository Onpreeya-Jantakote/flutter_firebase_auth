import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/main.dart';
import 'package:flutter_firebase_auth/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      backgroundColor: Colors.purple[50], // สีพื้นหลังที่ดูสดใส
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ยินดีต้อนรับ
            const Text(
              "Welcome User",
              style: TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                shadows: [
                  Shadow(color: Colors.black38, offset: Offset(2, 2), blurRadius: 5),
                ],
              ),
            ),
            const SizedBox(height: 30), // เพิ่มระยะห่าง

            // ไอคอนหรือรูปภาพแสดงให้ดูดีขึ้น
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30), // เพิ่มระยะห่าง

            // ปุ่ม Sign Out ด้วย LinearGradient
            Container(
              width: 180,
              height: 42,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple], // สีน้ำเงินฟ้าและม่วง
                  begin: Alignment.topLeft, // เริ่มเกรเดียนจากมุมซ้ายบน
                  end: Alignment.bottomRight, // ไปยังมุมขวาล่าง
                ),
                borderRadius: BorderRadius.circular(30), // ทำให้มุมของปุ่มโค้ง
              ),
              child: TextButton(
                onPressed: () async {
                  await auth.signout();
                  goToLogin(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, padding: EdgeInsets.zero, // สีข้อความในปุ่ม
                ),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // สีของข้อความในปุ่ม
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainApp()),
      );
}
