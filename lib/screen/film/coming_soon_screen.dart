import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miss_planet/controller/film_controller.dart';
import 'package:miss_planet/helper/custo_scaffold.dart';
import 'package:miss_planet/screen/film/movie_screen.dart';
import 'package:miss_planet/util/material.dart';
import 'package:miss_planet/util/next_screen.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({super.key});

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  bool _isLoading = false;
  init () async {
    _isLoading = true;
    await Get.find<FilmController>().comingSoon();
    setState(() {
      _isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    init();
  }
  Widget build(BuildContext context) {
    return CustomScaffold(body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [

            buildMainAppBar(title: 'coming_soon'),
            SizedBox(height: 20,),
            _isLoading ? buildLoading() : GetBuilder<FilmController>(
              builder: (controller) {
                return Container(
                  width: Get.width,
                  height: Get.height ,
                  child: ListView.builder(
                    itemCount: controller.comingSoonModel!.length,
                    itemBuilder: (context, index) {
                      print(controller.comingSoonModel!.keys.toList());
                      return Column(
                        children: [
                          Container(
                            width: Get.width,

                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(

                              gradient: LinearGradient(
                                tileMode: TileMode.repeated,
                                colors: [
                                  Color(0xffE1E1E1).withOpacity(0.13),
                                  Color(0xff2F94F2).withOpacity(0.5),
                                ],
                              ),

                            ),

                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0,bottom: 12,right: 8.0),
                              child: Text(controller.comingSoonModel!.keys.toList()[index], style: TextStyle(color: Colors.white),),
                            ),
                          ),

                          SizedBox(height: 20,),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: controller.comingSoonModel![controller.comingSoonModel!.keys.toList()[index]]!.length,
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisExtent: Get.width / 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index2) {
                              var film = controller.comingSoonModel![controller.comingSoonModel!.keys.toList()[index]]![index2];
                              return GestureDetector(
                                onTap: () async {
                                  nextScreen(context, MovieScreen(
                                    poster: film.poster!,
                                    id: film.id!,
                                  ));
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: Get.width / 2.5,
                                            height: Get.height / 1.2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              image: DecorationImage(
                                                image: CachedNetworkImageProvider(film!.poster!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: Get.width / 3.5,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${material_App().convertDate(film.releaseDate ?? '')}',
                                                  style: TextStyle(fontSize: 10, color: Colors.white,),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  // child: CustomCacheImage(
                                  //   imageUrl: film!.poster,
                                  //   radius: 4,
                                  //   comingSoon: true,
                                  //   type: 'film',
                                  //   rate: film.rating,
                                  //   releaseDate: film.releaseDate,
                                  //
                                  // )
                                ),
                              );

                            },
                          ),
                          SizedBox(height: 40,),
                        ],
                      );

                      // return Container(
                      //   width: Get.width,
                      //   height: 200,
                      //   child: Column(
                      //     children: [
                      //       Text(controller.comingSoonModel![index]!.title!),
                      //
                      //       // Text(controller.comingSoonModel![index]!),
                      //     ],
                      //   ),
                      // );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 100,),

          ],
        ),
      ),
    ));
  }
}
