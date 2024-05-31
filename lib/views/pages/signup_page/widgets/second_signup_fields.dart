import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';

class SecondSingUpFields extends StatefulWidget {
  const SecondSingUpFields({super.key});

  @override
  State<SecondSingUpFields> createState() => _SecondSingUpFieldsState();
}

class _SecondSingUpFieldsState extends State<SecondSingUpFields> {
  String genderValue = 'ذكر';
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
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'إنشاء حساب',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: AppColor.orange8, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.002),
        Text(
          'قم بملء الحقول المطلوبة لإنشاء حسابك',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: AppColor.grey),
        ),
        SizedBox(height: size.height * 0.02),
        Text(
          'رقم الهاتف',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: size.height * 0.002),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "الرجاء إدخال رقم الهاتف";
            } else {
              return null;
            }
          },
          onEditingComplete: () {
            _usernameFocusedNode.unfocus();
            FocusScope.of(context).requestFocus(_emailFocusNode);
          },
          textInputAction: TextInputAction.next,
          focusNode: _usernameFocusedNode,
          keyboardType: TextInputType.emailAddress,
          controller: _usernameController,
          decoration: const InputDecoration(
            hintText: 'قم بإدخال رقم الهاتف',
            prefixIcon: Icon(
              Icons.person_outline,
            ),
            prefixIconColor: AppColor.grey,
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Text(
          'إسم الكلية',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: size.height * 0.002),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "الرجاء قم إسم الكلية التي تدرس بها";
            } else {
              return null;
            }
          },
          onEditingComplete: () {
            _emailFocusNode.unfocus();
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          textInputAction: TextInputAction.next,
          focusNode: _emailFocusNode,
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          decoration: const InputDecoration(
            hintText: 'أدخل إسم الكلية',
            prefixIcon: Icon(
              Icons.email,
            ),
            prefixIconColor: AppColor.grey,
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Text(
          'الجنس',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: size.height * 0.002),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: genderValue,
              icon: Icon(
                Icons.arrow_downward,
                color: AppColor.grey7,
              ),
              elevation: 16,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColor.grey7,
                  ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  genderValue = value!;
                });
              },
              items:
                  ['ذكر', 'أنثى'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center, // Align the text to the left
                    child: Text(value),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
