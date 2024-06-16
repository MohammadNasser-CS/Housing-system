import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/my_profile_cubit/my_profile_cubit.dart';
import 'package:housing_project/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;
  const ProfilePage({super.key,required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final GlobalKey<FormState> _formKey;
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
    _formKey = GlobalKey<FormState>();
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

  Future<void> updateMyInformation() async {
    // Extract values from controllers

    if (_formKey.currentState!.validate()) {
      debugPrint('test');
      String newName = _userNameController.text.trim();
      String newPhone = _phoneNumberController.text.trim();
      String newEmail = _emailController.text.trim();
      // Prepare a map to send to AuthCubit
      Map<String, String?> updateData = {};

      // Add key-value pairs only if fields are not empty
      if (newName.isNotEmpty) {
        updateData['name'] = newName;
      }
      if (newPhone.isNotEmpty) {
        updateData['phoneNumber'] = newPhone;
      }
      if (newEmail.isNotEmpty) {
        updateData['email'] = newEmail;
      }

      // Check if any fields are updated
      if (updateData.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لم تقم بأي تعديل'),
          ),
        );
      } else {
        // Call AuthCubit to change information
        BlocProvider.of<MyProfileCubit>(context)
            .updateMyInformation(updateData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubitB = BlocProvider.of<MyProfileCubit>(context);
    return BlocListener<MyProfileCubit, MyProfileState>(
      bloc: cubitB,
      listenWhen: (previous, current) =>
          current is MyProfileUpdateInvoked || current is MyProfileUpdateError,
      listener: (context, state) {
        if (state is MyProfileUpdateInvoked) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop();
        } else if (state is MyProfileUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          title: const Text('معلوماتي'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.02),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إسم المستخدم',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            } else if (!RegExp(r'^[ء-ي\s]+$').hasMatch(value)) {
                              return "الرجاء إدخال إسم صحيح يحتوي على الأحرف العربية فقط";
                            } else if (value.trim() ==
                                widget.user.name.trim()) {
                              return "الإسم الذي أدخلته مطابق للإسم الحالي الفعلي";
                            } else {
                              return null;
                            }
                          },
                          onEditingComplete: () {
                            _userNameFocusNode.unfocus();
                            FocusScope.of(context)
                                .requestFocus(_phoneNumberFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: _userNameFocusNode,
                          keyboardType: TextInputType.name,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: widget.user.name,
                            prefixIcon: const Icon(
                              Icons.person_outline,
                            ),
                            prefixIconColor: AppColor.grey,
                            fillColor: AppColor.white,
                            filled: true,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          'رقم الهاتف',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            } else {
                              // Regular expression for Palestinian and Israeli phone numbers
                              String pattern =
                                  r'^(?:(?:\+|00)?(972|970)[\-]?)?(?:[2-9]\d{1,2}|\d{1,2})[\-]?\d{3}[\-]?\d{4}$';
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value)) {
                                return "الرجاء إدخال رقم هاتف صحيح";
                              } else if (value.trim() ==
                                  widget.user.phoneNumber.trim()) {
                                return "رقم الهاتف الذي أدخلته مطابق لرقم الهاتف الحالي المسجل للحساب";
                              } else {
                                return null;
                              }
                            }
                          },
                          onEditingComplete: () {
                            _phoneNumberFocusNode.unfocus();
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: _phoneNumberFocusNode,
                          keyboardType: TextInputType.phone,
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            hintText: widget.user.phoneNumber,
                            prefixIcon: const Icon(
                              Icons.phone,
                            ),
                            prefixIconColor: AppColor.grey,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          'البريد الإلكتروني',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFormField(
                          textAlign: TextAlign.right,
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          onEditingComplete: () {
                            _emailFocusNode.unfocus();
                            updateMyInformation();
                          },
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            } else {
                              // Improved regular expression for validating email
                              String emailPattern =
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                              RegExp regex = RegExp(emailPattern);
                              if (!regex.hasMatch(value)) {
                                return "البريد الإلكتروني غير مناسب";
                              } else if (value.trim() ==
                                  widget.user.email.trim()) {
                                return "البريد الإلكتروني الذي أدخلته مطابق للبريد الإلكتروني الحالي المسجل للحساب";
                              } else {
                                // Additional check for common domains
                                List<String> commonDomains = [
                                  "gmail.com",
                                  "yahoo.com",
                                  "hotmail.com",
                                  "outlook.com"
                                ];
                                String domain = value.split('@').last;
                                if (!commonDomains.contains(domain)) {
                                  return "البريد الإلكتروني غير مناسب";
                                }
                                return null;
                              }
                            }
                          },
                          decoration: InputDecoration(
                            hintText: widget.user.email,
                            prefixIcon: const Icon(Icons.email_outlined),
                            prefixIconColor: AppColor.grey,
                          ),
                        ),
                        SizedBox(height: size.height * 0.1),
                        Row(
                          children: [
                            Expanded(
                              child:
                                  BlocBuilder<MyProfileCubit, MyProfileState>(
                                bloc: cubitB,
                                buildWhen: (previous, current) =>
                                    current is MyProfileLoading ||
                                    current is MyProfileUpdateInvoked ||
                                    current is MyProfileUpdateError,
                                builder: (context, state) {
                                  if (state is MyProfileLoading) {
                                    return ElevatedButton(
                                        onPressed: null,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.orange8,
                                            foregroundColor: AppColor.white),
                                        child: const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        ));
                                  } else {
                                    return ElevatedButton(
                                      onPressed: updateMyInformation,
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.orange8,
                                          foregroundColor: AppColor.white),
                                      child: Text(
                                        'حفظ التغييرات',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppColor.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
