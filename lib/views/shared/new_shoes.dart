import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewShoes extends StatelessWidget {
  final String imageUrl;
  const NewShoes({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.8,
                offset: Offset(0, 1))
          ],
          borderRadius: BorderRadius.all(
              Radius.circular(10))),
      height:
          MediaQuery.of(context).size.height * 0.11,
      width:
          MediaQuery.of(context).size.width * 0.28,
      child: CachedNetworkImage(
        imageUrl:
            imageUrl,
      ),
    );
  }
}
