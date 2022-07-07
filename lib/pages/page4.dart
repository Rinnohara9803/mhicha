import 'package:flutter/material.dart';
import 'package:mhicha/services/auth_service.dart';

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            await AuthService.logOut(context);
          },
          icon: const Icon(Icons.logout),
          label: const Text(
            'Logout',
          ),
        ),
      ),
    );
  }
}
