//############# LOADING SHIMMER WITH DELETE BUTTON #############
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingShimmerWidget(Widget deleteTasmotaDeviceButton, String debugstr) {
  return Container(
    alignment: Alignment.center,
    width: 275,
    child: Card(
      child: Container(
        alignment: Alignment.center,
        width: 275,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Center(
                child: Shimmer.fromColors(
                  key: ValueKey('shimmer${Timestamp.now().toString()}'),
                  baseColor: Colors.white,
                  highlightColor: const Color.fromARGB(255, 21, 120, 201),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Loading...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          debugstr,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              deleteTasmotaDeviceButton
            ],
          ),
        ),
      ),
    ),
  );
}
