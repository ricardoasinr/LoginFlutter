import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final String _BaseURL = 'identitytoolkit.googleapis.com';
  final String _FirebaseToken = 'AIzaSyDUOBZ54LkIdjFgZmylV7M36D_7Nv9iTqo';
  final storage = new FlutterSecureStorage();

  //Auth

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_BaseURL, '/v1/accounts:signUp', {'key': _FirebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //return decodeResp['idToken'];
      await storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future<String?> loginUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _BaseURL, '/v1/accounts:signInWithPassword', {'key': _FirebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //return decodeResp['idToken'];

      await storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future logOut() async {
    await storage.delete(key: 'token');
    return null;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
