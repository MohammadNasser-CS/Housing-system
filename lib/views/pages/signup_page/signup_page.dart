import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPagePageState();
}

class _SignupPagePageState extends State<SignupPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController,
      _passwordController,
      _usernameController;
  late FocusNode _emailFocusNode, _passwordFocusNode, _usernameFocusedNode;
  bool visibility = false;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
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

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      // await BlocProvider.of<AuthCubit>(context).register(
      //   _emailController.text,
      //   _passwordController.text,
      //   _usernameController.text,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      'إنشاء حساب',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'قم بملء الحقول المطلوبة لإنشاء حسابك',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColor.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'إسم المستخدم',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء إدخال إسم المستخدم";
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
                        hintText: 'قم بإدخال إسم المستخدم',
                        prefixIcon: Icon(
                          Icons.person_outline,
                        ),
                        prefixIconColor: AppColor.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'البريد الإلكتروني',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء قم بإدخال الإيميل الخاص بك";
                        } else if (!value.contains('@')) {
                          return 'قم بإدخال بريد إلكتروني صالح!.';
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
                        hintText: 'أدخل بريدك الإلكتروني',
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        prefixIconColor: AppColor.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'كلمة المرور',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 12,
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
                    const SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
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
                            Navigator.of(context).pushNamed(AppRoutes.home);
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
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: AppColor.white,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            );
                          }
                          return ElevatedButton(
                            onPressed: register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: AppColor.white,
                            ),
                            child: Text(
                              'إنشاء حساب',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
