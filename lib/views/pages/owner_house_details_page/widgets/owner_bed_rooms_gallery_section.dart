import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/controllers/owner_house_details_cubit/owner_house_details_cubit.dart';
import 'package:housing_project/views/widgets/no_items_wiget.dart';
import 'package:housing_project/views/widgets/text_widget.dart';

class OwnerBedRoomsGallerySection extends StatefulWidget {
  final List<Map<String, String>> roomsModel;
  final String id;
  const OwnerBedRoomsGallerySection({
    super.key,
    required this.id,
    required this.roomsModel,
  });

  @override
  State<OwnerBedRoomsGallerySection> createState() =>
      _OwnerBedRoomsGallerySectionState();
}

class _OwnerBedRoomsGallerySectionState
    extends State<OwnerBedRoomsGallerySection>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<OwnerHouseDetailsCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'غرف النوم',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.of(context)
                    .pushNamed(AppRoutes.addNewRoom, arguments: widget.id);
                cubit.getOwnerHouseDetails(widget.id);
              },
              child: Text(
                'أضف غرفة جديدة',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.blue,
                    ),
              ),
            )
          ],
        ),
        SizedBox(height: size.height * 0.015),
        if (widget.roomsModel.isNotEmpty)
          SizedBox(
            height: size.height * 0.15,
            width: double.infinity,
            child: ListView.builder(
              itemCount: widget.roomsModel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        width: size.width * 0.33,
                        imageUrl: widget.roomsModel[index]['photo']!,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator.adaptive()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 5.0,
                    child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: AppColor.white,
                            border: Border.all(color: AppColor.grey4)),
                        child: TextWidget(
                            title: 'رقم الغرفة: ',
                            value: widget.roomsModel[index]['roomId']!)),
                  ),
                ],
              ),
            ),
          ),
        if (widget.roomsModel.isEmpty)
          const NoItemsWidget(
              title: 'لم يتم إضافة غرف', icon: Icons.meeting_room_outlined),
      ],
    );
  }
}
