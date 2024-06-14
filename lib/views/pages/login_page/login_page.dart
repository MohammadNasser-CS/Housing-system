import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late FocusNode _emailFocusNode, _passwordFocusNode;
  bool visibility = false;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context)
          .login(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return BlocListener<AuthCubit, AuthState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          current is AuthSuccess || current is AuthError,
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تسجيل الدخول بنجاح'),
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
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 12.0),
                          child: Image.asset('assets/images/majles_logo.png'),
                        ),
                      ),
                      Text(
                        'تسجيل الدخول',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: AppColor.orange8,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'أهلا بك مجددًا، الرجاء تسجيل الدخول للإستمرار',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColor.grey,
                                ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'البريد الإلكتروني',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        textAlign: TextAlign.right,
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        onEditingComplete: () {
                          _emailFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
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
                      const SizedBox(height: 16.0),
                      Text(
                        'كلمة المرور',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 12.0),
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
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
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
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(AppRoutes.forgetPasswordPage);
                          },
                          child: Text(
                            'هل نسيت كلمة المرور؟',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColor.orange8,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: BlocBuilder<AuthCubit, AuthState>(
                          bloc: cubit,
                          buildWhen: (previous, current) =>
                              current is AuthLoading || current is AuthError,
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.orange8,
                                      foregroundColor: AppColor.white),
                                  child: const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ));
                            } else {
                              return ElevatedButton(
                                onPressed: login,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.orange8,
                                    foregroundColor: AppColor.white),
                                child: Text(
                                  'تسجيل الدخول',
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
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لدي حساب من قبل؟',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.grey),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AppRoutes.roleSelectionPage),
                            child: Text(
                              'إنشاء حساب',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColor.orange8,
                                    fontWeight: FontWeight.bold,
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
          ),
        ),
      ),
    );
  }
}
