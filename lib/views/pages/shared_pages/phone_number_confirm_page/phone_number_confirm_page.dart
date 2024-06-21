import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';

class PhoneNumberConfirmationPage extends StatefulWidget {
  const PhoneNumberConfirmationPage({super.key});

  @override
  State<PhoneNumberConfirmationPage> createState() =>
      _PhoneNumberConfirmationPageState();
}

class _PhoneNumberConfirmationPageState
    extends State<PhoneNumberConfirmationPage> {
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
                          'تأكيد رقم الهاتف',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'قم بإدخال الرمز المرسل إلى هاتفك',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColor.grey),
                        ),
                      ],
                    ),),
                const SizedBox(height: 20),
                Text(
                  'الرمز',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال الرمز الذي تم إرساله إليك";
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                  focusNode: _forgetPasswrodFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  controller: _forgetPasswrodController,
                  decoration: const InputDecoration(
                    hintText: "xxxxxx",
                    prefixIcon: Icon(FontAwesomeIcons.mobileScreen),
                    prefixIconColor: AppColor.grey,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لم تتلق رمز؟',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: AppColor.grey),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.roleSelectionPage),
                      child: Text(
                        'إعادة إرسال',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(AppRoutes.passwordResetPage);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsetsDirectional.symmetric(
                                vertical: size.height * 0.03),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: AppColor.white),
                        child: Text(
                          'تأكيد',
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
