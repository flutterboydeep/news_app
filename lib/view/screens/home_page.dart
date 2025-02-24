import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/bloc_events.dart';
import 'package:news_app/core/text_style.dart';
import 'package:news_app/view/screens/expanded_page.dart';

import '../../bloc/bloc_news.dart';
import '../../bloc/bloc_state.dart';

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

  @override
  void initState() {
    context.read<BlocNews>().add(GetNewsBlocEvent(keywordTitle: search));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    if (onChange) {
      context.read<BlocNews>().add(GetNewsBlocEvent(keywordTitle: search));
    }
    return Scaffold(
      appBar: AppBar(
        title: TextField(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<BlocNews, BlocState>(builder: (_, state) {
              if (state is BlocLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BlocErrorState) {
                return Text(state.errorMsg!);
              } else if (state is BlocLoadedState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height:
                          mqData!.size.height < 450 ? 500 : mqData!.size.height,
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
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    state.newsHeadingData!.articles!.length,
                                itemBuilder: (_, index) {
                                  var data = state.newsHeadingData!.articles;
                                  log("The value of height is ${mqData!.size.height}");
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: 15, top: 10, bottom: 10),
                                    child: InkWell(
                                      onTap: () {
                                        print(data[index].content!);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ExpandedNews(
                                            newsData: state.newsHeadingData!
                                                .articles![index],
                                          );
                                        }));
                                      },
                                      child: Container(
                                        height: mqData!.size.height > 500
                                            ? mqData!.size.height * 0.2
                                            : 400,
                                        width: mqData!.size.width * 0.8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: data![index].urlToImage != null
                                            ? Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.network(
                                                          state
                                                              .newsEverythingData!
                                                              .articles![index]
                                                              .urlToImage!,
                                                          fit: BoxFit.cover,
                                                        )
                                                        //     CachedNetworkImage(
                                                        //   imageUrl: data[index]
                                                        //       .urlToImage!,
                                                        //   fit: BoxFit.cover,
                                                        //   placeholder:
                                                        //       (context, url) =>
                                                        //           Center(
                                                        //     child:
                                                        //         CircularProgressIndicator(),
                                                        //   ),
                                                        //   errorWidget: (context,
                                                        //           url, error) =>
                                                        //       Center(
                                                        //     child: Icon(
                                                        //         Icons.error),
                                                        //   ),
                                                        // )

                                                        // Image.network(
                                                        //   data[index]
                                                        //       .urlToImage!,
                                                        //   fit: BoxFit.cover,
                                                        // )
                                                        ),
                                                  ),
                                                  Positioned(
                                                      bottom: 10,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            20,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color:
                                                                Color.fromARGB(
                                                                    156,
                                                                    0,
                                                                    0,
                                                                    0),
                                                          ),
                                                          child: Text(
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            data[index].title!,
                                                            style: MTextStyle.mStyle(
                                                                fontColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              )
                                            : Center(
                                                child:
                                                    Text("No Image loaded...")),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              shadowColor: Colors.blue,
                                              // overlayColor: Colors.blue,
                                            ),
                                            onPressed: () {
                                              context.read<BlocNews>().add(
                                                  GetNewsBlocEvent(
                                                      keywordTitle:
                                                          trendingNews[index]));
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
                                itemCount:
                                    state.newsEverythingData!.articles!.length,
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ExpandedNews(
                                            newsData: state.newsEverythingData!
                                                .articles![index]);
                                      }));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 6),
                                      height: mqData!.size.height > 500
                                          ? mqData!.size.height * 0.14
                                          : 200,
                                      width: mqData!.size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: mqData!.size.width * 0.4,
                                            height: mqData!.size.height > 500
                                                ? mqData!.size.height * 0.14
                                                : 200,
                                            child: state
                                                        .newsEverythingData!
                                                        .articles![index]
                                                        .urlToImage !=
                                                    null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      state
                                                          .newsEverythingData!
                                                          .articles![index]
                                                          .urlToImage!,
                                                      fit: BoxFit.cover,
                                                    )
                                                    // child: CachedNetworkImage(
                                                    //   imageUrl: state
                                                    //       .newsEverythingData!
                                                    //       .articles![index]
                                                    //       .urlToImage!,
                                                    //   fit: BoxFit.cover,
                                                    //   placeholder:
                                                    //       (context, url) =>
                                                    //           Center(
                                                    //     child:
                                                    //         CircularProgressIndicator(),
                                                    //   ),
                                                    //   errorWidget: (context,
                                                    //           url, error) =>
                                                    //       Center(
                                                    //     child:
                                                    //         Icon(Icons.error),
                                                    //   ),
                                                    // ))
                                                    )
                                                : Center(
                                                    child: Text(
                                                        "No Image loaded!!")),
                                          ),
                                          SizedBox(
                                            width: mqData!.size.width * 0.5,
                                            height: mqData!.size.height > 500
                                                ? mqData!.size.height * 0.1
                                                : 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    state
                                                        .newsEverythingData!
                                                        .articles![index]
                                                        .title!,
                                                    softWrap: true,
                                                    style: MTextStyle.mStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            13), // Optional as this is true by default
                                                  ),
                                                ),
                                                Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  state
                                                      .newsEverythingData!
                                                      .articles![index]
                                                      .source!
                                                      .name!,
                                                ),
                                                state
                                                            .newsEverythingData!
                                                            .articles![index]
                                                            .author !=
                                                        null
                                                    ? Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        'Author: ${state.newsEverythingData!.articles![index].author}')
                                                    : Text(
                                                        "No Author name founded..")
                                              ],
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
                );
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
