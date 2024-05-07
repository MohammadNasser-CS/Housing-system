import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:housing_project/models/rooms_model.dart';

class GallerySection extends StatelessWidget {
  final List<RoomModel> rooms;
  const GallerySection({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المعرض',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.06,
              ),
        ),
        SizedBox(height: size.height * 0.015),
        FlutterCarousel(
          options: CarouselOptions(
            height: size.height * 0.17,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            slideIndicator: CircularWaveSlideIndicator(),
          ),
          items: rooms.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
