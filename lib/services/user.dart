import 'dart:convert';
import 'package:flutter_application_9/models/responsedatamap.dart';
import 'package:flutter_application_9/models/userlogin.dart';
import 'package:flutter_application_9/services/url.dart' as url;
import 'package:http/http.dart' as http;

class UserService {
  Future registerUser(data) async {
    var uri = Uri.parse(url.BaseUrl + "/auth/register");
    var register = await http.post(uri, body: data);
    if (register.statusCode == 200) {
      var data = json.decode(register.body);
      if (data["status"] == true) {
        Responsedatamap response = Responsedatamap(
          status: true,
          message: "Sukses menambah user",
          data: data,
        );
        return response;
      } else {
        var message = '';
        for (String key in data["message"].key) {
          message += data["message"][key][0].toString() + '\n';
        }
        Responsedatamap response = Responsedatamap(
          status: false,
          message: message,
        );
        return response;
      }
    } else {
      Responsedatamap response = Responsedatamap(
        status: false,
        message: "gagal menambah user dengan code eror ${register.statusCode}",
      );
      return response;
    }
  }

  Future loginUser(data) async {
    var uri = Uri.parse(url.BaseUrl + "/auth/login");
    var register = await http.post(uri, body: data);
    print(register.statusCode);
    if (register.statusCode == 200) {
      var data = json.decode(register.body);
      print(data);
      if (data["status"] == true) {
        UserLogin userLogin = UserLogin(
          status: data["status"],
          token: data["token"],
          message: data["message"],
          id: data["user"]["id"],
          nama_user: data["user"]["nama_user"],
          email: data["user"]["email"],
          role: data["user"]["role"],
        );
        await userLogin.prefs();
        Responsedatamap response = Responsedatamap(
          status: true,
          message: "Sukses login user",
          data: data,
        );
        return response;
      } else {
        Responsedatamap response = Responsedatamap(
          status: true,
          message: 'Email dan password salah',
        );
        return response;
      }
    } else {
      Responsedatamap response = Responsedatamap(
        status: false,
        message: "gagal login user dengan code error ${register.statusCode}",
      );
      return response;
    }
  }
}
