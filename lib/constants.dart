class Ministry {
  final String name;
  final String leader;
  final String description;
  final String emoji;

  const Ministry({
    required this.name,
    required this.leader,
    required this.description,
    required this.emoji,
  });
}

class AppConstants {
  static const String churchName = 'Telugu Christian Fellowship';
  static const String churchShortName = 'TCFC';
  static const String churchTagline = 'Fellowship · Ashburn VA';
  static const String churchAddress =
      '21740 Beaumeade Circle, Suite 115, Ashburn, VA 20147';
  static const String churchEmail = 'connect@tcfcva.com';
  static const String serviceTime = 'Sundays 10:30 AM – 12:00 PM';
  static const String serviceMode = 'In-Person & Online';

  static const String mapsUrl =
      'https://maps.app.goo.gl/njaPbGaphg8HB33HA';
  static const String youtubeUrl = 'https://www.youtube.com/@tcfcva';
  static const String facebookUrl = 'https://www.facebook.com/tcfchurchva';
  static const String instagramUrl = 'https://www.instagram.com/tcfcva';
  static const String vancoUrl =
      'https://secure.myvanco.com/L-ZJBH/campaign/C-14K5E';
  static const String zelleEmail = 'Treasurer@tcfcva.com';

  static const List<Ministry> ministries = [
    Ministry(
      name: 'Pastoral Ministry',
      leader: 'Rev. Rufus Bhimanapalli',
      description:
          'Biblically teaches Scripture, offers pastoral counseling, prays with members, and provides spiritual and administrative leadership.',
      emoji: '✝️',
    ),
    Ministry(
      name: "Men's Ministry",
      leader: 'Kiran Vukanti',
      description:
          'Empowering men through devotion, Spirit-led living, biblical values, spiritual growth, and discipleship in Christ Jesus.',
      emoji: '🙌',
    ),
    Ministry(
      name: "Women's Ministry",
      leader: 'Swapna Joe',
      description:
          'Uniting women to discover their identity in Christ, grow spiritually strong, and remain unwavering in God\'s promises.',
      emoji: '🌸',
    ),
    Ministry(
      name: 'Worship Ministry',
      leader: 'Christina Choppala',
      description:
          'Inspiring people of all backgrounds to worship Christ daily, joyfully, and passionately, putting God first in every area of life.',
      emoji: '🎵',
    ),
    Ministry(
      name: "Kids' Ministry",
      leader: 'Kamal Telagathoti',
      description:
          'Raising children in the fear of the Lord through biblical teaching, daily application, prayer, and Bible reading.',
      emoji: '👦',
    ),
    Ministry(
      name: 'Prayer Ministry',
      leader: 'Sohini Davuluri',
      description:
          'Fostering intercession, teaching and encouraging prayer and fasting, building prayer networks, and supporting members through prayer care.',
      emoji: '🙏',
    ),
    Ministry(
      name: 'Discipleship Ministry',
      leader: 'Yesusdas & Deepika',
      description:
          'Equipping individuals with biblical foundations and developing Christ-like ambassadors.',
      emoji: '📖',
    ),
    Ministry(
      name: 'Outreach Ministry',
      leader: 'John Stephen Meeniga',
      description:
          'Winning souls for Christ by outreach, mentoring new believers, and evangelizing through community engagement and public witness.',
      emoji: '🌍',
    ),
    Ministry(
      name: 'Ushering Ministry',
      leader: 'Vani Willson',
      description:
          'Serving God\'s commission by supporting church operations, welcoming visitors, and assisting members to foster worship.',
      emoji: '🤝',
    ),
    Ministry(
      name: 'Media Ministry',
      leader: 'Samson Rentapalli',
      description:
          'Focusing on spoken Word, prayer, and worship through engaging praise, clear audio-visuals, and sharing sermons beyond the church.',
      emoji: '📡',
    ),
  ];
}
