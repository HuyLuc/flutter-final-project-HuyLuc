import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Trang đăng ký
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Hàm kiểm tra xem email hoặc tên đã tồn tại chưa
  Future<bool> checkIfUserExists(String email, String name) async {
    try {
      // Kiểm tra email có trong collection 'users' không
      QuerySnapshot emailQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      // Kiểm tra tên có trong collection 'users' không
      QuerySnapshot nameQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: name)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        // Nếu có email trùng
        return true; // Email đã tồn tại
      } else if (nameQuery.docs.isNotEmpty) {
        // Nếu có tên trùng
        return true; // Tên đã tồn tại
      }

      return false; // Không có tên hay email trùng
    } catch (e) {
      print("Lỗi khi kiểm tra người dùng: $e");
      return true; // Nếu có lỗi thì giả sử người dùng đã tồn tại
    }
  }

  // Hàm tạo document mới trong Firestore
  Future<void> registerUser() async {
    String email = emailController.text;
    String name = nameController.text;
    String password = passwordController.text;

    // Kiểm tra xem tên hoặc email đã tồn tại chưa
    bool userExists = await checkIfUserExists(email, name);

    if (userExists) {
      // Nếu có tên hoặc email trùng, hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Tên hoặc Email đã tồn tại!'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        // Tạo document mới trong bảng 'users'
        await FirebaseFirestore.instance.collection('users').add({
          'email': email,
          'name': name,
          'password': password,
        });

        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text('Đăng ký thành công, hãy quay về trang đăng nhập'),
            backgroundColor: Colors.green,
          ),
        );

        // Sau khi đăng ký thành công, quay lại trang đăng nhập
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(
              context); // Quay lại trang trước đó (giả sử là trang đăng nhập)
        });
      } catch (e) {
        // Hiển thị thông báo lỗi khi có lỗi xảy ra
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi đăng ký: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Quay lại trang đăng nhập
          },
        ),
        title: const Text('Đăng ký tài khoản'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Tên',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Gọi hàm đăng ký và tạo document mới trong Firestore
                  registerUser();
                },
                child: const Text('Đăng ký'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
