import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';

class AddNewHouseFields extends StatefulWidget {
  const AddNewHouseFields({super.key});

  @override
  State<AddNewHouseFields> createState() => _AddNewHouseFieldsState();
}

class _AddNewHouseFieldsState extends State<AddNewHouseFields> {
  String? selectedlValue;
  List<String> selectedItems = [];
  late final TextEditingController _addressController, _descriptionController;
  late FocusNode _addressFocusNode, _descriptionFocusedNode;
  bool visibility = false;
  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _descriptionController = TextEditingController();
    _addressFocusNode = FocusNode();
    _descriptionFocusedNode = FocusNode();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'العنوان',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: size.height * 0.01),
        TextFormField(
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return "الرجاء إدخال إسم المستخدم";
          //   } else {
          //     return null;
          //   }
          // },

          textInputAction: TextInputAction.next,
          focusNode: _addressFocusNode,
          keyboardType: TextInputType.emailAddress,
          controller: _addressController,
          decoration: const InputDecoration(
            hintText: 'قم بإدخال العنوان ',
            suffixIcon: Icon(
              Icons.location_on_outlined,
            ),
            prefixIconColor: AppColor.grey,
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Text(
          'الموقع',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: size.height * 0.01),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<String>(
            hint: const Text(
              'قم بإدخال الموقع',
            ),
            isExpanded: true,
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(border: Border.all()),
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                selectedlValue = value!;
              });
            },
            items: ['الحرم القديم', 'الحرم الجديد', 'رفيديا']
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
            hint: const Text(
              'قم بإدخال نوع العقار',
            ),
            isExpanded: true,
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(border: Border.all()),
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                selectedlValue = value!;
              });
            },
            items: ['شقة', 'أستوديو', 'منزل']
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
          'الوصف',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: size.height * 0.01),
        TextFormField(
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return "الرجاء إدخال إسم المستخدم";
          //   } else {
          //     return null;
          //   }
          // },
          minLines: 5,
          maxLines: 30,
          textInputAction: TextInputAction.next,
          focusNode: _descriptionFocusedNode,
          keyboardType: TextInputType.emailAddress,
          controller: _descriptionController,
          decoration: const InputDecoration(
            hintText: 'قم بإدخال الوصف ',
            suffixIcon: Icon(
              Icons.description,
            ),
            prefixIconColor: AppColor.grey,
          ),
        ),
      ],
    );
  }
}
/*
Text(
          'السعر',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: size.height * 0.01),
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

          focusNode: _priceFocusNode,
          keyboardType: TextInputType.visiblePassword,
          controller: _priceController,
          obscureText: !visibility,
          decoration: const InputDecoration(
            hintText: 'قم بإدخال السعر',
            suffixIcon: Icon(
              FontAwesomeIcons.tag,
            ),
          ),
        ),
 */