import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/change_password_page_cubit/change_password_cubit.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _passwordController,
      _newPasswordController,
      _confirmNewPasswordController;
  late FocusNode _passwordFocusNode,
      _newPasswordFocusNode,
      _confirmNewPasswordFocusedNode;
  bool passwordVisibility = false,
      newPasswordVisibility = false,
      confirmNewPasswordVisibility = false;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _passwordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmNewPasswordFocusedNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<void> updatePassword() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<ChangePasswordCubit>(context).changePassword(
        _passwordController.text,
        _newPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<ChangePasswordCubit>(context);
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) =>
          current is ChangePasswordInvoked || current is ChangePasswordError,
      listener: (context, state) {
        if (state is ChangePasswordInvoked) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          Navigator.of(context).pop();
        } else if (state is ChangePasswordError) {
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
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('تعديل كلمة المرور'),
          centerTitle: true,
        ),
        body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is ChangePasswordLoading ||
              current is ChangePasswordError,
          builder: (context, state) {
            if (state is ChangePasswordLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is ChangePasswordError) {
              return Center(
                child: Text(state.message),
              );
            }
            return SingleChildScrollView(
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
                        'كلمة المرور الحالية',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 12.0),
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
                          FocusScope.of(context)
                              .requestFocus(_newPasswordFocusNode);
                        },
                        focusNode: _passwordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        obscureText: !passwordVisibility,
                        decoration: InputDecoration(
                          hintText: 'أدخل كلمة المرور',
                          prefixIcon: const Icon(
                            Icons.password,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                            child: Icon(
                              passwordVisibility == true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          suffixIconColor: AppColor.grey,
                          prefixIconColor: AppColor.grey,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Text(
                        'كلمة المرور الجديدة',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إدخال كلمة المرور";
                          } else if (value.length < 6) {
                            return 'كلمة المرور يجب أن لا تكون أقل من 6 رموز';
                          } else if (_confirmNewPasswordController.text !=
                              value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('كلمات المرور غير متطابقة'),
                              ),
                            );
                            return 'كلمات السر غير متطابقة';
                          } else {
                            return null;
                          }
                        },
                        onEditingComplete: () {
                          _passwordFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(_confirmNewPasswordFocusedNode);
                          // register();
                        },
                        focusNode: _newPasswordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _newPasswordController,
                        obscureText: !newPasswordVisibility,
                        decoration: InputDecoration(
                          hintText: 'أدخل كلمة المرور',
                          prefixIcon: const Icon(
                            Icons.password,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                newPasswordVisibility = !newPasswordVisibility;
                              });
                            },
                            child: Icon(
                              newPasswordVisibility == true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          suffixIconColor: AppColor.grey,
                          prefixIconColor: AppColor.grey,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Text(
                        'تأكيد كلمة المرور الجديدة',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إدخال تأكيد كلمة المرور";
                          } else if (value.length < 6) {
                            return 'كلمة المرور يجب أن لا تكون أقل من 6 رموز';
                          } else if (_newPasswordController.text != value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('كلمات المرور غير متطابقة'),
                              ),
                            );
                            return 'كلمات السر غير متطابقة';
                          } else {
                            return null;
                          }
                        },
                        onEditingComplete: () {
                          _passwordFocusNode.unfocus();
                          updatePassword();
                          // register();
                        },
                        focusNode: _confirmNewPasswordFocusedNode,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _confirmNewPasswordController,
                        obscureText: !confirmNewPasswordVisibility,
                        decoration: InputDecoration(
                          hintText: 'أدخل كلمة المرور',
                          prefixIcon: const Icon(
                            Icons.password,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                confirmNewPasswordVisibility =
                                    !confirmNewPasswordVisibility;
                              });
                            },
                            child: Icon(
                              confirmNewPasswordVisibility == true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          suffixIconColor: AppColor.grey,
                          prefixIconColor: AppColor.grey,
                        ),
                      ),
                      // SizedBox(height: size.height * 0.03),
                      SizedBox(height: size.height * 0.1),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<ChangePasswordCubit,
                                ChangePasswordState>(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  current is ChangePasswordLoading ||
                                  current is ChangePasswordInvoked ||
                                  current is ChangePasswordError,
                              builder: (context, state) {
                                if (state is ChangePasswordLoading) {
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
                                    onPressed: updatePassword,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.orange8,
                                        foregroundColor: AppColor.white),
                                    child: Text(
                                      'تعديل كلمة المرور',
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
            );
          },
        ),
      ),
    );
  }
}
