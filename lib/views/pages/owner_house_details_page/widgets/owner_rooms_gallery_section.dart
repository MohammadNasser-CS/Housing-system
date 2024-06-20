import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/controllers/owner_house_details_cubit/owner_house_details_cubit.dart';
import 'package:housing_project/views/widgets/no_items_wiget.dart';

class OwnerRoomsGallerySection extends StatelessWidget {
  final List<Map<String, String>> housRooms;
  final String id;
  const OwnerRoomsGallerySection({
    super.key,
    required this.id,
    required this.housRooms,
  });

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
              'الغرف الأخرى',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.of(context)
                    .pushNamed(AppRoutes.addNewSecondaryRoom, arguments: id);
                cubit.getOwnerHouseDetails(id);
                debugPrint('tsete');
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
        if (housRooms.isNotEmpty)
          SizedBox(
            height: size.height * 0.15,
            width: double.infinity,
            child: ListView.builder(
              itemCount: housRooms.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: housRooms[index]['photo']!,
                    // height: size.height * 0.06,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator.adaptive()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
        if (housRooms.isEmpty)
          const NoItemsWidget(
              title: 'لم يتم إضافة غرف', icon: Icons.bathroom_outlined),
      ],
    );
  }
}
