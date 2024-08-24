import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miss_planet/controller/artical_controller.dart';
import 'package:miss_planet/helper/custo_scaffold.dart';

class SearchScreen extends StatefulWidget {
  bool? isWatchList;
   SearchScreen({super.key, this.isWatchList});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isLoading = false;
  ArticalController articalController = Get.find<ArticalController>();
  TextEditingController searchController = TextEditingController();

  @override
  void Dispose() {
    articalController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return CustomScaffold(body: Column(
      children: [
        SizedBox(height: 0.06.sh),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: (){
                  Get.back();

                },
                child:  Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
              ),
            ),
            Text('search'.tr,style: TextStyle(fontSize: 20,color: Colors.white),),
            SizedBox(width: 20,),
          ],
        ),
        SizedBox(height: 0.04.sh),
        Container(
          width: 0.94.sw,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.2)
            ),
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.search,color: Colors.white,size: 20,),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: Colors.white),
                    onChanged: (value){
                      if(value.length > 3){
                        setState(() {
                          _isLoading = true;
                        });
                        if(widget.isWatchList == true){
                          Get.find<ArticalController>().allSearch(search: value,mostWatch: 'true').then((_){
                            setState(() {
                              _isLoading = false;
                            });
                          });
                        }else{
                          Get.find<ArticalController>().allSearch(search: value).then((_){
                            setState(() {
                              _isLoading = false;
                            });
                          });

                        }
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'search'.tr,
                        hintStyle: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
      ],
    ));
  }
}
