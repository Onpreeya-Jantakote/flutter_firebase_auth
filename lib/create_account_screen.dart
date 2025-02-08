import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> createAccount() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showSnackbar('Please fill in all fields', Colors.red);
      return;
    }
    if (password != confirmPassword) {
      _showSnackbar('Passwords do not match', Colors.red);
      return;
    }

    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _showSnackbar('Account created successfully!', Colors.green);

      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showSnackbar('The password is too weak.', Colors.red);
      } else if (e.code == 'email-already-in-use') {
        _showSnackbar('This email is already in use.', Colors.red);
      } else {
        _showSnackbar(e.message ?? 'An error occurred', Colors.red);
      }
    } catch (e) {
      _showSnackbar('An unexpected error occurred.', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // พื้นหลังสีขาว
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🔹 หัวข้อใหญ่
              const Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
              ),
              const SizedBox(height: 10),

              // 🔹 คำอธิบาย
              const Text(
                'Sign up to get started',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // 🔹 ช่องกรอกอีเมล
              _buildTextField(_emailController, 'Email', Icons.email, false, null),
              const SizedBox(height: 16.0),

              // 🔹 ช่องกรอกรหัสผ่าน
              _buildTextField(_passwordController, 'Password', Icons.lock, true, () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              }),
              const SizedBox(height: 16.0),

              // 🔹 ช่องยืนยันรหัสผ่าน
              _buildTextField(_confirmPasswordController, 'Confirm Password', Icons.lock_outline, true, () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              }),
              const SizedBox(height: 24.0),

              // 🔹 ปุ่มสร้างบัญชี (เปลี่ยนสไตล์ที่นี่)
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
                  onPressed: createAccount,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, padding: EdgeInsets.zero, // สีข้อความในปุ่ม
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // สีของข้อความในปุ่ม
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 ปุ่มย้อนกลับไปหน้า Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    bool isPassword,
    VoidCallback? toggleVisibility,
  ) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? (label == 'Password' ? !_isPasswordVisible : !_isConfirmPasswordVisible) : false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.purple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.purple, width: 2),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  (label == 'Password' ? _isPasswordVisible : _isConfirmPasswordVisible)
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.purple,
                ),
                onPressed: toggleVisibility,
              )
            : null,
      ),
    );
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
}
