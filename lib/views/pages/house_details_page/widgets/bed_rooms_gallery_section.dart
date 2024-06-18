import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/bed_rooms_gallery_widgets/bed_room_discovering_dialog.dart';
import 'package:housing_project/views/widgets/text_widget.dart';

class BedRoomsGallerySection extends StatefulWidget {
  final List<Map<String, String>> roomsModel;
  const BedRoomsGallerySection({
    super.key,
    required this.roomsModel,
  });

  @override
  State<BedRoomsGallerySection> createState() => _BedRoomsGallerySectionState();
}

class _BedRoomsGallerySectionState extends State<BedRoomsGallerySection>
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
    final cubit = BlocProvider.of<HouseDetailsCubit>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'غرف النوم',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: size.height * 0.015),
        SizedBox(
          height: size.height * 0.15,
          width: double.infinity,
          child: ListView.builder(
            itemCount: widget.roomsModel.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              onTap: () async {
                await showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  useRootNavigator: true,
                  useSafeArea: true,
                  showDragHandle: true,
                  enableDrag: true,
                  builder: (BuildContext context) {
                    return BottomSheet(
                      dragHandleColor: AppColor.grey4,
                      backgroundColor: AppColor.white,
                      onClosing: () {},
                      animationController: _animationController,
                      builder: (context) => StatefulBuilder(
                        builder: (context, setState) {
                          cubit.getRoomDetails(
                              widget.roomsModel[index]['roomId']!);
                          return BlocProvider.value(
                            value: cubit,
                            child: const BedRoomDiscoveringDialog(),
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.roomsModel[index]['photo']!,
                        // height: size.height * 0.06,
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
        ),
      ],
    );
  }
}
