import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final BorderRadius? borderRadius;
  final double height;
  final String imageURL;
  final double width;

  const ImageContainer(
      {Key? key,
      required this.height,
      required this.imageURL,
      required this.width,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: imageURL,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress))),
        ),
      ),
    );
  }
}
