import 'package:flutter/material.dart';
import 'package:tutor/app/config/extensions/context_extensions.dart';
import 'package:tutor/app/config/theme/my_colors.dart';
import 'package:tutor/app/modules/auth/widgets/auth_form.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate.register,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAuthForm(registerFormKey: formKey),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
              onPressed: () {}, child: Text(context.translate.register)),
          const SizedBox(
            height: 12,
          ),
          TextButton(
              onPressed: () {}, child: Text(context.translate.googleLogin)),
        ],
      ),
    );
  }
}
