import 'package:flutter/material.dart';
import 'package:krok_task/Screens/home_page.dart';
import 'package:provider/provider.dart';

import 'Models/user_model.dart';
import 'Screens/login_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return const MaterialApp(
        home: LoginPage(),
      );
    } else {
      return const MaterialApp(home: HomePage());
    }
  }
}
