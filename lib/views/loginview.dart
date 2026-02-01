import 'package:flutter/material.dart';
import 'package:flutter_application_9/services/user.dart';
import 'package:flutter_application_9/widgets/alert.dart';
import 'package:flutter_application_9/views/dashboard.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool showPass = true;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFE9),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 60),
              Column(
                children: [Image.asset('assets/logonama.png', height: 250)],
              ),

              const SizedBox(height: 60),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: _inputDecoration(
                        "E-mail",
                        icon: Icons.email_outlined,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email harus diisi';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: password,
                      obscureText: !isPasswordVisible,
                      decoration: _inputDecoration("Password").copyWith(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password harus diisi';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          var data = {
                            "email": email.text,
                            "password": password.text,
                          };
                          print(data);
                          var result = await user.loginUser(data);
                          setState(() {
                            isLoading = false;
                          });
                          print(result.message);
                          if (result.status == true) {
                            alertMessage().showAlert(
                              context,
                              result.message,
                              true,
                            );
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/dashboard',
                              );
                            });
                          } else {
                            alertMessage().showAlert(
                              context,
                              result.message,
                              false,
                            );
                          }
                        }
                      },
                      child: isLoading == false
                          ? Text("LOGIN", style: TextStyle(color: Colors.white))
                          : CircularProgressIndicator(),
                      color: Colors.brown,
                    ),

                    SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun ?"),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.brown,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(
    String hint, {
    IconData? icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(icon, color: const Color(0xFFC5A059))
          : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF9F7F0), // warna kotak lembut
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }
}
