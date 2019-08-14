import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restorder/models/fetch_process.dart';
import 'package:restorder/ui/widgets/common_dialogs.dart';
import 'package:restorder/utils/uidata.dart';

apiSubscription(Stream<FetchProcess> apiResult, BuildContext context) {
  apiResult.listen((FetchProcess fetchProcess) {
   
    if (fetchProcess.loadingStatus >= 1) {
      fetchProcess.loadingStatus == 1 ? showProgress(context) : hideProgress(
          context);
    }

    if (fetchProcess.statusCode == 0) {
      fetchApiResult(context, fetchProcess.networkServiceResponse);

      switch (fetchProcess.type) {
        case ApiType.performLogin:
          if (fetchProcess.statusCode == UIData.resCode200) {

          }
          else {
            toast(UIData.msgLoginError);
          }
          break;

        case ApiType.performDashboard:
          break;

        case ApiType.performCategory:
          break;

        case ApiType.performCategoryDetails:
          break;
      }
    }
  });
}