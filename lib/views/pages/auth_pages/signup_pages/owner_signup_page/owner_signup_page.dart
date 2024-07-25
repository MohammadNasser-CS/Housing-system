import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/Utils/dropdown_lists_options.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';
import 'package:housing_project/models/auth_models/owner_auth_model.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/shared_pages/widgets/text_widget.dart';
import 'package:image_picker/image_picker.dart';

class OwnerSignupPage extends StatefulWidget {
  const OwnerSignupPage({super.key});

  @override
  State<OwnerSignupPage> createState() => _OwnerSignupPagePageState();
}

class _OwnerSignupPagePageState extends State<OwnerSignupPage> {
  late final GlobalKey<FormState> _formKey;
  late DateTime date = DateTime.now();
  late final TextEditingController _emailController,
      _passwordController,
      _usernameController,
      _phoneNumberController;
  late FocusNode _emailFocusNode,
      _passwordFocusNode,
      _usernameFocusedNode,
      _phoneNumberFocusedNode;
  bool visibility = false, wantToAddPhoto = false;
  File? _file;
  String? genderValue;
  String? univercityBuilding;
  String? specializationName;
  String? colleqeName;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _usernameFocusedNode = FocusNode();
    _phoneNumberFocusedNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  int fieldIndex = 0;
  bool isLastPage = false;
  late UserModel newUser;

  Future<void> pickPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        _file = File(photo.path);
      });
    }
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      if (_file != null && wantToAddPhoto) {
        String base64Image = base64Encode(_file!.readAsBytesSync());
        String imageName = _file!.path.split('/').last;
        String imageExtension = imageName.split('.').last;
        BlocProvider.of<AuthCubit>(context).ownerRegister(
          OwnerRegisterModel(
            name: _usernameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            phoneNumber: _phoneNumberController.text,
            gender: genderValue!,
            role: 'صاحب سكن',
            base64Image: base64Image,
            imageExtension: imageExtension,
          ),
        );
      } else {
        BlocProvider.of<AuthCubit>(context).ownerRegister(
          OwnerRegisterModel(
            name: _usernameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            phoneNumber: _phoneNumberController.text,
            gender: genderValue!,
            role: 'صاحب سكن',
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.grey1,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 15.0),
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        width: size.width,
                        height: size.height * 0.2,
                      ),
                    ),
                  ),
                  Text(
                    'إنشاء حساب',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppColor.orange8, fontWeight: FontWeight.bold),
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
                    'الإسم',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: size.height * 0.002),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "الرجاء إدخال الإسم الكامل";
                      } else if (!RegExp(r'^[ء-ي\s]+$').hasMatch(value)) {
                        return "الرجاء إدخال إسم صحيح يحتوي على الأحرف العربية فقط";
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
                    keyboardType: TextInputType.name,
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: 'قم بإدخال إسم المستخدم',
                      prefixIcon: Icon(
                        Icons.person_outline,
                      ),
                      prefixIconColor: AppColor.grey,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'البريد الإلكتروني',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: size.height * 0.002),
                  TextFormField(
                    textAlign: TextAlign.right,
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    onEditingComplete: () {
                      _emailFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "قم بإدخال البريد الإلكتروني الخاص بك.";
                      } else {
                        // Improved regular expression for validating email
                        String emailPattern =
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                        RegExp regex = RegExp(emailPattern);
                        if (!regex.hasMatch(value)) {
                          return "البريد الإلكتروني غير مناسب";
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
                    decoration: const InputDecoration(
                      hintText: 'قم بإدخال البريد الإلكتروني الخاص بك.',
                      prefixIcon: Icon(Icons.email_outlined),
                      prefixIconColor: AppColor.grey,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'كلمة المرور',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: size.height * 0.002),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: !visibility,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "قم بإدخال كلمة المرور";
                      } else if (value.length < 8) {
                        return "يجب أن تكون كلمة المرور 8 أحرف على الأقل";
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      _passwordFocusNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(_phoneNumberFocusedNode);
                      // register();
                    },
                    decoration: InputDecoration(
                      hintText: 'قم بإدخال كلمة المرور',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        child: Icon(
                          visibility
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      prefixIconColor: AppColor.grey,
                      suffixIconColor: AppColor.grey,
                    ),
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
                        // Regular expression for Palestinian and Israeli phone numbers
                        String pattern =
                            r'^(?:(?:\+|00)?(972|970)[\-]?)?(?:[2-9]\d{1,2}|\d{1,2})[\-]?\d{3}[\-]?\d{4}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return "الرجاء إدخال رقم هاتف صحيح";
                        } else {
                          return null;
                        }
                      }
                    },
                    onEditingComplete: () {
                      _phoneNumberFocusedNode.unfocus();
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _phoneNumberFocusedNode,
                    keyboardType: TextInputType.phone,
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      hintText: 'قم بإدخال رقم الهاتف',
                      prefixIcon: Icon(
                        Icons.phone,
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
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2<String>(
                      hint: const Text(
                        'قم بإختيار الجنس',
                      ),
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          genderValue = value!;
                        });
                      },
                      items: gendersList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColor.white,
                              border: BorderDirectional(
                                bottom: BorderSide(color: AppColor.grey),
                              ),
                            ),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    children: [
                      const Expanded(
                        child: TextWidget(
                          title: 'ورقة الملكية ليست إجبارية: ',
                          value:
                              'إن أردت أن ترفع صورة تثبت ملكيتك لسكن واحد عالأقل؛ هذا قد يسرع من عملية تأكيد حسابك.\nيمكنك الإستمرار من دون رفع صورة.',
                        ),
                      ),
                      Checkbox(
                        value: wantToAddPhoto,
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              if (value == false) {
                                _file = null;
                              }
                              wantToAddPhoto = value;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.002),
                  wantToAddPhoto
                      ? InkWell(
                          onTap: pickPhoto,
                          child: Container(
                            width: size.width,
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                border: Border.all(color: AppColor.grey)),
                            child: _file == null
                                ? Icon(
                                    Icons.add_a_photo_outlined,
                                    size: size.width * 0.2,
                                    color: AppColor.grey,
                                  )
                                : Image.file(
                                    _file!,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: size.height * 0.02),
                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<AuthCubit, AuthState>(
                      bloc: BlocProvider.of<AuthCubit>(context),
                      listenWhen: (previous, current) =>
                          current is OwnerAuthSuccess || current is AuthError,
                      listener: (context, state) {
                        if (state is OwnerAuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                          Navigator.of(context).pushNamed(AppRoutes.loginPage);
                        } else if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is AuthLoading || current is AuthError,
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              padding:
                                  EdgeInsetsDirectional.all(size.width * 0.025),
                              backgroundColor: AppColor.orange8,
                              foregroundColor: AppColor.white,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        } else {
                          return ElevatedButton(
                            onPressed: register,
                            style: ElevatedButton.styleFrom(
                              padding:
                                  EdgeInsetsDirectional.all(size.width * 0.025),
                              backgroundColor: AppColor.orange8,
                              foregroundColor: AppColor.white,
                            ),
                            child: Text(
                              'إنشاء الحساب',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w600),
                            ),
                          );
                        }
                      },
                    ),
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
