import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:miss_planet/util/custom_full_Image.dart';
import 'package:miss_planet/util/material.dart';
import 'package:miss_planet/util/next_screen.dart';

import 'video_player_widget.dart';

// final String demoText = "<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>" +
// //'''<iframe width="560" height="315" src="https://www.youtube.com/embed/-WRzl9L4z3g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'''+
// //'''<video controls src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"></video>''' +
// //'''<iframe src="https://player.vimeo.com/video/226053498?h=a1599a8ee9" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>''' +
// "<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>";

class HtmlBodyWidget extends StatelessWidget {
  final String content;
  final bool isVideoEnabled;
  final bool isimageEnabled;
  final bool isIframeVideoEnabled;
  final double? fontSize;
  Color? color;

   HtmlBodyWidget({
    Key? key,
    required this.content,
    required this.isVideoEnabled,
    required this.isimageEnabled,
    required this.isIframeVideoEnabled,
    this.fontSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: '''$content''',
      onLinkTap: (url, _, __) {
       openLinkWithCustomTab(context, url!);
      },
      style: {
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: fontSize == null ? FontSize(18.0) : FontSize(17.0),
          lineHeight: LineHeight(1.7),
          fontFamily: 'Hanuman',
          color: color,
          fontWeight: FontWeight.w400,
        ),
        "figure": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
        "p,h1,h2,h3,h4,h5,h6": Style(margin: Margins.all(20)),
      },
      extensions: [
        TagExtension(
            tagsToExtend: {"oembed"},
            builder: (ExtensionContext eContext) {
              final String _oembedUrl = eContext.attributes['url'].toString();
              if (_oembedUrl.contains('youtu')) {
                final String videoId = _oembedUrl.split("v=")[1]; // Extract the video ID from the URL
                final String videoUrl = "https://www.youtube.com/embed/$videoId";
                return VideoPlayerWidget(videoUrl: videoUrl, videoType: 'youtube');
              } else if (_oembedUrl.contains('vimeo')) {
                final String videoId = _oembedUrl.split("/").last; // Extract the video ID from the URL
                final String videoUrl = "https://player.vimeo.com/video/$videoId";
                return VideoPlayerWidget(videoUrl: videoUrl, videoType: 'vimeo');
              }
              return SizedBox.shrink(); // Return an empty widget if no condition is met
            }
        ),
        TagExtension(
            tagsToExtend: {"video"},
            builder: (ExtensionContext eContext) {
              final String videoSource = eContext.attributes['src'].toString();
              if (isVideoEnabled == false) return Container();
              return VideoPlayerWidget(videoUrl: videoSource, videoType: 'network');
            }),
        TagExtension(
            tagsToExtend: {"img"},
            builder: (ExtensionContext eContext) {
              String imageUrl = eContext.attributes['src'].toString();
              return InkWell(
                  onTap: () => nextScreen(context, FullScreenImage(imageUrl: imageUrl)),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>  buildLoading(),
                  ));
            }),
      ],
    );
  }
}
