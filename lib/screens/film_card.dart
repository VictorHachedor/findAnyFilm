import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../network/film_model.dart';

Widget filmCard(APIResults result) {
  const String imageBaseUrl =
      'https://www.themoviedb.org/t/p/w300_and_h450_bestv2';
  return Card(
    elevation: 0.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0),),
            child: CachedNetworkImage(
                imageUrl: imageBaseUrl +(result.posterPath ?? '/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg') ,
                //(imageBaseUrl + result.posterPath) ?? '/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg') - try
                height: 258,
                width: 200,
                fit: BoxFit.fill)),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            child:  Text(
            result.title ?? 'blank',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
            width: 150,
            )
        ),
      ],
    ),
  );
}
