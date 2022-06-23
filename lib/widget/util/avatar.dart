import 'package:flutter/material.dart';
// import 'package:lazits_app/widget/util/util.dart';

class Avatar extends StatelessWidget {

  static const avatarPlaceholderImageUrl = 'assets/images/avatar_placeholder.png';

  final String photoUrl;
  final double size;
  final double opacity;
  final double borderSize;

  const Avatar({
    required this.photoUrl,
    required this.size,
    this.opacity = 1.0,
    this.borderSize = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(opacity),
              Colors.green.shade200.withOpacity(opacity),
            ],
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(borderSize),
        child: _buildImage(photoUrl),
      ),
    );
  }

  Widget _buildImage(String photoUrl) {
    if (photoUrl.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              opacity: opacity,
              image: const AssetImage(Avatar.avatarPlaceholderImageUrl), fit: BoxFit.cover
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              opacity: opacity,
              image: NetworkImage(photoUrl), fit: BoxFit.cover
          ),
        ),
      );
      // return Image(
      //   image: NetworkImage(
      //     photoUrl
      //   )
      // )

      // return CachedNetworkImage(
      //   imageUrl: photoUrl,
      //   imageBuilder: (context, imageProvider) => Container(
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       image: DecorationImage(
      //           opacity: opacity,
      //           image: imageProvider, fit: BoxFit.cover
      //       ),
      //     ),
      //   ),
      //   placeholder: (context, url) {
      //     return Container(
      //       decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         image: DecorationImage(
      //             fit: BoxFit.cover,
      //             image: getNextBlurHashImage()
      //         ),
      //       ),
      //       width: double.infinity,
      //       height: double.infinity,
      //     );
      //   },
      //   errorWidget: (context, url, error) => Icon(Icons.error),
      // );
    }
  }


}
