import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/models/rooms_model.dart';

class RoomsGallerySection extends StatelessWidget {
  final List<RoomModel> rooms;
  const RoomsGallerySection({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المعرض',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: size.height * 0.015),
        SizedBox(
          height: size.height * 0.1,
          width: double.infinity,
          child: ListView.builder(
            itemCount: rooms.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                // showModalBottomSheet<void>(
                //                 context: context,
                //                 builder: (BuildContext context) {
                //                   return BottomSheet(
                //                     onClosing: () {},
                //                     builder: (context) => StatefulBuilder(
                //                       builder: (context, setState) =>
                //                           BlocProvider.value(
                //                         value: cubit,
                //                         child: ProductDetailsDialog(
                //                             productItemModel: state.productItem,),
                //                       ),
                //                     ),
                //                   );
                //                 },
                //               );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: rooms[index].imageUrl,
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
        ),
      ],
    );
  }
}
