import 'package:flutter/material.dart';
import 'package:flutter_application_9/models/userlogin.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  UserLogin userLogin = UserLogin();
  String? nama;
  String? role;
  getUserLogin() async {
    var user = await userLogin.getUserLogin();
    if (user.status = true) {
      setState(() {
        nama = user.nama_user;
        role = user.role;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFEFDF2),
      body: Center(
        child: Text(
          "Selamat Datang $nama role anda $role",
          style: TextStyle(color: Colors.brown),
        ),
      ),
    );
  }
}
