import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../screens/player_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFFCE4EC), // Light pastel pink background
      appBar: AppBar(
        title: Text("Music Player", style: GoogleFonts.pacifico(fontSize: 26)),
        backgroundColor: Color(0xFFD4A5A5), // Pastel pink AppBar
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: musicProvider.playlist.length,
        itemBuilder: (context, index) {
          final track = musicProvider.playlist[index];
          final isPlaying = musicProvider.isPlayingTrack(index);

          return Card(
            color: isPlaying ? Color(0xFFFFF8E1) : Colors.white, // Highlight playing song
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            child: ListTile(
              title: Text(track.title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              subtitle: Text(track.artist, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
              trailing: isPlaying
                  ? Icon(Icons.play_arrow, color: Colors.green, size: 32)
                  : Icon(Icons.music_note, color: Colors.black54, size: 24),
              onTap: () {
                musicProvider.play(index: index);
                Navigator.push(context, MaterialPageRoute(builder: (_) => PlayerScreen()));
              },
            ),
          );
        },
      ),
    );
  }
}
