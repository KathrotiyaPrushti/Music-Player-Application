import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF6E6DA), // Pastel cream background
      appBar: AppBar(
        title: Text("Now Playing", style: GoogleFonts.pacifico(fontSize: 24)),
        backgroundColor: Color(0xFFD4A5A5), // Pastel pink
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(musicProvider.currentTrack.title, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(musicProvider.currentTrack.artist, style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 20),
            Slider(
              min: 0,
              max: musicProvider.duration.inSeconds.toDouble(),
              value: musicProvider.position.inSeconds.toDouble(),
              onChanged: (value) {
                musicProvider.seek(Duration(seconds: value.toInt()));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.skip_previous, size: 32), onPressed: () => musicProvider.prevTrack()),
                IconButton(icon: Icon(musicProvider.isPlaying ? Icons.pause : Icons.play_arrow, size: 40), onPressed: () {
                  musicProvider.isPlaying ? musicProvider.pause() : musicProvider.play();
                }),
                IconButton(icon: Icon(Icons.skip_next, size: 32), onPressed: () => musicProvider.nextTrack()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
