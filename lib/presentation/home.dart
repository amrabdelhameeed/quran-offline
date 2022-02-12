import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/strings.dart';
import '../data/cubit/public_cubit.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final PageController controller = PageController();
  var keyscaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PublicCubit, PublicState>(
      listener: (context, state) {
        if (state is PublicLoadedForJuz) {
          //  print(state.allSurah[8].start.index);
        }
      },
      builder: (context, state) {
        var cubit = PublicCubit.get(context);
        return SafeArea(
          child: Scaffold(
            key: keyscaffold,
            endDrawer: drawer(context, cubit, cubit.ind, controller),
            drawer: drawer(context, cubit, cubit.ind, controller),
            body: Stack(children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: PageView.builder(
                  controller: controller,
                  itemCount: list.length,
                  onPageChanged: (value) {
                    //print(value + 1);
                    // cubit.changeSurahName(value);
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //  cubit.toggleIsListShown();
                      },
                      child: Image.asset(
                        list[index],
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                  top: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      cubit.changeIndexDrawer(false);
                      keyscaffold.currentState!.openDrawer();
                    },
                    child: Text(
                      "السور",
                      style: ktextstyle,
                    ),
                  )),
              Positioned(
                  top: 1,
                  right: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      cubit.changeIndexDrawer(true);
                      keyscaffold.currentState!.openEndDrawer();
                    },
                    child: Text(
                      "الاجزاء",
                      style: ktextstyle,
                    ),
                  ))
              //  surahWidget(context, cubit, cubit.isListShowen)
            ]),
          ),
        );
      },
    );
  }
}

Widget surahWidget(BuildContext context, PublicCubit cubit, bool isListShown) {
  return Positioned(
    child: Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white.withOpacity(0.8),
      child: Text(
        cubit.surahName,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        maxLines: 1,
      ),
    ),
  );
}

Widget drawerChild(
    BuildContext context, PublicCubit cubit, int index, bool drawerIndex) {
  return !drawerIndex
      ? Container(
          height: 50,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                index != -1
                    ? Text(
                        cubit.listOfSurahDetailsForPages[index].place,
                        style: ktextstyle,
                      )
                    : Text(
                        "مكان النزول",
                        style: ktextstyle,
                      ),
                index != -1
                    ? Text(cubit.listOfSurahDetailsForPages[index].count
                        .toString())
                    : Text(
                        "عدد الايات",
                        style: ktextstyle,
                      ),
                index != -1
                    ? Text(cubit.listOfSurahDetailsForPages[index].page)
                    : Text(
                        "الصفحة",
                        style: ktextstyle,
                      ),
                index != -1
                    ? Text(
                        cubit.listOfSurahDetailsForPages[index].titleAr,
                        style: ktextstyle,
                      )
                    : Text(
                        "الاسم",
                        style: ktextstyle,
                      ),
              ],
            ),
          ),
        )
      : Container(
          height: 50,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                index != -1
                    ? Text(cubit.listOfSurahDetailsForJuz[index].index)
                    : Text(
                        "الجزء",
                        style: TextStyle(fontSize: 25),
                      ),
              ],
            ),
          ));
}

Widget drawer(BuildContext context, PublicCubit cubit, bool i,
    PageController controller) {
  return !i
      ? Drawer(
          elevation: 0.0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                drawerChild(context, cubit, -1, i),
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: !i
                      ? cubit.surahsName().length
                      : cubit.allSurahDetailsForJuz().length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        !i
                            ? {
                                controller.jumpToPage(int.parse(cubit
                                        .listOfSurahDetailsForPages[index]
                                        .page) -
                                    1),
                              }
                            : {
                                print(cubit.getSurahPageFromJuz(index + 1)),
                                controller.jumpToPage(
                                    cubit.getSurahPageFromJuz(index + 1)),
                              };
                        Navigator.pop(context);
                      },
                      child: drawerChild(context, cubit, index, i),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      : Drawer(
          elevation: 0.0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                drawerChild(context, cubit, -1, i),
                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: cubit.listOfSurahDetailsForJuz.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        !i
                            ? {
                                controller.jumpToPage(int.parse(cubit
                                        .listOfSurahDetailsForPages[index]
                                        .page) -
                                    1),
                              }
                            : {
                                controller.jumpToPage(
                                    cubit.getSurahPageFromJuz(index + 1)),
                                print(cubit.getSurahPageFromJuz(index + 1)),
                              };
                        Navigator.pop(context);
                      },
                      child: drawerChild(context, cubit, index, i),
                    );
                  },
                ),
              ],
            ),
          ),
        );
}
