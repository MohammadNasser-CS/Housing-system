import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/dropdown_lists_options.dart';
import 'package:housing_project/controllers/add_new_house_cubit/add_new_house_cubit.dart';
import 'package:housing_project/models/houses_models/house_model.dart';
import 'package:housing_project/models/houses_models/requestModels/house_request_model.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/widgets/title_value_widget.dart';

class AddNewHousePage extends StatefulWidget {
  const AddNewHousePage({super.key});

  @override
  State<AddNewHousePage> createState() => _AddNewHousePageState();
}

class _AddNewHousePageState extends State<AddNewHousePage> {
  late final GlobalKey<FormState> _formKey;
  String? selectedlUniversityBuilding, selectedGender, selectedType;
  List<String> selectedItems = [];
  late final TextEditingController _addressController, _descriptionController;
  late FocusNode _addressFocusNode, _descriptionFocusedNode;
  bool visibility = false,
      electricCheckbox = false,
      waterCheckbox = false,
      wifiCheckbox = false,
      gasCheckbox = false;
  HouseModel? newHouseModel;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _addressController = TextEditingController();
    _descriptionController = TextEditingController();
    _addressFocusNode = FocusNode();
    _descriptionFocusedNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> nextStep() async {
    if (_formKey.currentState!.validate()) {
      await BlocProvider.of<AddNewHouseCubit>(context).addNewHouse(
        HouseRequestModel(
          description: _descriptionController.text,
          address: _addressController.text,
          gender: selectedGender == 'ذكر' ? 'طلاب' : 'طالبات',
          location: selectedlUniversityBuilding!,
          houseType: selectedType!,
          electricity: electricCheckbox ? 'نعم' : 'لا',
          gas: gasCheckbox ? 'نعم' : 'لا',
          internet: wifiCheckbox ? 'نعم' : 'لا',
          water: waterCheckbox ? 'نعم' : 'لا',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddNewHouseCubit>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: const TitleValueWidget(text: 'إضافة عقار'),
      ),
      body: BlocListener<AddNewHouseCubit, AddNewHouseState>(
        listenWhen: (previous, current) =>
            current is AddNewHouseSuccess || current is AddNewHouseError,
        listener: (context, state) {
          if (state is AddNewHouseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 1),
              ),
            );
            Navigator.of(context).pop(context);
          } else if (state is AddNewHouseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        bloc: cubit,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'العنوان',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء إدخال العنوان";
                        } else if (!RegExp(r'^[ء-ي]+ - [ء-ي\s]+$')
                            .hasMatch(value)) {
                          return "الرجاء إدخال العنوان بتنسيق صحيح مثل (نابلس - بيت وزن)";
                        } else {
                          return null;
                        }
                      },
                      onEditingComplete: () {
                        _addressFocusNode.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusedNode);
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _addressFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      controller: _addressController,
                      decoration: const InputDecoration(
                        hintText: 'نابلس - بيت وزن',
                        suffixIcon: Icon(
                          Icons.location_on_outlined,
                        ),
                        prefixIconColor: AppColor.grey,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'الوصف',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "حقل إلزامي - الرجاء إدخال وصف لموقع العقار";
                        } else {
                          return null;
                        }
                      },
                      minLines: 5,
                      maxLines: 30,
                      textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocusedNode,
                      keyboardType: TextInputType.emailAddress,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'قم بإدخال الوصف الدقيق لموقع العقار ',
                        suffixIcon: Icon(
                          Icons.description,
                        ),
                        prefixIconColor: AppColor.grey,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'الحرم الجامعي',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "حقل إلزامي - الرجاء إختيار الحرم الجامعي الأقرب";
                          } else {
                            return null;
                          }
                        },
                        hint: const Text(
                          'إختر الحرم الجامعي الأقرب',
                        ),
                        isExpanded: true,
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(border: Border.all()),
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          selectedlUniversityBuilding = value!;
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
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'طلاب/طالبات',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "حقل إلزامي - الرجاء إختيار هل طلاب أم طالبات";
                          } else {
                            return null;
                          }
                        },
                        hint: const Text(
                          'إختر هل السكن طلاب أم طالبات',
                        ),
                        isExpanded: true,
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(border: Border.all()),
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          selectedGender = value!;
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
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'نوع العقار',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "حقل إلزامي - الرجاء إختيار نوع العقار";
                          } else {
                            return null;
                          }
                        },
                        hint: const Text(
                          'إختر نوع العقار',
                        ),
                        isExpanded: true,
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(border: Border.all()),
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          selectedType = value!;
                        },
                        items: houseType
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
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'حدد الخدمات المتاحة ضمن تكلفة حجز الغرف',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(color: AppColor.grey4),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    fillColor: WidgetStatePropertyAll(
                                        electricCheckbox
                                            ? AppColor.green
                                            : null),
                                    contentPadding:
                                        const EdgeInsetsDirectional.all(12.0),
                                    value: electricCheckbox,
                                    secondary: const Icon(
                                      Icons.electric_bolt_outlined,
                                      color: AppColor.yellow,
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        electricCheckbox = value!;
                                      });
                                    },
                                    title: Text(
                                      'الكهرباء',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(),
                                Expanded(
                                  child: CheckboxListTile(
                                    fillColor: WidgetStatePropertyAll(
                                        waterCheckbox ? AppColor.green : null),
                                    value: waterCheckbox,
                                    contentPadding:
                                        const EdgeInsetsDirectional.all(12.0),
                                    secondary: const Icon(
                                      Icons.water_drop_outlined,
                                      color: AppColor.blue,
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        waterCheckbox = value!;
                                      });
                                    },
                                    title: Text(
                                      'الماء',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 0),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    fillColor: WidgetStatePropertyAll(
                                        wifiCheckbox ? AppColor.green : null),
                                    contentPadding:
                                        const EdgeInsetsDirectional.all(12.0),
                                    value: wifiCheckbox,
                                    secondary: const Icon(
                                      Icons.wifi,
                                      color: AppColor.green,
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        wifiCheckbox = value!;
                                      });
                                    },
                                    title: Text(
                                      'الإنترنت',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                  ),
                                ),
                                const VerticalDivider(),
                                Expanded(
                                  child: CheckboxListTile(
                                    fillColor: WidgetStatePropertyAll(
                                        gasCheckbox ? AppColor.green : null),
                                    value: gasCheckbox,
                                    contentPadding:
                                        const EdgeInsetsDirectional.all(12.0),
                                    secondary: const Icon(
                                      Icons.gas_meter,
                                      color: AppColor.orange,
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        gasCheckbox = value!;
                                      });
                                    },
                                    title: Text(
                                      'الغاز',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<AddNewHouseCubit, AddNewHouseState>(
                        bloc: cubit,
                        buildWhen: (previous, current) =>
                            current is AddNewHouseLoading ||
                            current is AddNewHouseError,
                        builder: (context, state) {
                          if (state is AddNewHouseLoading) {
                            return ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsetsDirectional.all(
                                    size.width * 0.025),
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
                                padding: EdgeInsetsDirectional.all(
                                    size.width * 0.025),
                                backgroundColor: AppColor.orange8,
                                foregroundColor: AppColor.white,
                              ),
                              child: Text(
                                'إضافة سكن',
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
      ),
    );
  }
}
