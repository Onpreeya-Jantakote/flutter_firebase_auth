import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  void _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showSnackbar("Please enter your email", Colors.red);
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showSnackbar("Password reset link sent to your email", Colors.green);
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context);
    } catch (e) {
      _showSnackbar("Error: ${e.toString()}", Colors.red);
    }
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔹 ไอคอนด้านบน
            const Icon(Icons.lock_reset, size: 80, color: Colors.purple),
            const SizedBox(height: 20),

            // 🔹 ข้อความอธิบาย
            const Text(
              'Enter your email and we will send you a link to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // 🔹 ช่องกรอกอีเมล
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter your email',
                prefixIcon: const Icon(Icons.email, color: Colors.purple),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // 🔹 ปุ่มส่งลิงก์ (เปลี่ยนปุ่มที่นี่ให้เป็น LinearGradient)
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
                onPressed: _resetPassword,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, padding: EdgeInsets.zero, // สีข้อความในปุ่ม
                ),
                child: const Text(
                  'Send Reset Link',
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
}
