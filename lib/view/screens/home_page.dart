import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:news_app/core/shemmer.dart';
import 'package:news_app/core/text_style.dart';
import 'package:news_app/view/screens/expanded_page.dart';
import 'package:news_app/view_model/controller/news_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MediaQueryData? mqData;
  String search = "Politic";
  List<String> trendingNews = [
    "All",
    "Politic",
    "Nature",
    "Education",
    "Sports",
    "Food",
    "Electric"
  ];
  bool seeAllHeadline = false;
  bool onChange = false;
  int trendingIndex = 0;

  @override
  void initState() {
    // context.read<BlocNews>().add(GetNewsBlocEvent(keywordTitle: search));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController queryCtrl = TextEditingController();
    final NewsController newsController = Get.put(NewsController());
    ScrollController _scrollController = ScrollController();

    mqData = MediaQuery.of(context);
    if (onChange) {
      newsController.fetchData(query: queryCtrl.text.trim());
      // context.read<BlocNews>().add(GetNewsBlocEvent(keywordTitle: search));
    }
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 45,
          child: TextField(
            onChanged: (value) {
              setState(() {
                if (search == "") {
                  search = "food";
                }
                onChange = true;
                search = value;
                setState(() {});
              });
            },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Let's see what happened today....",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
          ),
        ),
      ),
      body: Obx(() {
        if (newsController.isLoading.value) {
          return LoadingEffect();
        }
        var everythingNews = newsController.newsEverythingData.value;
        var headingNews = newsController.newsHeadingData.value;

        if (everythingNews == null || headingNews == null) {
          return Center(child: Text("No News Data Available"));
        }

        return SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: mqData!.size.height < 450 ? 500 : mqData!.size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mqData!.size.height * 0.06,
                      child: Text("Breaking News !",
                          style: MTextStyle.mStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontColor: Colors.black)),
                    ),
                    SizedBox(
                      height: mqData!.size.height > 500
                          ? mqData!.size.height * 0.3
                          : 200,
                      child: ListView.builder(
                          controller: _scrollController,
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: headingNews.articles!.length,
                          itemBuilder: (_, index) {
                            var data = headingNews.articles;
                            log("The value of height is ${mqData!.size.height}");
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: 15, top: 10, bottom: 10),
                              child: InkWell(
                                onTap: () {
                                  print(data[index].content!);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ExpandedNews(
                                      newsData: headingNews.articles![index],
                                    );
                                  }));
                                },
                                child: Container(
                                  height: mqData!.size.height > 600
                                      ? mqData!.size.height * 0.3
                                      : mqData!.size.height > 800
                                          ? mqData!.size.height * 0.5
                                          : mqData!.size.height * 0.2,
                                  width: mqData!.size.width < 600
                                      ? mqData!.size.width * 0.5
                                      : mqData!.size.width > 900
                                          ? mqData!.size.width * 0.3
                                          : mqData!.size.width * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: data![index].urlToImage != null &&
                                          data[index].urlToImage!.isNotEmpty
                                      ? Stack(
                                          children: [
                                            Positioned.fill(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: everythingNews
                                                                .articles![
                                                                    index]
                                                                .urlToImage !=
                                                            null &&
                                                        everythingNews
                                                            .articles![index]
                                                            .urlToImage!
                                                            .isNotEmpty
                                                    ? CachedNetworkImage(
                                                        imageUrl: data[index]
                                                            .urlToImage!,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) =>
                                                                Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Center(
                                                          child:
                                                              Icon(Icons.error),
                                                        ),
                                                      )

                                                    // Image.network(
                                                    //   data[index]
                                                    //       .urlToImage!,
                                                    //   fit: BoxFit.cover,
                                                    // )

                                                    //  Image.network(
                                                    //     everythingNews
                                                    //         .articles![index]
                                                    //         .urlToImage!,
                                                    //     fit: BoxFit.cover,
                                                    //     errorBuilder: (context,
                                                    //             error,
                                                    //             stackTrace) =>
                                                    //         Center(
                                                    //       child: Icon(
                                                    //           Icons
                                                    //               .broken_image,
                                                    //           color:
                                                    //               Colors.grey),
                                                    //     ),
                                                    //   )
                                                    : Center(
                                                        child: Icon(
                                                            Icons
                                                                .image_not_supported,
                                                            color: Colors.grey),
                                                      ),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 10,
                                                child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20,
                                                  child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Color.fromARGB(
                                                          156, 0, 0, 0),
                                                    ),
                                                    child: Text(
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      data[index].title!,
                                                      style: MTextStyle.mStyle(
                                                          fontColor:
                                                              Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        )
                                      : Center(
                                          child: Text("No Image loaded...")),
                                ),
                              ),
                            );
                          }),
                    ),
                    /*----Trending right now------*/
                    SizedBox(
                        height: mqData!.size.height > 500
                            ? mqData!.size.height * 0.05
                            : 20,
                        child: Text("Trending Right Now",
                            style: MTextStyle.mStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontColor: Colors.black))),
                    /*----Category Name ------*/
                    SizedBox(
                      height: mqData!.size.height > 500
                          ? mqData!.size.height * 0.06
                          : 100,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: trendingNews.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: trendingIndex == index
                                            ? Color.fromARGB(255, 169, 216, 255)
                                            : Colors.white,
                                        shadowColor: Colors.blue,
                                        // overlayColor: Colors.blue,
                                      ),
                                      onPressed: () {
                                        newsController.fetchData(
                                            query: trendingNews[index]);
                                        setState(() {
                                          trendingIndex = index;
                                        });
                                        // context.read<BlocNews>().add(
                                        //     GetNewsBlocEvent(
                                        //         keywordTitle:
                                        //             trendingNews[index]));
                                      },
                                      child: Text(
                                        trendingNews[index],
                                        style: MTextStyle.mStyle(
                                            fontColor: Colors.black),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    /*----Trending right now List ------*/
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: everythingNews!.articles!.length,
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ExpandedNews(
                                      newsData:
                                          everythingNews!.articles![index]);
                                }));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 6),
                                height: mqData!.size.width > 600
                                    ? mqData!.size.height * 0.35
                                    : 200,
                                width: mqData!.size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      // height: mqData!.size.height > 600
                                      //     ? mqData!.size.height * 0.3
                                      //     : mqData!.size.height > 800
                                      //         ? mqData!.size.height * 0.5
                                      //         : mqData!.size.height * 0.2,
                                      // width: mqData!.size.width < 600
                                      //     ? mqData!.size.width * 0.5
                                      //     : mqData!.size.width < 800
                                      //         ? mqData!.size.width * 0.275
                                      //         : mqData!.size.width * 0.5,
                                      width: mqData!.size.width * 0.4,
                                      height: mqData!.size.height > 600
                                          ? mqData!.size.height * 0.35
                                          : 150,
                                      child: everythingNews!.articles![index]
                                                  .urlToImage !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child:
                                                  //  Image.network(
                                                  //   everythingNews.articles![index]
                                                  //       .urlToImage!,
                                                  //   fit: BoxFit.cover,
                                                  // )
                                                  CachedNetworkImage(
                                                imageUrl: everythingNews
                                                    .articles![index]
                                                    .urlToImage!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Center(
                                                  child: Icon(Icons.error),
                                                ),
                                              ))
                                          : Center(
                                              child: Text("No Image loaded!!")),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: mqData!.size.height > 600
                                            ? mqData!.size.height * 0.3
                                            : mqData!.size.height > 800
                                                ? mqData!.size.height * 0.5
                                                : mqData!.size.height * 0.115,
                                        width: mqData!.size.width < 600
                                            ? mqData!.size.width * 0.5
                                            : mqData!.size.width < 800
                                                ? mqData!.size.width * 0.275
                                                : mqData!.size.width * 0.5,
                                        // width: mqData!.size.width * 0.5,
                                        // height: mqData!.size.height > 500
                                        //     ? mqData!.size.height * 0.1
                                        //     : 200,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,

                                                everythingNews
                                                    .articles![index].title!,
                                                softWrap: true,
                                                style: MTextStyle.mStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        13), // Optional as this is true by default
                                              ),
                                            ),
                                            Text(
                                              overflow: TextOverflow.ellipsis,
                                              everythingNews.articles![index]
                                                  .source!.name!,
                                            ),
                                            everythingNews.articles![index]
                                                        .author !=
                                                    null
                                                ? Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    'Author: ${everythingNews.articles![index].author}')
                                                : Text(
                                                    "No Author name founded..")
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));
      }),
    );
  }
}
