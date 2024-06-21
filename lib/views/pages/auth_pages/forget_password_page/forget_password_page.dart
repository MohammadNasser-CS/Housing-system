import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final TextEditingController _forgetPasswrodController;
  late FocusNode _forgetPasswrodFocusNode;
  bool visibility = false;
  @override
  void initState() {
    super.initState();
    _forgetPasswrodController = TextEditingController();
    _forgetPasswrodFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _forgetPasswrodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إعادة تعيين كلمة المرور'),
          centerTitle: true,
          backgroundColor: AppColor.grey1,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 36),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'هل نسيت كلمة المرور؟',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: AppColor.orange8,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'أدخل رقم الهاتف المرتبط بحسابك لإعادة تعيين كلمة المرور الخاصة بك.',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColor.grey),
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                Text(
                  'إسم المستخدم',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال رقم الهاتف المرتبط بحسابك";
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: _forgetPasswrodFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  controller: _forgetPasswrodController,
                  decoration: const InputDecoration(
                    hintText: "05xxxxxxxx",
                    prefixIcon: Icon(FontAwesomeIcons.mobileScreen),
                    prefixIconColor: AppColor.grey,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(AppRoutes.phoneNumberConfirmationPage);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsetsDirectional.symmetric(
                                vertical: size.height * 0.03),
                            backgroundColor: AppColor.orange8,
                            foregroundColor: AppColor.white),
                        child: Text(
                          'إرسال',
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
      ),
    );
  }
}
