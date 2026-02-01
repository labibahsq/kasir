import 'package:flutter/material.dart';
import 'package:flutter_application_9/models/userlogin.dart';

class BottomNav extends StatefulWidget {
  int activePage;
  BottomNav(this.activePage);

  @override
  State<BottomNav> createState() => _BottomNavStateState();
}

class _BottomNavStateState extends State<BottomNav> {
  UserLogin userLogin = UserLogin();
  String? role;
  getDataLogin() async {
    var user = await userLogin!.getUserLogin();
    if (user!.status != false) {
      setState(() {
        role = user.role;
      });
    } else {
      Navigator.popAndPushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataLogin();
  }

  void getLink(index) {
    if (role == "admin") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/admin');
      }
    } else if (role == "user") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/kasir');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return role == "admin"
        ? BottomNavigationBar(
            backgroundColor: const Color(0xFF1B264F),
            selectedItemColor: const Color(0xFFC5A059),
            unselectedItemColor: Colors.grey,
            currentIndex: widget.activePage,
            onTap: (index) => {getLink(index)},
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.file_copy), label: ''),
            ],
          )
        : role == "user"
        ? BottomNavigationBar(
          backgroundColor: const Color(0xFF1B264F),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFFC5A059),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: widget.activePage,
            onTap: (index) => {getLink(index)},
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: '',
              ),
            ],
          )
        : Text("");
  }
}
