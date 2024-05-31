import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/Utils/dropdown_lists_options.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';
import 'package:housing_project/models/user_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPagePageState();
}

class _SignupPagePageState extends State<SignupPage> {
  late final GlobalKey<FormState> _formKey;
  late DateTime date = DateTime.now();
  late final TextEditingController _emailController,
      _passwordController,
      _usernameController,
      _phoneNumberController,
      _collegeNameController,
      _addressController;
  late FocusNode _emailFocusNode,
      _passwordFocusNode,
      _usernameFocusedNode,
      _phoneNumberFocusedNode,
      _collegeNameFocusedNode,
      _addressFocusedNode;
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
    _addressController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _usernameFocusedNode = FocusNode();
    _phoneNumberFocusedNode = FocusNode();
    _collegeNameFocusedNode = FocusNode();
    _addressFocusedNode = FocusNode();
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
  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      await BlocProvider.of<AuthCubit>(context).register(
        UserModel(
          name: _usernameController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
          gender: genderValue!,
          role: 'student',
          birthDate: BoardDateFormat("yyyy-MM-dd").format(date),
          colleqe: _collegeNameController.text,
          homeAddress: _addressController.text,
          specialization: specializationName,
          universityBuilding: univercityBuilding,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.grey1,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 20.0),
                      child: Image.asset('assets/images/majles_logo.png'),
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
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'كلمة المرور',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: size.height * 0.002),
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
                      FocusScope.of(context).requestFocus(_emailFocusNode);
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
                          visibility == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      suffixIconColor: AppColor.grey,
                      prefixIconColor: AppColor.grey,
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
                        return null;
                      }
                    },
                    onEditingComplete: () {
                      _phoneNumberFocusedNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(_collegeNameFocusedNode);
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _phoneNumberFocusedNode,
                    keyboardType: TextInputType.text,
                    controller: _phoneNumberController,
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
                    'المدينة',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: size.height * 0.002),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "الرجاء قم بإدخال  إسم المدينة التي تعيش بها";
                      } else {
                        return null;
                      }
                    },
                    onEditingComplete: () {
                      _collegeNameFocusedNode.unfocus();
                      // FocusScope.of(context).requestFocus(_specializationFocusedNode);
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: _addressFocusedNode,
                    keyboardType: TextInputType.text,
                    controller: _addressController,
                    decoration: const InputDecoration(
                      hintText: 'أدخل إسم المدينة التي تسكن فيها حاليا',
                      prefixIcon: Icon(
                        Icons.home,
                      ),
                      prefixIconColor: AppColor.grey,
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
                            BoardDateFormat dateFormat =
                                BoardDateFormat("yyyy-MM-dd");
                            String test = dateFormat.format(date);
                            debugPrint(test);
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
                            onPressed: () {
                              cubit.register(
                                UserModel(
                                  name: _usernameController.text,
                                  email: _emailController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  gender: genderValue!,
                                  role: 'student',
                                  birthDate: BoardDateFormat("yyyy-MM-dd")
                                      .format(date),
                                  colleqe: _collegeNameController.text,
                                  homeAddress: _addressController.text,
                                  specialization: specializationName,
                                  universityBuilding: univercityBuilding,
                                ),
                              );
                            },
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
