import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/view/categories_screen.dart';
import 'package:news_app/view/news_details_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  final NewsViewModel? newsViewModel;

  const HomeScreen({super.key, this.newsViewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcNews,
  aryNews,
  cnn,
  alJazeera,
  independent,
  reuters,
}

class _HomeScreenState extends State<HomeScreen> {
  final newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd,yyyy");
  FilterList? selectedMenu;
  String name = "al-jazeera-english";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton<FilterList>(
              onSelected: (item) {
                if (FilterList.bbcNews == item) {
                  name = "bbc-news";
                }
                if (FilterList.aryNews == item) {
                  name = "ary-news";
                }
                if (FilterList.cnn == item) {
                  name = "cnn";
                }
                if (FilterList.independent == item) {
                  name = "independent";
                }
                if (FilterList.reuters == item) {
                  name = "reuters";
                }
                if (FilterList.alJazeera == item) {
                  name = "al-jazeera-english";
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              initialValue: selectedMenu,
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                      child: Text("BBC News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.aryNews,
                      child: Text("Ary News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.cnn,
                      child: Text("CNN"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.alJazeera,
                      child: Text("AlJazeera"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.independent,
                      child: Text("Independent"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.reuters,
                      child: Text("Reuters"),
                    ),
                  ])
        ],
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
                  ));
            },
            icon: Image.asset(
              "images/category_icon.png",
              width: 30,
              height: 30,
            )),
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder(
              future: widget.newsViewModel!.fetchNewsHeadlines(name),
              //future: newsViewModel.fetchNewsHeadlines(name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitFadingCircle(
                    size: 50,
                    color: Colors.pink,
                  );
                } else {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          final dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NewsScreen(
                                    newsImage: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    newsTitle: snapshot.data!.articles![index].title
                                        .toString(),
                                    newsDate: snapshot
                                        .data!.articles![index].publishedAt
                                        .toString(),
                                    author: snapshot.data!.articles![index].author
                                        .toString(),
                                    description: snapshot
                                        .data!.articles![index].description
                                        .toString(),
                                    content: snapshot.data!.articles![index].content
                                        .toString(),
                                    source: snapshot.data!.articles![index].source!.name
                                        .toString()),
                              ));
                            },
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: height * 0.02),
                                      height: height * 0.6,
                                      width: width * 0.9,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: height * .18,
                                          width: width * .3,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: SpinKitCircle(
                                              size: 50,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        height: height * 0.22,
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: width * 0.7,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: width * 0.7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
                return Container();
              },
            ),
          ),
          //
          const SizedBox(height: 20), //
          FutureBuilder(
            future: newsViewModel.fetchCategoriesNews("General"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();

                // SpinKitFadingCircle(
                //   size: 50,
                //   color: Colors.pink,
                // );
              } else {
                return Expanded(
                  child: ListView.builder(
                    //scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.articles!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * .18,
                                width: width * .3,
                                placeholder: (context, url) => const Center(
                                  child: SpinKitCircle(
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            //
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              height: height * 0.18,
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          snapshot.data!.articles![index]
                                              .source!.name
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                        format.format(dateTime),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: const Color(0xFF000000),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
