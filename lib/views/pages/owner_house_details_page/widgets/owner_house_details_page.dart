import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/owner_house_details_cubit/owner_house_details_cubit.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/house_base_imagel.dart';
import 'package:housing_project/views/pages/owner_house_details_page/widgets/owner_bed_rooms_gallery_section.dart';
import 'package:housing_project/views/pages/owner_house_details_page/widgets/owner_house_description_section.dart';
import 'package:housing_project/views/pages/owner_house_details_page/widgets/owner_rooms_gallery_section.dart';

class OwnerHouseDetailsPage extends StatelessWidget {
  const OwnerHouseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<OwnerHouseDetailsCubit>(context);
    return BlocConsumer<OwnerHouseDetailsCubit, OwnerHouseDetailsState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          current is AddNewRoomSuccess || current is OwnerRoomDetailsError,
      listener: (context, state) {
        if (state is AddNewRoomSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is OwnerHouseDetailsLoading ||
          current is OwnerHouseDetailsLoaded ||
          current is OwnerHouseDetailsError,
      builder: (context, state) {
        if (state is OwnerHouseDetailsLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()));
        } else if (state is OwnerHouseDetailsLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('التفاصيل'),
              centerTitle: true,
              backgroundColor: AppColor.grey1,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: size.width * 0.03,
                    vertical: size.height * 0.022,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HouseBaseImage(
                        id: state.houseDetails.houseId,
                        imgUrl: state.houseDetails.housePhoto,
                      ),
                      SizedBox(height: size.height * 0.03),
                      OwnerHouseDescriptionSection(
                        description: state.houseDetails.description,
                        electricity: state.houseDetails.electricity,
                        gas: state.houseDetails.gas,
                        internet: state.houseDetails.internet,
                        water: state.houseDetails.water,
                      ),
                      SizedBox(height: size.height * 0.03),
                      // ContactSection(
                      //     ownerName: state.houseDetails.ownerName,
                      //     phoneNumber: state.houseDetails.phoneNumber),
                      SizedBox(height: size.height * 0.03),
                      OwnerBedRoomsGallerySection(
                        id: state.houseDetails.houseId,
                        roomsModel: state.houseDetails.primaryRooms,
                      ),
                      SizedBox(height: size.height * 0.03),
                      OwnerRoomsGallerySection(
                          id: state.houseDetails.houseId,
                          housRooms: state.houseDetails.secondaryRooms),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(body: Center(child: Text('failed')));
        }
      },
    );
  }
}
