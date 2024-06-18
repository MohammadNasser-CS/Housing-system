import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoomsGallerySection extends StatelessWidget {
  final List<Map<String, String>> housRooms;
  const RoomsGallerySection({
    super.key,
    required this.housRooms,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الغرف الأخرى',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: size.height * 0.015),
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
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
