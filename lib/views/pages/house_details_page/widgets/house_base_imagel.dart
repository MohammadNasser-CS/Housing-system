import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';

class HouseBaseImage extends StatelessWidget {
  final String imgUrl;
  final String id;
  final bool isFav;
  final dynamic cubit;
  const HouseBaseImage({super.key,required this.id,required this.imgUrl,required this.isFav,required this.cubit,});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Stack(
                        children: [
                          Container(
                            height: size.height * 0.25,
                            width: size.width,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.grey.shade200,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: imgUrl,
                              height: size.height * 0.3,
                              width: size.width,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator.adaptive()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            top: 3.0,
                            right: 3.0,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black26,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  cubit.changeFavorite(id);
                                },
                                icon: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColor.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
  }
}