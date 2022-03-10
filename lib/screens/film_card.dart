import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_any_movie/network/film_service.dart';
import 'package:flutter/material.dart';
import '../network/film_model.dart';
import 'package:find_any_movie/themes.dart';

Widget filmCard(APIResults result) {
  return Card(
    color: FilmTheme.backgroundColor,
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
          child: CachedNetworkImage(
            imageUrl: GetImageUrl.imageUrl(result.posterPath ?? ''),
            errorWidget: (context, url, error) =>
                Image.asset('assets/default-image_three.png', height: 258,
            width: 200,
            fit: BoxFit.fill,),
            height: 258,
            width: 200,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              child: Text(
                result.title ?? 'blank',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: FilmTheme.textTheme.subtitle1,
              ),
              width: 150,
            )),
      ],
    ),
  );
}
