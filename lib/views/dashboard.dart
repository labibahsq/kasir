import 'package:flutter/material.dart';
import 'package:flutter_application_9/models/userlogin.dart';
import 'package:flutter_application_9/widgets/bottomnav.dart';

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
    if (user.status == true) {
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
        backgroundColor: const Color(0xFFF2EFE9),
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
      backgroundColor: const Color(0xFFF2EFE9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang, $nama 👋",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B264F),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Anda login sebagai $role",
              style: const TextStyle(color: const Color(0xFF1B264F)),
            ),
            const SizedBox(height: 16),

            Container(
              height: 140,
              decoration: BoxDecoration(
                color: const Color(0xFFC5A059),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "FLASH SALE\nDISKON 50%",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B264F),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(0),
    );
  }
}
