import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_meal/controller/detail_api_controller.dart';
import 'package:get_meal/views/full_screen_page.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key, required this.id, });
  final String id;
  // final String? title;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Timer.run(
      () async {
        await Get.find<DetailApiController>().getDetails(
          id: widget.id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Text(widget.title),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: GetBuilder<DetailApiController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : controller.error.isNotEmpty
                  ? Center(
                      child: Text(controller.error),
                    )
                  : ListView.builder(
                      itemCount: controller.detailList.length,
                      itemBuilder: (context, index) {
                        final detail = controller.detailList[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenPage(
                                      imageUrl: detail.strMealThumb,
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                detail.strMealThumb,
                              ),
                            ),
                            Text(
                              detail.strMeal,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ).paddingSymmetric(horizontal: 10, vertical: 10),
                            Text(
                              detail.strInstructions,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ).paddingSymmetric(horizontal: 10, vertical: 10)
                          ],
                        );
                      },
                    );
        },
      ),
    );
  }
}
