import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/Utils/dropdown_lists_options.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';
import 'package:housing_project/models/auth_models/student_auth_model.dart';
import 'package:housing_project/models/user_model.dart';

class StudentSignupPage extends StatefulWidget {
  const StudentSignupPage({super.key});

  @override
  State<StudentSignupPage> createState() => _SignupPagePageState();
}

class _SignupPagePageState extends State<StudentSignupPage> {
  late final GlobalKey<FormState> _formKey;
  late DateTime date = DateTime.now();
  late final TextEditingController _emailController,
      _passwordController,
      _usernameController,
      _phoneNumberController,
      _collegeNameController;
  late FocusNode _emailFocusNode,
      _passwordFocusNode,
      _usernameFocusedNode,
      _phoneNumberFocusedNode,
      _collegeNameFocusedNode;
  bool visibility = false;
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
    _collegeNameController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _usernameFocusedNode = FocusNode();
    _phoneNumberFocusedNode = FocusNode();
    _collegeNameFocusedNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _collegeNameController.dispose();
    super.dispose();
  }

  int fieldIndex = 0;
  bool isLastPage = false;
  late UserModel newUser;
  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).studentRegister(
        StudentRegisterModel(
          name: _usernameController.text,
          password: _passwordController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
          gender: genderValue!,
          role: 'طالب',
          birthDate: BoardDateFormat("yyyy-MM-dd").format(date),
          college: colleqeName!,
          specialization: specializationName!,
          universityBuilding: univercityBuilding!,
        ),
      );
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
                      FocusScope.of(context)
                          .requestFocus(_collegeNameFocusedNode);
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
                    'إسم الكلية',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: size.height * 0.002),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2<String>(
                      hint: const Text(
                        'قم بإختيار الكلية',
                      ),
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          colleqeName = value!;
                        });
                      },
                      items: colleqesList
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
                  Text(
                    'التخصص',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: size.height * 0.002),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2<String>(
                      hint: const Text(
                        'قم بإختيار التخصص',
                      ),
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          specializationName = value!;
                        });
                      },
                      items: specializationsList
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
                  Text(
                    'تاريخ الميلاد',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: size.height * 0.002),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await showBoardDateTimePickerForDate(
                          useSafeArea: true,
                          useRootNavigator: true,
                          options: BoardDateTimeOptions(
                            weekend: const BoardPickerWeekendOptions(),
                            textColor: AppColor.black,
                            backgroundColor: AppColor.grey3,
                            activeTextColor: AppColor.black,
                            foregroundColor: AppColor.white,
                            pickerFormat: PickerFormat.dmy,
                            pickerSubTitles: const BoardDateTimeItemTitles(
                              year: 'السنة',
                              month: 'الشهر',
                              day: 'اليوم',
                            ),
                            showDateButton: false,
                            boardTitle:
                                'إختر تاريخ ميلادك، يمكنك الكتابة في كل حقل',
                          ),
                          context: context,
                        );
                        if (result != null) {
                          setState(() {
                            date = result;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsetsDirectional.all(16.0),
                        backgroundColor: AppColor.white,
                        surfaceTintColor: AppColor.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: AppColor.grey4)),
                      ),
                      child: Center(
                        child: Text(
                          BoardDateFormat('yyyy-MM-dd').format(date),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.grey7,
                                  ),
                        ),
                      ),
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
                  Text(
                    'الحرم الجامعي',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: size.height * 0.002),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2<String>(
                      hint: const Text(
                        'قم بإختيار الحرم الجامعي',
                      ),
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          univercityBuilding = value!;
                        });
                      },
                      items: universityBuildingsList
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
                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<AuthCubit, AuthState>(
                      bloc: BlocProvider.of<AuthCubit>(context),
                      listenWhen: (previous, current) =>
                          current is AuthSuccess || current is AuthError,
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم إنشاء الحساب بنجاح'),
                            ),
                          );
                          Navigator.of(context)
                              .pushNamed(AppRoutes.home, arguments: state.user);
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
