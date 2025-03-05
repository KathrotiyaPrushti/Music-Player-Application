import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/track.dart';

class MusicProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  final List<Track> _playlist = [
    Track(title: "A Product Demo", artist: "HitsLab", assetPath: "songs/a-product-demo-167264.mp3"),
    Track(title: "Business", artist: "MomotMusic", assetPath: "songs/business-168341.mp3"),
    Track(title: "Corporate Innovation", artist: "TWISTERION", assetPath: "songs/corporate-innovation-230791.mp3"),
    Track(title: "Product Launch 1", artist: "HitsLab", assetPath: "songs/product-launch-advertising-commercial-music-301409.mp3"),
    Track(title: "Product Launch 2", artist: "TWISTERION", assetPath: "songs/product-launch-advertising-commercial-music-306038.mp3"),
    Track(title: "Promo Music", artist: "MomotMusic", assetPath: "songs/promo-music-showreel-trailer-demo-ads-background-intro-theme-270169.mp3"),
    Track(title: "Showreel Music", artist: "TWISTERION", assetPath: "songs/showreel-music-opener-demo-promo-background-intro-theme-254137.mp3"),
    Track(title: "Twisterion B1", artist: "MomotMusic", assetPath: "songs/twisterion-b1-221376.mp3"),
    Track(title: "Upbeat Motivational", artist: "HitsLab", assetPath: "songs/upbeat-motivational-172092.mp3"),
    Track(title: "Uplifting Motivational", artist: "TWISTERION", assetPath: "songs/uplifting-motivational-228929.mp3"),
  ];

  List<Track> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  Duration get position => _position;
  Track get currentTrack => _playlist[_currentIndex];

  MusicProvider() {
    _audioPlayer.onDurationChanged.listen((d) {
      _duration = d;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((p) {
      _position = p;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((_) => nextTrack());
  }

  Future<void> play({int? index}) async {
    if (index != null) _currentIndex = index;
    await _audioPlayer.setSource(AssetSource(_playlist[_currentIndex].assetPath));
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> nextTrack() async {
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    await play();
  }

  Future<void> prevTrack() async {
    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await play();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  bool isPlayingTrack(int index) {
    return _isPlaying && _currentIndex == index;
  }
}
