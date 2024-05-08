import 'package:flutter/material.dart';
import 'package:news_app/login/firebase_authentication.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              "News App",
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
              ),
            ),
          ),
          const SizedBox(height: 80),
          GestureDetector(
            onTap: () async {
              loginByGoogle(context);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Sign in with Google",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (_) {
          //       return const ListNewsPage();
          //     }));
          //   },
          //   child: Container(
          //     child: const Text("test news page"),
          //   ),
          // )
        ],
      ),
    );
  }
}
