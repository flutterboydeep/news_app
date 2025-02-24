import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/text_style.dart';

import '../../models/news_api_model.dart';

class ExpandedNews extends StatelessWidget {
  ArticleModel? newsData;
  String? newsType;

  ExpandedNews({required this.newsData, this.newsType});

  MediaQueryData? mqData;

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_outlined)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Breaking News !",
                    style: MTextStyle.mStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    newsData!.publishedAt!,
                    style:
                        MTextStyle.mStyle(fontColor: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  newsData!.title!,
                  style: MTextStyle.mStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              newsData!.description != null
                  ? Text(
                      newsData!.description!,
                      style: MTextStyle.mStyle(
                        fontSize: 15,
                      ),
                    )
                  : Text("No description yet..."),
              newsData!.urlToImage != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            newsData!.urlToImage!,
                            fit: BoxFit.cover,
                          )),
                    )
                  : Text("No Image loaded..."),
              Text(
                '-- ${newsData!.source!.name!}',
                style: MTextStyle.mStyle(
                    fontColor: Colors.grey.shade600,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              newsData!.content != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        newsData!.content!,
                        style: MTextStyle.mStyle(
                            fontSize: 15, fontColor: Colors.grey.shade700),
                      ),
                    )
                  : Center(child: Text("No Content yet!!!"))
            ],
          ),
        ),
      ),
    );
  }
}
