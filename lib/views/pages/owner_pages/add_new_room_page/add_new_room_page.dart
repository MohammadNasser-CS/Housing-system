import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/owner_house_details_cubit/owner_house_details_cubit.dart';
import 'package:housing_project/models/houses_models/room_details_models/add_room_model.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/widgets/title_value_widget.dart';
import 'package:image_picker/image_picker.dart';

class AddNewRoomPage extends StatefulWidget {
  final String houseId;
  const AddNewRoomPage({super.key, required this.houseId});

  @override
  State<AddNewRoomPage> createState() => _AddNewRoomPageState();
}

class _AddNewRoomPageState extends State<AddNewRoomPage> {
  late final GlobalKey<FormState> _formKey;
  String? selectedlUniversityBuilding, selectedGender, selectedType;
  List<String> selectedItems = [];
  late final TextEditingController _bedNumberController,
      _roomPriceController,
      _roomSpaceController;
  late FocusNode _bedsNumberFocusNode,
      _roomPriceFocusedNode,
      _roomSpaceFocusedNode;
  bool visibility = false,
      deskCheckbox = false,
      acCheckbox = false,
      balconyCheckbox = false;
  List<File?> files = List<File?>.filled(3, null, growable: false);
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _bedNumberController = TextEditingController();
    _roomPriceController = TextEditingController();
    _roomSpaceController = TextEditingController();
    _bedsNumberFocusNode = FocusNode();
    _roomPriceFocusedNode = FocusNode();
    _roomSpaceFocusedNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _bedNumberController.dispose();
    _roomPriceController.dispose();
    _roomSpaceController.dispose();
    super.dispose();
  }

  Future<void> pickPhoto(int index) async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        files[index] = File(photo.path);
      });
    }
  }

  Future<void> addRoom() async {
    int photoCount = files.where((file) => file != null).length;
    if (photoCount < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب إدخال صورتين على الأقل'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      List<Map<String, String>> base64ImagesWithExtension = [];
      // Convert each file to base64 and add to the list
      for (var file in files) {
        if (file != null) {
          String base64Image = base64Encode(file.readAsBytesSync());
          String imageName = file.path.split('/').last;
          String imageExtension = imageName.split('.').last;

          base64ImagesWithExtension.add({
            'base64Image': base64Image,
            'imageExtension': imageExtension,
          });
        }
      }
      BlocProvider.of<OwnerHouseDetailsCubit>(context).addNewRoom(
        AddRoomModel(
          houseId: widget.houseId,
          roomType: 'نوم',
          bedNumber: _bedNumberController.text,
          bedNumberBooked: '0',
          price: _roomPriceController.text,
          roomSpace: _roomSpaceController.text,
          ac: acCheckbox ? 'نعم' : 'لا',
          balcony: balconyCheckbox ? 'نعم' : 'لا',
          desk: deskCheckbox ? 'نعم' : 'لا',
          photos: base64ImagesWithExtension,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OwnerHouseDetailsCubit>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: const TitleValueWidget(text: 'إضافة عقار'),
      ),
      body: BlocListener<OwnerHouseDetailsCubit, OwnerHouseDetailsState>(
        listenWhen: (previous, current) =>
            current is AddNewRoomSuccess || current is OwnerHouseDetailsError,
        listener: (context, state) {
          if (state is AddNewRoomSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 1),
              ),
            );
            Navigator.of(context).pop(context);
          } else if (state is OwnerHouseDetailsError) {
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
                      'عدد الأسرّة في الغرفة',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      onEditingComplete: () {
                        _bedsNumberFocusNode.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_roomPriceFocusedNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء إدخال عدد الأسرّة";
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _bedsNumberFocusNode,
                      keyboardType: TextInputType.number,
                      controller: _bedNumberController,
                      decoration: const InputDecoration(
                        hintText: 'حدد عدد الأسرّة في الغرفة',
                        suffixIcon: Icon(
                          Icons.bed_outlined,
                        ),
                        prefixIconColor: AppColor.grey,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // Text(
                    //   'عدد الأسرّة المحجوزة في الغرفة',
                    //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    // ),
                    // SizedBox(height: size.height * 0.01),
                    // TextFormField(
                    //   onEditingComplete: () {
                    //     _addressFocusNode.unfocus();
                    //     FocusScope.of(context)
                    //         .requestFocus(_descriptionFocusedNode);
                    //   },
                    //   textInputAction: TextInputAction.next,
                    //   focusNode: _addressFocusNode,
                    //   keyboardType: TextInputType.number,
                    //   controller: _addressController,
                    //   decoration: const InputDecoration(
                    //     hintText: 'حدد عدد الأسرّة المحجوزة في الغرفة',
                    //     suffixIcon: Icon(
                    //       Icons.bed_outlined,
                    //     ),
                    //     prefixIconColor: AppColor.grey,
                    //   ),
                    // ),
                    // SizedBox(height: size.height * 0.03),
                    // Text(
                    //   'الحرم الجامعي',
                    //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    // ),
                    Text(
                      'تكلفة حجز الغرفة',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      onEditingComplete: () {
                        _roomPriceFocusedNode.unfocus();
                        FocusScope.of(context)
                            .requestFocus(_roomSpaceFocusedNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء إدخال تكلفة حجز الغرفة";
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _roomPriceFocusedNode,
                      keyboardType: TextInputType.number,
                      controller: _roomPriceController,
                      decoration: const InputDecoration(
                        hintText: 'أدخل تكلفة حجز الغرفة',
                        suffixIcon: Icon(
                          Icons.money,
                        ),
                        prefixIconColor: AppColor.grey,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'مساحة الغرفة',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextFormField(
                      onEditingComplete: () {
                        _roomSpaceFocusedNode.unfocus();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء إدخال مساحة الغرفة";
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _roomSpaceFocusedNode,
                      keyboardType: TextInputType.number,
                      controller: _roomSpaceController,
                      decoration: const InputDecoration(
                        hintText: 'أدخل مساحة الغرفة',
                        suffixIcon: Icon(
                          Icons.space_bar,
                        ),
                        prefixIconColor: AppColor.grey,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'هل تحتوي الغرفة على:',
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CheckboxListTile(
                                    fillColor: WidgetStatePropertyAll(
                                        deskCheckbox ? AppColor.green : null),
                                    contentPadding:
                                        const EdgeInsetsDirectional.all(12.0),
                                    value: deskCheckbox,
                                    secondary: const Icon(
                                      Icons.desk,
                                      color: AppColor.brown,
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        deskCheckbox = value!;
                                      });
                                    },
                                    title: Text(
                                      'مكتب',
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
                                        acCheckbox ? AppColor.green : null),
                                    value: acCheckbox,
                                    contentPadding:
                                        const EdgeInsetsDirectional.all(12.0),
                                    secondary: const Icon(
                                      Icons.ac_unit_outlined,
                                      color: AppColor.blue,
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        acCheckbox = value!;
                                      });
                                    },
                                    title: Text(
                                      'مكيف',
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
                                        balconyCheckbox
                                            ? AppColor.green
                                            : null),
                                    contentPadding:
                                        const EdgeInsetsDirectional.all(12.0),
                                    value: balconyCheckbox,
                                    secondary: const Icon(
                                      Icons.balcony_outlined,
                                      color: AppColor.teal,
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        balconyCheckbox = value!;
                                      });
                                    },
                                    title: Text(
                                      'بلكونة',
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
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'صور للغرفة: ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: AppColor.black),
                          ),
                          TextSpan(
                            text: 'على الأقل صورتان.',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.red),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      height: size.height * 0.15,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 8.0),
                          child: InkWell(
                            onTap: () async {
                              await pickPhoto(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  border: Border.all(color: AppColor.grey)),
                              child: files[index] == null
                                  ? Icon(
                                      Icons.add_a_photo_outlined,
                                      size: size.width * 0.2,
                                      color: AppColor.grey,
                                    )
                                  : Image.file(
                                      files[index]!,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<OwnerHouseDetailsCubit,
                          OwnerHouseDetailsState>(
                        bloc: cubit,
                        buildWhen: (previous, current) =>
                            current is OwnerHouseDetailsLoading ||
                            current is OwnerHouseDetailsError,
                        builder: (context, state) {
                          if (state is OwnerHouseDetailsLoading) {
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
                              onPressed: addRoom,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsetsDirectional.all(
                                    size.width * 0.025),
                                backgroundColor: AppColor.orange8,
                                foregroundColor: AppColor.white,
                              ),
                              child: Text(
                                'إضافة غرفة',
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
