import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoomBaseImage extends StatelessWidget {
  final String imgUrl;
  final String id;
  final dynamic cubit;
  const RoomBaseImage({
    super.key,
    required this.id,
    required this.imgUrl,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              // height: size.height * 0.06,
              // width: double.infinity,
              height: size.height * 0.2,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.01),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              // height: size.height * 0.06,
              // width: double.infinity,
              height: size.height * 0.2,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.01),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              // height: size.height * 0.06,
              // width: double.infinity,
              height: size.height * 0.2,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }
}
