import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:todo_manager/data/AdsHelper/ads_helper.dart';
import 'package:todo_manager/data/remote/firebase_repo.dart';
import 'package:todo_manager/domain/models/todo_model.dart';
import 'package:todo_manager/domain/utils/app_style.dart';
import 'package:todo_manager/domain/widgets/outline_btn.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdsHelper adsHelper = AdsHelper();
  late List<TodoModel> listTodo = [];
  String selectedPriority = 'High';

  List<String> listPriority = ['High', 'Medium', 'Low'];

  var titleController = TextEditingController();
  var descController = TextEditingController();
/*
  @override
  void initState() {
    super.initState();
    adsHelper.createInterstitialAd();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(text: 'ToDo', style: mTextStyle16(), children: [
            TextSpan(
                text: '\tManager',
                style: mTextStyle16(
                  mFontWeight: FontWeight.bold,
                  mColor: Colors.blue,
                ))
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseRepo.fetchAllTodo(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              listTodo.clear();

              for (QueryDocumentSnapshot<Map<String, dynamic>> eachDoc
                  in snapshot.data!.docs) {
                listTodo.add(TodoModel.fromTodo(eachDoc.data()));
              }

              return listTodo.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: listTodo.length,
                      itemBuilder: (_, index) {
                        var myFormat = DateFormat.yMMMMEEEEd();

                        var assignDate = myFormat.format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(listTodo[index].assignedAt!)));
                        var completedDate = listTodo[index].completedAt != ''
                            ? myFormat.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(listTodo[index].completedAt!)))
                            : '';
                        return InkWell(
                          onTap: () {
                            titleController.text = listTodo[index].title!;
                            descController.text = listTodo[index].desc!;
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (_) {
                                  return buildBottomSheet(
                                      isUpdate: true, mIndex: index);
                                });
                          },
                          child: Card(
                            elevation: 4,
                            color:
                                getBackgroundColor(listTodo[index].priority!),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11)),
                            child: Column(
                              children: [
                                CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                      color: Colors.white, width: 2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11)),
                                  value: listTodo[index].isCompleted,
                                  onChanged: (value) {
                                    FirebaseRepo.markTodoStatus(
                                        listTodo[index].todoId!, value!);
                                  },
                                  secondary: IconButton(
                                      onPressed: () {
                                        FirebaseRepo.deleteToDo(
                                            listTodo[index]);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.black.withOpacity(0.4),
                                      )),
                                  title: Text(listTodo[index].title!,
                                      style: mTextStyle16(mColor: Colors.white)
                                          .copyWith(
                                              decorationColor: Colors.white,
                                              decoration: listTodo[index]
                                                      .isCompleted!
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none)),
                                  subtitle: Text(listTodo[index].desc!,
                                      style: mTextStyle12(mColor: Colors.white)
                                          .copyWith(
                                              decorationColor: Colors.white,
                                              decoration: listTodo[index]
                                                      .isCompleted!
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, bottom: 11),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              text: 'Assigned at :\t\t',
                                              style: mTextStyle12(
                                                  mColor: Colors.white,
                                                  mFontWeight: FontWeight.bold),
                                              children: [
                                            TextSpan(
                                                text: assignDate,
                                                style: mTextStyle12(
                                                    mColor: Colors.white)),
                                          ])),
                                    ],
                                  ),
                                ),
                                completedDate != ''
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16, bottom: 11),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                                text: TextSpan(
                                                    text: 'Completed at :\t\t',
                                                    style: mTextStyle12(
                                                        mColor: Colors.white,
                                                        mFontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                  TextSpan(
                                                      text: completedDate,
                                                      style: mTextStyle12(
                                                          mColor:
                                                              Colors.white)),
                                                ])),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No Todo's yet",
                              style:
                                  mTextStyle16(mColor: Colors.blue.shade400)),
                          const SizedBox(height: 4),
                          OutlineBtn(
                              onPressed: () {
/*
                                adsHelper.showInterstitialAd();
*/
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (_) {
                                      return buildBottomSheet();
                                    });
                              },
                              title: 'Add now'),
                        ],
                      ),
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        splashColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
/*
          adsHelper.showInterstitialAd();
*/
          titleController.text = '';
          titleController.text = '';
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) {
                return buildBottomSheet();
              });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: AdsHelper.getBannerAd().size.width.toDouble(),
          height: AdsHelper.getBannerAd().size.height.toDouble(),
          child: AdWidget(ad: AdsHelper.getBannerAd()..load()),
        ),
      ),
    );
  }

  Widget buildBottomSheet({
    bool isUpdate = false,
    int mIndex = -1,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5 +
          MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.only(
          bottom: 11 + MediaQuery.of(context).viewInsets.bottom,
          top: 11,
          right: 11,
          left: 11),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.blue, size: 16)),
              const SizedBox(width: 11),
              Text(isUpdate ? 'Update ToDo' : 'Add ToDo',
                  style: mTextStyle16(
                      mFontWeight: FontWeight.bold, mColor: Colors.blue)),
            ],
          ),
          const SizedBox(height: 21),
          TextField(
            style: mTextStyle16(),
            controller: titleController,
            keyboardType: TextInputType.text,
            enableSuggestions: true,
            decoration: InputDecoration(
              label: Text('Title', style: mTextStyle16()),
              hintText: 'Enter title here',
              hintStyle: mTextStyle16(mColor: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )),
            ),
          ),
          const SizedBox(height: 11),
          TextField(
            style: mTextStyle16(),
            controller: descController,
            keyboardType: TextInputType.text,
            enableSuggestions: true,
            decoration: InputDecoration(
              label: Text('Description', style: mTextStyle16()),
              hintText: 'Enter desc here',
              hintStyle: mTextStyle16(mColor: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )),
            ),
          ),
          const SizedBox(height: 11),
          DropdownMenu(
              onSelected: (value) {
                selectedPriority = value!;
              },
              textStyle: mTextStyle16(),
              width: MediaQuery.of(context).size.width - 22,
              selectedTrailingIcon: const Icon(Icons.low_priority_outlined),
              label: Text('Priority', style: mTextStyle16(mColor: Colors.blue)),
              trailingIcon:
                  const Icon(Icons.arrow_drop_down_circle, color: Colors.blue),
              dropdownMenuEntries: listPriority
                  .map((priority) => DropdownMenuEntry(
                      label: priority,
                      value: priority,
                      style: ButtonStyle(
                          textStyle: MaterialStateTextStyle.resolveWith(
                              (state) => mTextStyle12()))))
                  .toList()),
          const SizedBox(height: 21),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlineBtn(
                  onPressed: () async {
                    var todoModel = TodoModel(
                        todoId: isUpdate ? listTodo[mIndex].todoId : '',
                        title: titleController.text.toString(),
                        desc: descController.text.toString(),
                        priority: selectedPriority == 'High'
                            ? 1
                            : (selectedPriority == 'Medium' ? 2 : 3),
                        assignedAt:
                            DateTime.now().millisecondsSinceEpoch.toString());

                    if (isUpdate) {
                      FirebaseRepo.updateToDo(todoModel);
                    } else {
                      FirebaseRepo.addTodo(todoModel);
                    }

                    Navigator.pop(context);
                    titleController.clear();
                    descController.clear();
                  },
                  title: isUpdate ? 'Update' : 'Add'),
              OutlineBtn(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: 'Cancel'),
            ],
          ),
        ],
      ),
    );
  }

  Color getBackgroundColor(int priority) {
    if (priority == 3) {
      return Colors.blue.shade300;
    } else if (priority == 2) {
      return Colors.orange.shade300;
    } else {
      return Colors.red.shade300;
    }
  }
}
