import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Display a image of fixed size, with loading indicator
class ImageContainer extends StatelessWidget {
  /// Image border radius
  final BorderRadius borderRadius;

  /// Image height
  final double height;

  /// Image source
  final String imageURL;

  /// Image width
  final double width;

  // ignore: public_member_api_docs
  const ImageContainer(
      {Key? key,
      required this.height,
      required this.imageURL,
      required this.width,
      required this.borderRadius})
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
