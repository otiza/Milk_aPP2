import 'package:flutter/material.dart';
import 'package:milk_collection/auth/auth_service.dart';
import 'package:milk_collection/pages/ErrorPage.dart';
import 'package:milk_collection/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadinPage extends StatefulWidget {
  const LoadinPage({super.key});

  @override
  State<LoadinPage> createState() => _LoadinPageState();
}

class _LoadinPageState extends State<LoadinPage> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    
  }

  Future<void> _checkAuthStatus() async {
    // Check if user is already authenticated
    final storage = await SharedPreferences.getInstance();
    final email = storage.getString('user') ?? '';
    final password = storage.getString('pass') ?? '';

    if (email != '' && password != '') {
      final sessionIsValid =
          await checkSession(email, password).catchError((error) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ErrorPage(error: error.message))).then((value) =>{
                  setState(() {
          _isLoading = false;
        })
                });
        
      });

      if (sessionIsValid) {
        // Redirect user to home screen
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Show login screen
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // Show login screen
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkAuthStatus();
    return Scaffold(
      body: Center(
        child: _isLoading ? const CircularProgressIndicator() : const LoginPage(),
      ),
    );
  }
}
