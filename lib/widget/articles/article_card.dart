import 'package:article_repository/article_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazitsapp_admin/widget/articles/article_card_length_badge.dart';

class ArticleCard extends StatelessWidget {

  final Article article;

  const ArticleCard(
    this.article,
    {Key? key}
  ) : super(key: key);

  void _handleCardTap(BuildContext context) {
    GoRouter.of(context).go('/articles/${article.id}');
  }

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () => _handleCardTap(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            AspectRatio(
              aspectRatio: 16/9,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Stack(
                    children: [
                      Image(
                        image: NetworkImage(
                          article.getCoverImageUrl(ArticleImageVersion.thumbnail),
                        ),
                        width: 200,
                        height: 200,
                      ),

                      // AppCachedNetworkImage(this.article.getCoverImageUrl(ArticleImageVersion.thumbnail)),
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: ArticleCardLengthBadge(article),
                      ),
                      // Positioned(
                      //     right: 8,
                      //     bottom: 8,
                      //     child: AppCircularIcon(
                      //       icon: AppIcons.media_play,
                      //       size: 20.0,
                      //     )
                      // )
                    ]
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(
                    article.name,
                    maxLines: 3,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  Text(
                      article.author.displayName,
                      maxLines: 3,
                      style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                      )
                  ),
                ]
              ),
            ),

          ],

        )
      );

  }

}

//
// class ArticleCardLoading extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: AppColors.darkIndigo.shade400,
//       highlightColor: AppColors.darkIndigo.shade100,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AspectRatio(
//             aspectRatio: 16/9,
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(8.0)),
//               child: Image(
//                 image: getNextBlurHashImage(),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget> [
//                 Container(
//                   width: 150,
//                   height: 18,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4.0),
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Container(
//                   width: 90,
//                   height: 14,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4.0),
//                     color: Colors.white,
//                   ),
//                 ),
//               ]
//             ),
//           ),
//         ],
//
//       ),
//     );
//   }
//
// }
