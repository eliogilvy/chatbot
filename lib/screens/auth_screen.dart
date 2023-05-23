import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return FlutterLogin(
      onSignup: (data) async {
        return await auth.signUpWithEmail(data.name!, data.password!, data.additionalSignupData!['name']!);
      },
      onLogin: (data) async {
        return await auth.signInWithEmail(data.name, data.password);
      },
      onRecoverPassword: (p0) {},
      title: 'Buddy AI',
      onSubmitAnimationCompleted: () {},
      
      additionalSignupFields: [
        UserFormField(
          keyName: 'name',
          displayName: 'nickname',
          icon: const Icon(Icons.person),
          fieldValidator: (value) => validate(value!),
        ),
      ],
    );
  }

  // Regex validation for name. Should be at least six characters long, 
  // and contain only letters and numbers, or dash and undersore.
  String? validate(String value) {
    final nameRegex = RegExp(r'^[a-zA-Z0-9_-]{6,}$');
    if (!nameRegex.hasMatch(value)) {
      return '6+, no spaces, a-z, A-Z, 0-9, _, -';
    }
    return null;
  }
}
