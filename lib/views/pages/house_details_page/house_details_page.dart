import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/contact_section.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/bed_rooms_gallery_section.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/house_base_imagel.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/house_description_section.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/rooms_gallery_section.dart';

class HouseDetailsPage extends StatelessWidget {
  const HouseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<HouseDetailsCubit>(context);
    return BlocBuilder<HouseDetailsCubit, HouseDetailsState>(
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
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.022,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HouseBaseImage(
                          id: state.house.id,
                          imgUrl: state.house.imgUrl,
                          isFav: state.house.isFavorite,
                          cubit: cubit),
                      SizedBox(height: size.height * 0.03),
                      HouseDescriptionSection(
                        bathRoomsNumber: state.house.bathRoomsNumber,
                        roomsNumber: state.house.roomsNumber,
                        description: state.house.description,
                      ),
                      SizedBox(height: size.height * 0.03),
                      ContactSection(ownerName: state.house.ownerName),
                      SizedBox(height: size.height * 0.03),
                      BedRoomsGallerySection(
                          houseBedRooms: state.house.bedRooms),
                      SizedBox(height: size.height * 0.03),
                      RoomsGallerySection(housRooms: state.house.rooms),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
