import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/views/pages/student_pages/house_details_page/widgets/contact_section.dart';
import 'package:housing_project/views/pages/student_pages/house_details_page/widgets/bed_rooms_gallery_section.dart';
import 'package:housing_project/views/pages/student_pages/house_details_page/widgets/house_base_imagel.dart';
import 'package:housing_project/views/pages/student_pages/house_details_page/widgets/house_description_section.dart';
import 'package:housing_project/views/pages/student_pages/house_details_page/widgets/rooms_gallery_section.dart';

class HouseDetailsPage extends StatelessWidget {
  const HouseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<HouseDetailsCubit>(context);
    return BlocConsumer<HouseDetailsCubit, HouseDetailsState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          current is FavroiteDetailsChangedSuccess ||
          current is RequestReservationDone ||
          current is RoomDetailsError,
      listener: (context, state) {
        if (state is FavroiteDetailsChangedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is HouseDetailsLoading ||
          current is HouseDetailsLoaded ||
          current is HouseDetailsError,
      builder: (context, state) {
        if (state is HouseDetailsLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()));
        } else if (state is HouseDetailsLoaded) {
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
                          isFav: state.houseDetails.isFavorite,
                          cubit: cubit),
                      SizedBox(height: size.height * 0.03),
                      HouseDescriptionSection(
                        description: state.houseDetails.description,
                        electricity: state.houseDetails.electricity,
                        gas: state.houseDetails.gas,
                        internet: state.houseDetails.internet,
                        water: state.houseDetails.water,
                      ),
                      SizedBox(height: size.height * 0.03),
                      ContactSection(
                          ownerName: state.houseDetails.ownerName,
                          phoneNumber: state.houseDetails.phoneNumber),
                      SizedBox(height: size.height * 0.03),
                      BedRoomsGallerySection(
                        roomsModel: state.houseDetails.primaryRooms,
                      ),
                      SizedBox(height: size.height * 0.03),
                      RoomsGallerySection(
                          housRooms: state.houseDetails.secondaryRooms),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is HouseDetailsError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
