import 'package:ancientmysticmusic/apis/api.dart';
import 'package:ancientmysticmusic/model/artistListModel.dart';
import 'package:ancientmysticmusic/provider/mainprovider.dart';
import 'package:ancientmysticmusic/utils/colors.dart';
import 'package:ancientmysticmusic/utils/image_file.dart';
import 'package:ancientmysticmusic/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PopularartistUI extends StatefulWidget {
  final MainController? con;
  final List<ArtistData>? artistdata;
  const PopularartistUI({Key? key, this.artistdata, this.con})
      : super(key: key);

  @override
  State<PopularartistUI> createState() => _PopularartistUIState();
}

class _PopularartistUIState extends State<PopularartistUI> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.artistdata!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: Style_File.edgeInsetsGeometry,
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                      height: 12.h,
                      width: 12.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Colors.white54, width: 5),
                        borderRadius: BorderRadius.circular(1.h),
                        image: DecorationImage(
                            image: NetworkImage(APIURL.imageurl +
                                widget.artistdata![index].image!),
                            fit: BoxFit.fill),
                      )),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  SizedBox(
                    width: 15.h,
                    child: Padding(
                      padding: Style_File.edgeInsetsGeometrysubtitle
                          .copyWith(right: .5.w),
                      child: Text(
                        widget.artistdata![index].artistname!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Style_File.subtitle,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.play_arrow_outlined,
                            size: 2.0.h,
                            color: colorPrimary,
                          ),
                        ),
                        TextSpan(
                          text: " 1.7k",
                          style: Style_File.subtitle
                              .copyWith(color: colorlightGrey),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
