import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  late final TextEditingController _newPasswordController,
      _confirmNewPasswordController;
  late FocusNode _newPasswordFocusNode, _confirmNewPasswordFocusedNode;
  bool newPasswordVisibility = false, confirmNewPasswordVisibility = false;
  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
    _newPasswordFocusNode = FocusNode();
    _confirmNewPasswordFocusedNode = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلوماتي'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'إعادة تعيين كلمة المرور',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'قم بإدخال كلمة المرور الجديدة',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColor.grey),
                      ),
                    ],
                  )),
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
                  _newPasswordFocusNode.unfocus();
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
                  _confirmNewPasswordFocusedNode.unfocus();
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
                              vertical: size.height * 0.03),
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: AppColor.white),
                      child: Text(
                        'تغير',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
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
      ),
    );
  }
}
