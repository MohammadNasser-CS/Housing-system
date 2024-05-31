import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/signup_page/widgets/custom_button.dart';
import 'package:housing_project/views/pages/signup_page/widgets/first_signup_fields.dart';
import 'package:housing_project/views/pages/signup_page/widgets/second_signup_fields.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPagePageState();
}

class _SignupPagePageState extends State<SignupPage> {
  late final GlobalKey<FormState> _formKey;
  int fieldIndex=0;
  bool visibility = false;
  final PageController _pageController = PageController();
  bool isLastPage = false;
  late UserModel newUser;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> nextStep() async {
    if (!isLastPage) {
     fieldIndex++;
    } else {
      
      // if (_formKey.currentState!.validate()) {
      //   await BlocProvider.of<AuthCubit>(context).register(
      //     _emailController.text,
      //     _passwordController.text,
      //     _usernameController.text,
      //   );
      // }
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
                  // fieldIndex==0
                  //     ? const FirstSignUpFields()
                  //     : fieldIndex==1?const SecondSingUpFields():const SizedBox.shrink(),
                  // const FirstSignUpFields(),
                  // SecondSingUpFields(),
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
                          Navigator.of(context).pushNamed(AppRoutes.home,arguments:  state.user);
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
                          Row(
                children: [
                  TextButton(
                    onPressed: () {
                      if (fieldIndex > 0) {
                        fieldIndex--;
                        _pageController.animateToPage(fieldIndex,
                            duration: const Duration(microseconds: 400),
                            curve: Curves.fastOutSlowIn);
                      }
                    },
                    child: const Text(
                      'BACK',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                      onPressed: () {
                        if (!isLastPage) {
                          fieldIndex++;
                          _pageController.animateToPage(fieldIndex,
                              duration: const Duration(microseconds: 400),
                              curve: Curves.fastOutSlowIn);
                        } else {
                         cubit.register(newUser);
                        }
                      },
                      title: isLastPage ? 'Get Started' : 'Next'),
                ],
              );

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
                            onPressed: nextStep,
                            style: ElevatedButton.styleFrom(
                              padding:
                                  EdgeInsetsDirectional.all(size.width * 0.025),
                              backgroundColor: AppColor.orange8,
                              foregroundColor: AppColor.white,
                            ),
                            child: Text(
                              'التالي',
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
