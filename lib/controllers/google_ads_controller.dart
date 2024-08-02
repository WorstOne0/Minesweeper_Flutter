// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// Services
import '/services/storage/secure_storage.dart';

@immutable
class GoogleAdsState {
  const GoogleAdsState({required this.adUnitId, required this.interstitialAd});

  final String adUnitId;
  final InterstitialAd? interstitialAd;

  GoogleAdsState copyWith({String? adUnitId, InterstitialAd? interstitialAd}) {
    return GoogleAdsState(
      adUnitId: adUnitId ?? this.adUnitId,
      interstitialAd: interstitialAd ?? this.interstitialAd,
    );
  }
}

class GoogleAdsController extends StateNotifier<GoogleAdsState> {
  GoogleAdsController({required this.ref, required this.storage})
      : super(
          GoogleAdsState(
            // ca-app-pub-3940256099942544/1033173712
            adUnitId: FlutterConfig.get('AD_UNIT_ID'),
            interstitialAd: null,
          ),
        );

  Ref ref;
  SecureStorage storage;

  Future<void> loadAd() async {
    await InterstitialAd.load(
      adUnitId: state.adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');

          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {},
          );

          // Keep a reference to the ad so you can show it later.
          state = state.copyWith(interstitialAd: ad);
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  Future<void> showAd() async {
    await loadAd();
    if (state.interstitialAd != null) await state.interstitialAd!.show();
  }
}

final googleAdsProvider = StateNotifierProvider<GoogleAdsController, GoogleAdsState>((ref) {
  return GoogleAdsController(
    ref: ref,
    storage: ref.watch(secureStorageProvider),
  );
});
