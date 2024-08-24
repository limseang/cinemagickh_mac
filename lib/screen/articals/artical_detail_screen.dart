import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:miss_planet/controller/artical_controller.dart';
import 'package:miss_planet/controller/auth_controller.dart';
import 'package:miss_planet/helper/custo_scaffold.dart';
import 'package:miss_planet/screen/auth/login_screen.dart';
import 'package:miss_planet/util/alert_dialog.dart';
import 'package:miss_planet/util/app_constants.dart';
import 'package:miss_planet/util/custom_HTML.dart';
import 'package:miss_planet/util/expandable.dart';
import 'package:miss_planet/util/material.dart';
import 'package:miss_planet/util/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/next_screen.dart';

class ArticalDetail extends StatefulWidget {
  const ArticalDetail({super.key});

  @override
  State<ArticalDetail> createState() => _ArticalDetailState();
}

class _ArticalDetailState extends State<ArticalDetail> {
  ArticalController articalController = Get.find<ArticalController>();
  final TextEditingController _commentController = TextEditingController();
  bool _shareLoading = false;
  final _controller = ScrollController();
  final expandedHeight = 240.0;
  bool isClick = true;
  bool _isLoading = false;
  String? _linkMessage;
  bool _isCreatingLink = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GetBuilder<ArticalController>(
        builder: (articalController) {
          return ExpandableBottomSheet(
            background: CustomScrollView(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: expandedHeight,
                  collapsedHeight: Get.height * 0.6,
                  stretch: true,
                  flexibleSpace: ClipRRect(
                    borderRadius: const BorderRadius.only(),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: Image.network(
                            '${articalController.articalDetailModel['image']}',
                            fit: BoxFit.cover,
                          ),
                          expandedTitleScale: 1,
                          titlePadding: const EdgeInsets.all(24),
                        ),
                        Container(
                          height: 80,
                          color: Colors.black.withOpacity(0.8),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '${articalController.articalDetailModel['title']}',
                                style: const TextStyle(
                                  fontFamily: "Bayon",
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            _buildInfoCard(articalController),
                            const SizedBox(height: 10),
                            _buildActionButtons(articalController),
                            const SizedBox(height: 20),
                            _buildArticleContent(articalController),
                            const SizedBox(height: 20),
                            _buildCommentSection(articalController),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            persistentContentHeight: 204,
            expandableContent: const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(ArticalController articalController) {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20),
              _customField(
                name: '${articalController.articalDetailModel['type'] ?? ''}',
                lottie: 'assets/animations/artical/wired-lineal-411-news-newspaper.json',
              ),

              _customField(
                name: '${articalController.articalDetailModel['origin'] ?? ''}',
                lottie: 'assets/animations/artical/wired-lineal-766-inkwell-feather.json',
                onTap: () async {
                  await _launchUrl(articalController);
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ArticalController articalController) {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLikeButton(articalController),
              _buildNotificationButton(articalController),
              _buildShareButton(articalController),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildLikeButton(ArticalController articalController) {
    return GestureDetector(
      onTap: () {
        setState(() {
          articalController.likeArticle(
            id: articalController.articalDetailModel['id'],
          );
        });
      },
      child: Row(
        children: [
          FaIcon(
            FontAwesomeIcons.solidHeart,
            color: articalController.isLike ? Colors.pink : Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            '${articalController.articalDetailModel['like']}',
            style: const TextStyle(
              fontFamily: "Bayon",
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationButton(ArticalController articalController) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (articalController.isNotify) {
            articalController.deleteNotify(
              postID: articalController.articalDetailModel['id'],
              postType: 1,
            );
          } else {
            articalController.makeNotify(
              postID: articalController.articalDetailModel['id'],
              postType: 1,
            );
          }
        });
      },
      child: Row(

        children: [
          FaIcon(
            FontAwesomeIcons.solidBell,
            color: articalController.isNotify ? Colors.pink : Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            articalController.isNotify ? 'Notify' : 'Notification',
            style: const TextStyle(
              fontFamily: "Bayon",
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(ArticalController articalController) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _shareLoading = true;
        });

        await Share.share('${_linkMessage}');
        setState(() {
          _shareLoading = false;
        });
      },
      child: _shareLoading
          ? CircularProgressIndicator()
          : Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.solidShareFromSquare,
            color: Colors.white,
            size: 26,
          ),
          const SizedBox(width: 10),
          const Text(
            'Share',
            style: TextStyle(
              fontFamily: "Bayon",
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleContent(ArticalController articalController) {
    return SingleChildScrollView(
      child: Container(
        width: Get.width * 0.96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: HtmlBodyWidget(
            content: '${articalController.articalDetailModel['description']}',
            color: Colors.white.withOpacity(0.8),
            isIframeVideoEnabled: false,
            isVideoEnabled: false,
            isimageEnabled: true,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildCommentSection(ArticalController articalController) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'បញ្ចេញមតិ',
            style: TextStyle(
              fontFamily: "Bayon",
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildCommentInput(articalController),
        const SizedBox(height: 20),
        Container(
          height: 1,
          width: Get.width * 0.95,
          color: Colors.grey.withOpacity(0.2),
        ),
        if (articalController.isLoding)
          Container(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        _buildCommentsList(articalController),
      ],
    );
  }

  Widget _buildCommentInput(ArticalController articalController) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      width: Get.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _commentController,
              maxLines: 3,
              style: const TextStyle(
                fontFamily: "Hanuman",
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: const InputDecoration(

                contentPadding: EdgeInsets.only(top: 20),
                hintText: 'បញ្ចូលមតិរបស់អ្នក',
                hintStyle: TextStyle(
                  fontFamily: "Hanuman",
                  color: Colors.grey,
                  fontSize: 18,
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(width: 10),
          if (_commentController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () async {
                  if (Get.find<AuthController>().isNotLogin) {
                    showCustomDialog(
                      '${AppConstants().notLogin}',
                      Get.context!,
                      isError: true,
                      onPressed: () {
                        nextScreenReplace(Get.context!, LoginScreen());
                      },
                      hasOnpressed: true,
                    );
                  } else {
                    // await CustomCmtDialog.showCustomCupertinoActionSheet(
                    //   context,
                    //   userAvatar: Get.find<AuthController>().userModel!.data!.avatar.toString(),
                    //   userName: Get.find<AuthController>().userModel!.data!.name.toString(),
                    //   content: _commentController.text,
                    //   id: articalController.articalDetailModel['id'],
                    //   type: 1,
                    // );
                    _commentController.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCommentsList(ArticalController articalController) {
    return ListView.builder(
      itemCount: articalController.articalDetailModel['comment'].length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var comment = articalController.articalDetailModel['comment'][index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: Get.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Container(
                        width: 50,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage('${comment?['avatar'] ?? 'https://cinemagickh.oss-ap-southeast-7.aliyuncs.com/uploads/2023/05/31/220e277427af033f682f8709e54711ab.webp'}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${comment?['user']}'.capitalizeFirst.toString(),
                            style: const TextStyle(
                              fontFamily: "Cabin",
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${material_App().convertTimestampToDate('${comment?['created_at']}')}",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: Get.width * 0.7,
                            child: Text(
                              "${comment?['content']}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (comment['user_id'] == Get.find<AuthController>().userModel?.data?.id.toString() ||
                          Get.find<AuthController>().userModel?.data?.roleId == 1 ||
                          Get.find<AuthController>().userModel?.data?.roleId == 2)
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await articalController.deleteComment(
                              id: comment['id'],
                              type: 1,
                            );
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Icon(
                            Icons.delete,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(ArticalController articalController) async {
    String fbProtocolUrl;
    String pageId = articalController.articalDetailModel['originPageId'];
    fbProtocolUrl = "fb://profile/$pageId";
    String fallbackUrl = '${articalController.articalDetailModel['originLink']}';
    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  Widget _customField({required String name, required String lottie, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            child: Lottie.asset(
              lottie,
              reverse: false,
              repeat: false,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            name.capitalizeFirst.toString(),
            style: const TextStyle(
              fontFamily: "Bayon",
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
