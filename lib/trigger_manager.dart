import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'logger.dart';

class TriggerManager {
  final AudioPlayer _triggerPlayer = AudioPlayer();
  // final File logFile;

  StreamSubscription<PlaybackEvent>? _triggerPlayerSubscription;

  TriggerManager() {
    // Any initialization logic goes here, if necessary.
    // _triggerPlayer = AudioPlayer();

    _triggerPlayerSubscription =
        _triggerPlayer.playbackEventStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        // The audio file has finished playing.
      }
    });
  }

  Future<void> sendNewAcqTrigger(File logFile) async {
    // Set the audio source for the player from the assets
    await _triggerPlayer.setAudioSource(AudioSource.asset(
        'assets/trigger_new_acquisition_block/trigger_new_acquisition_block.wav'));

    // log new acquisition trigger
    logToFile(
      DateTime.now().toString(),
      'NEW_BLOCK',
      'Playing trigger for new acquisition block',
      logFile,
    );

    // send trigger
    _triggerPlayer.play();

    print("---------- Playing trigger for new acquisition block ----------");
  }

  void dispose() {
    _triggerPlayer.dispose();
    _triggerPlayerSubscription?.cancel();
  }
}
