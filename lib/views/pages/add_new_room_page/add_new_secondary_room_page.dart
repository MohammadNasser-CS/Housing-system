import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/owner_house_details_cubit/owner_house_details_cubit.dart';
import 'package:housing_project/models/houses_models/room_details_models/add_secondary_room_model.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/widgets/title_value_widget.dart';
import 'package:image_picker/image_picker.dart';

class AddNewSecondaryRoomPage extends StatefulWidget {
  final String houseId;
  const AddNewSecondaryRoomPage({super.key, required this.houseId});

  @override
  State<AddNewSecondaryRoomPage> createState() =>
      _AddNewSecondaryRoomPageState();
}

class _AddNewSecondaryRoomPageState extends State<AddNewSecondaryRoomPage> {
  File? file;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> pickPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        file = File(photo.path);
      });
    }
  }

  Future<void> addRoom() async {
    if (file != null) {
      String base64Image = base64Encode(file!.readAsBytesSync());
      String imageName = file!.path.split('/').last;
      String imageExtension = imageName.split('.').last;
      BlocProvider.of<OwnerHouseDetailsCubit>(context).addNewSecondaryRoom(
        AddSecondaryRoom(
          houseId: widget.houseId,
          roomType: 'ثانوية',
          base64Image: base64Image,
          imageExtension: imageExtension,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'صورة للغرفة الثانوية: ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColor.black),
                        ),
                        TextSpan(
                          text: 'حمام/مطبخ/صالون/..الخ',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.red),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  InkWell(
                    onTap: () async {
                      await pickPhoto();
                    },
                    child: Container(
                      width: size.width,
                      height: size.height * 0.5,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(color: AppColor.grey)),
                      child: file == null
                          ? Icon(
                              Icons.add_a_photo_outlined,
                              size: size.width * 0.2,
                              color: AppColor.grey,
                            )
                          : Image.file(
                              file!,
                              fit: BoxFit.fill,
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
                            onPressed: addRoom,
                            style: ElevatedButton.styleFrom(
                              padding:
                                  EdgeInsetsDirectional.all(size.width * 0.025),
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
    );
  }
}
