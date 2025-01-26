import 'package:e_note_book/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String _userName = '';
  String _password = '';
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _authService.login(_userName, _password);
        if (response.statusCode == 200) {
          print('Login Successful');
          Navigator.pushNamed(context, '/folders');
        } else {
          print('Login Failed!!');
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'UserName'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your userName';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _userName = newValue!;
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Password';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _password = newValue!;
                  },
                ),
                SizedBox(
                  height: 32.0,
                ),
                Center(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(onPressed: _login, child: Text('Login')),
                )
              ],
            )),
      ),
    );
  }
}
