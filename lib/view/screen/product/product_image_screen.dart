import 'package:flutter/material.dart';
import 'package:shopiana/helper/network_info.dart';
import 'package:shopiana/provider/product_details_provider.dart';
import 'package:shopiana/view/basewidget/custom_app_bar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class ProductImageScreen extends StatefulWidget {
  final String? title;
  final List<String?> imageList;
  ProductImageScreen({required this.title, required this.imageList});

  @override
  _ProductImageScreenState createState() => _ProductImageScreenState();
}

class _ProductImageScreenState extends State<ProductImageScreen> {
  int? pageIndex;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    pageIndex = Provider.of<ProductDetailsProvider>(context, listen: false)
        .imageSliderIndex;
    _pageController = PageController(initialPage: pageIndex!);
    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        /*  CustomAppBar(title: widget.title), */
        Expanded(
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.imageList[index]!),
                    initialScale: PhotoViewComputedScale.contained,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: index.toString()),
                  );
                },
                backgroundDecoration:
                    BoxDecoration(color: Theme.of(context).accentColor),
                itemCount: widget.imageList.length,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    ),
                  ),
                ),
                pageController: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
              ),
              pageIndex != 0
                  ? Positioned(
                      left: 5,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (pageIndex! > 0) {
                              _pageController!.animateToPage(pageIndex! - 1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          },
                          child: Icon(Icons.chevron_left_outlined, size: 40),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              pageIndex != widget.imageList.length - 1
                  ? Positioned(
                      right: 5,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (pageIndex! < widget.imageList.length) {
                              _pageController!.animateToPage(pageIndex! + 1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          },
                          child: Icon(Icons.chevron_right_outlined, size: 40),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ]),
    );
  }
}
