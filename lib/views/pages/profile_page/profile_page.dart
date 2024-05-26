import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _userNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _emailController;
  late FocusNode _userNameFocusNode;
  late FocusNode _phoneNumberFocusNode;
  late FocusNode _emailFocusNode;

  String? onwerName, password;
  bool visibility = false;
  @override
  void initState() {
    // _formKey = GlobalKey<FormState>();
    _userNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _userNameFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
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
              'إسم المستخدم',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: size.height * 0.02),
            TextFormField(
              textAlign: TextAlign.right,
              controller: _userNameController,
              focusNode: _userNameFocusNode,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                onwerName = value;
              },
              decoration: InputDecoration(
                hintText: widget.user.name,
                prefixIcon: const Icon(FontAwesomeIcons.user),
                prefixIconColor: AppColor.grey,
                fillColor: AppColor.white,
                filled: true,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              'رقم الهاتف',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: size.height * 0.02),
            TextFormField(
              textAlign: TextAlign.right,
              controller: _phoneNumberController,
              focusNode: _phoneNumberFocusNode,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                onwerName = value;
              },
              decoration: InputDecoration(
                hintText: widget.user.phoneNumber,
                prefixIcon: const Icon(FontAwesomeIcons.mobileScreen),
                prefixIconColor: AppColor.grey,
                fillColor: AppColor.white,
                filled: true,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              'البريد الإلكتروني',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: size.height * 0.02),
            TextFormField(
              textAlign: TextAlign.right,
              controller: _emailController,
              focusNode: _emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                onwerName = value;
              },
              decoration: InputDecoration(
                hintText: widget.user.email,
                prefixIcon: const Icon(FontAwesomeIcons.envelope),
                prefixIconColor: AppColor.grey,
                fillColor: AppColor.white,
                filled: true,
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
                        backgroundColor: AppColor.orange8,
                        foregroundColor: AppColor.white),
                    child: Text(
                      'حفظ التغييرات',
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
