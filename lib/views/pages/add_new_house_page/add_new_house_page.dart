import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/controllers/add_new_house_cubit/add_new_house_cubit.dart';
import 'package:housing_project/views/pages/add_new_house_page/widgets/add_new_house_fields.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/widgets/title_value_widget.dart';

class AddNewHousePage extends StatefulWidget {
  const AddNewHousePage({super.key});

  @override
  State<AddNewHousePage> createState() => _AddNewHousePageState();
}

class _AddNewHousePageState extends State<AddNewHousePage> {
  late final GlobalKey<FormState> _formKey;
  bool visibility = false, isFirstIndormation = true;
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
    if (isFirstIndormation) {
      setState(() {
        isFirstIndormation = !isFirstIndormation;
      });
    } else {
      if (_formKey.currentState!.validate()) {
        // await BlocProvider.of<AuthCubit>(context).register(
        //   _emailController.text,
        //   _passwordController.text,
        //   _usernameController.text,
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: const TitleValueWidget(text: 'إضافة عقار'),
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
                  SizedBox(height: size.height * 0.02),
                  isFirstIndormation
                      ? const AddNewHouseFields()
                      : const AddNewHouseFields(),
                  SizedBox(height: size.height * 0.06),
                  SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<AddNewHouseCubit, AddNewHouseState>(
                      bloc: BlocProvider.of<AddNewHouseCubit>(context),
                      listenWhen: (previous, current) =>
                          current is AddNewHouseDoneSuccess ||
                          current is AddNewHouseError,
                      listener: (context, state) {
                        if (state is AddNewHouseDoneSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم إضافة العقار بنجاح'),
                            ),
                          );
                          Navigator.of(context).pushNamed(AppRoutes.home);
                        } else if (state is AddNewHouseError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is AddNewHouseLoading ||
                          current is AddNewHouseError,
                      builder: (context, state) {
                        if (state is AddNewHouseLoading) {
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
