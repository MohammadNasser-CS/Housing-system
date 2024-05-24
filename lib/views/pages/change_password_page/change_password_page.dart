import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/user_model.dart';

class ChangePasswordPage extends StatefulWidget {
  final UserModel user;
  const ChangePasswordPage({super.key, required this.user});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final TextEditingController _passwordController,
      _newPasswordController,
      _confirmNewPasswordController;
  late FocusNode _passwordFocusNode,
      _newPasswordFocusNode,
      _confirmNewPasswordFocusedNode;
  bool passwordVisibility = false,
      newPasswordVisibility = false,
      confirmNewPasswordVisibility = false;
  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: widget.user.phoneNumber);
    _newPasswordController =
        TextEditingController(text: widget.user.phoneNumber);
    _confirmNewPasswordController =
        TextEditingController(text: widget.user.phoneNumber);
    _passwordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmNewPasswordFocusedNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('معلوماتي'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: size.width * 0.03, vertical: size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'كلمة المرور الحالية',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "الرجاء إدخال كلمة المرور";
                } else if (value.length < 6) {
                  return 'كلمة المرور يجب أن لا تكون أقل من 6 رموز';
                } else {
                  return null;
                }
              },
              onEditingComplete: () {
                _passwordFocusNode.unfocus();
                // register();
              },
              focusNode: _passwordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              obscureText: !passwordVisibility,
              decoration: InputDecoration(
                hintText: 'أدخل كلمة المرور',
                prefixIcon: const Icon(
                  Icons.password,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(
                      () {
                        passwordVisibility = !passwordVisibility;
                      },
                    );
                  },
                  child: Icon(
                    passwordVisibility == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                suffixIconColor: AppColor.grey,
                prefixIconColor: AppColor.grey,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              'كلمة المرور الجديدة',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "الرجاء إدخال كلمة المرور";
                } else if (value.length < 6) {
                  return 'كلمة المرور يجب أن لا تكون أقل من 6 رموز';
                } else {
                  return null;
                }
              },
              onEditingComplete: () {
                _passwordFocusNode.unfocus();
                // register();
              },
              focusNode: _newPasswordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              controller: _newPasswordController,
              obscureText: !newPasswordVisibility,
              decoration: InputDecoration(
                hintText: 'أدخل كلمة المرور',
                prefixIcon: const Icon(
                  Icons.password,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(
                      () {
                        newPasswordVisibility = !newPasswordVisibility;
                      },
                    );
                  },
                  child: Icon(
                    newPasswordVisibility == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                suffixIconColor: AppColor.grey,
                prefixIconColor: AppColor.grey,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              'تأكيد كلمة المرور الجديدة',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "الرجاء إدخال كلمة المرور";
                } else if (value.length < 6) {
                  return 'كلمة المرور يجب أن لا تكون أقل من 6 رموز';
                } else {
                  return null;
                }
              },
              onEditingComplete: () {
                _passwordFocusNode.unfocus();
                // register();
              },
              focusNode: _confirmNewPasswordFocusedNode,
              keyboardType: TextInputType.visiblePassword,
              controller: _confirmNewPasswordController,
              obscureText: !confirmNewPasswordVisibility,
              decoration: InputDecoration(
                hintText: 'أدخل كلمة المرور',
                prefixIcon: const Icon(
                  Icons.password,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(
                      () {
                        confirmNewPasswordVisibility =
                            !confirmNewPasswordVisibility;
                      },
                    );
                  },
                  child: Icon(
                    confirmNewPasswordVisibility == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                suffixIconColor: AppColor.grey,
                prefixIconColor: AppColor.grey,
              ),
            ),
            // SizedBox(height: size.height * 0.03),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsetsDirectional.symmetric(
                            vertical: size.width * 0.03),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: AppColor.white),
                    child: Text(
                      'تغير',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
