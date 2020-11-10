import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:sport_news/data/network/firebase_news.dart';
import 'package:sport_news/managers/firebase_manager.dart';
import 'package:sport_news/managers/shared_preference_manager.dart';

import '../../../constants.dart';
import 'dart:developer' as developer;

part 'news_detail_event.dart';
part 'news_detail_state.dart';

class NewsDetailBloc extends Cubit<bool> {
  NewsDetailBloc() : super(true);
  FirebaseManager _firebaseManager = FirebaseManager();
  SharedPreferenceManager _sharedPreferenceManager = SharedPreferenceManager();
  BranchContentMetaData metadata;
  BranchUniversalObject buo;
  BranchLinkProperties lp;
  BranchEvent eventStandart;

  // @override
  // Stream<NewsDetailState> mapEventToState(NewsDetailEvent event) async* {
  //   switch (event) {
  //     case NewsDetailEvent.init:
  //       yield NewsDetailState();
  //       break;
  //     default:
  //       addError(Exception('unsupported event'));
  //   }
  // }

  init() {}

  void initDeepLinkData(FirebaseNews arguments) {
    metadata =
        BranchContentMetaData().addCustomMetadata('custom_string', 'abc');

    buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      title: arguments.title,
      imageUrl: arguments.images != null && arguments.images.length > 0
          ? arguments.images.first.url
          : '',
      contentDescription: parseHtmlString(arguments.text),
      contentMetadata: BranchContentMetaData()
        ..addCustomMetadata('news_id', arguments.key),
      keywords: ['Plugin', 'Branch', 'Flutter'],
      publiclyIndex: true,
      locallyIndex: true,
    );
    FlutterBranchSdk.registerView(buo: buo);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        //alias: 'flutterplugin' //define link url,
        stage: 'new share',
        campaign: arguments.channelId,
        tags: ['one', 'two', 'three']);
    lp.addControlParam('\$uri_redirect_mode', '1');

    eventStandart = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART);
  }

  void shareLink(FirebaseNews arguments) async {
    BranchResponse response = await FlutterBranchSdk.showShareSheet(
        buo: buo,
        linkProperties: lp,
        messageText: arguments.title,
        androidMessageTitle: arguments.title,
        androidSharingTitle: arguments.title);
  }
}
