import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miss_planet/util/material.dart';

class CustomCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final bool? circularShape;
  final bool? film;
  final String? rate;
  final String? type;
  final bool? news;
  final bool? comingSoon;
  final String? releaseDate;
  bool? cinema = false;
  CustomCacheImage(
      {Key? key, required this.imageUrl, required this.radius, this.circularShape,this.cinema, this.film = false, this.rate, this.type, this.news = false, this.comingSoon = false, this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return

    ClipRRect(
      borderRadius: cinema == true ? BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(circularShape == false ? 0 : radius),
          bottomRight: Radius.circular(circularShape == false ? 0 : radius)

      ) : BorderRadius.circular(4),
      child: cinema == true ? Image.asset(
        imageUrl!,
        fit: BoxFit.cover,
      ) : Container(

        height: 170,
        child: Stack(
          children: [

            CachedNetworkImage(

              imageUrl: imageUrl == null ? 'https://cinemagickh.oss-ap-southeast-7.aliyuncs.com/uploads/2023/05/31/220e277427af033f682f8709e54711ab.webp' : imageUrl!,
              fit: BoxFit.cover,
              height: 170,
              placeholder: (context, url) => Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: buildLoading(),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            film == true
            ? Positioned(
              top: 5,
              right: 5,
              child: Container(
                alignment: Alignment.center,

                height: 25,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        news == true ? Text('') : Icon(Icons.star,color: Colors.yellow,size: 14,),
                        Text(
                            ' ',
                            style: TextStyle(color: Colors.white,fontSize:12)
                        ),
                        news == true ? Text('${type}'.capitalizeFirst.toString(),style: TextStyle(fontSize: 12,color: Colors.white),) : Text(
                            rate == "0" ? '0' : rate!,
                            style: TextStyle(color: Colors.white,fontSize: 12)
                        )

                        // news == true ? TextSpan(): WidgetSpan(
                        //   child: Icon(Icons.star,color: Colors.yellow,size: 15,),
                        // ),
                        // TextSpan(
                        //     text: ' ',
                        //     style: TextStyle(color: Colors.white,fontSize:12)
                        // ),
                        // TextSpan(
                        //     text:  news == true ? '${type}'.capitalizeFirst :rate == "0" ? '0' : rate,
                        //     style: TextStyle(color: Colors.white,fontSize: 14)
                        // )
                      ]
                  ),
                )
              ),
            )
            : comingSoon == true ? Positioned(
              bottom: 10,

              child: Container(
                alignment: Alignment.center,
                  height: 25,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.black,

                  ),
                  child: Text('${material_App().convertDate(releaseDate ?? '')}',style: TextStyle(color: Colors.white,fontSize: 10),)
              ),
            ):Container()
          ],
        ),
      ),
    );
  }
}