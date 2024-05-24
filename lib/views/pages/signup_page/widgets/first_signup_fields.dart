import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';

class FirstSignUpFields extends StatefulWidget {
  const FirstSignUpFields({super.key});

  @override
  State<FirstSignUpFields> createState() => _FirstSignUpFieldsState();
}

class _FirstSignUpFieldsState extends State<FirstSignUpFields> {
  late final TextEditingController _emailController,
      _passwordController,
      _usernameController;
  late FocusNode _emailFocusNode, _passwordFocusNode, _usernameFocusedNode;
  bool visibility = false;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _usernameFocusedNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'إنشاء حساب',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'قم بملء الحقول المطلوبة لإنشاء حسابك',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: AppColor.grey),
        ),
        const SizedBox(height: 20),
        Text(
          'الإسم',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return "الرجاء إدخال إسم المستخدم";
          //   } else {
          //     return null;
          //   }
          // },
          onEditingComplete: () {
            _usernameFocusedNode.unfocus();
            FocusScope.of(context).requestFocus(_emailFocusNode);
          },
          textInputAction: TextInputAction.next,
          focusNode: _usernameFocusedNode,
          keyboardType: TextInputType.emailAddress,
          controller: _usernameController,
          decoration: const InputDecoration(
            hintText: 'قم بإدخال إسم المستخدم',
            prefixIcon: Icon(
              Icons.person_outline,
            ),
            prefixIconColor: AppColor.grey,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'البريد الإلكتروني',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return "الرجاء قم بإدخال الإيميل الخاص بك";
          //   } else if (!value.contains('@')) {
          //     return 'قم بإدخال بريد إلكتروني صالح!.';
          //   } else {
          //     return null;
          //   }
          // },
          onEditingComplete: () {
            _emailFocusNode.unfocus();
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          textInputAction: TextInputAction.next,
          focusNode: _emailFocusNode,
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          decoration: const InputDecoration(
            hintText: 'أدخل بريدك الإلكتروني',
            prefixIcon: Icon(
              Icons.email,
            ),
            prefixIconColor: AppColor.grey,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'كلمة المرور',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return "الرجاء إدخال كلمة المرور";
          //   } else if (value.length < 6) {
          //     return 'كلمة المرور يجب أن لا تكون أقل من 6 رموز';
          //   } else {
          //     return null;
          //   }
          // },
          onEditingComplete: () {
            _passwordFocusNode.unfocus();
            // register();
          },
          focusNode: _passwordFocusNode,
          keyboardType: TextInputType.visiblePassword,
          controller: _passwordController,
          obscureText: !visibility,
          decoration: InputDecoration(
            hintText: 'أدخل كلمة المرور',
            prefixIcon: const Icon(
              Icons.password,
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(
                  () {
                    visibility = !visibility;
                  },
                );
              },
              child: Icon(
                visibility == true ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            suffixIconColor: AppColor.grey,
            prefixIconColor: AppColor.grey,
          ),
        ),
      ],
    );
  }
}
