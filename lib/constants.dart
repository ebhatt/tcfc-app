class Ministry {
  final String name;
  final String leader;
  final String description;
  final String emoji;
  final String email;
  final String imageUrl;

  const Ministry({
    required this.name,
    required this.leader,
    required this.description,
    required this.emoji,
    required this.email,
    required this.imageUrl,
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
          'A faithful shepherd who biblically teaches Scripture, offers pastoral counseling, prays with members, and provides spiritual and administrative leadership.',
      emoji: '✝️',
      email: 'pastor@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=619,fit=crop/q6jiTAAAMD2PFku5/dsc09802-Cignaa9EAUBq5p2k.jpeg',
    ),
    Ministry(
      name: "Men's Ministry",
      leader: 'Kiran Vukanti',
      description:
          'As men, we empower one another through devotion, Spirit-led living, biblical values, spiritual growth, and discipleship in Christ Jesus.',
      emoji: '🙌',
      email: 'mensministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=619,fit=crop/q6jiTAAAMD2PFku5/dsc09794-5vnBTLctcrGIiKG4.jpeg',
    ),
    Ministry(
      name: "Women's Ministry",
      leader: 'Swapna Joe',
      description:
          'Like pearls woven together, we unite women to discover their identity in Christ, grow spiritually strong, and remain unwavering in God\'s promises.',
      emoji: '🌸',
      email: 'womensministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=619,fit=crop/q6jiTAAAMD2PFku5/dsc09903-VO25jVehYDsVSbZB.jpeg',
    ),
    Ministry(
      name: 'Worship Ministry',
      leader: 'Christina Choppala',
      description:
          'To inspire people of all backgrounds to worship Christ daily, joyfully, and passionately, putting God first in every area of life.',
      emoji: '🎵',
      email: 'worship@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=619,fit=crop/q6jiTAAAMD2PFku5/dsc09935-yvYJQnJsGRzNcimu.jpeg',
    ),
    Ministry(
      name: "Kids' Ministry",
      leader: 'Samson Rentapalli',
      description:
          'To raise children in the fear of the Lord through biblical teaching, daily application, prayer, Bible reading, and using their God-given talents.',
      emoji: '👦',
      email: 'kidsministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=705,fit=crop/q6jiTAAAMD2PFku5/dsc09896-TvKHiGD0aWlvEpJW.jpeg',
    ),
    Ministry(
      name: 'Prayer Ministry',
      leader: 'Vani Willson',
      description:
          'Prayer is our faith\'s foundation. We foster intercession, teach and encourage prayer and fasting, build prayer networks, and support members through prayer care.',
      emoji: '🙏',
      email: 'prayerministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=705,fit=crop/q6jiTAAAMD2PFku5/dsc09910-8YMEH1dL787sgS9e.jpeg',
    ),
    Ministry(
      name: 'Ushering Ministry',
      leader: 'John Stephen Meeniga',
      description:
          'To serve God\'s commission by supporting church operations, welcoming visitors, assisting members, and partnering with ministries to foster worship.',
      emoji: '🤝',
      email: 'usheringministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=705,fit=crop/q6jiTAAAMD2PFku5/dsc09851-FKz8NkCPG2YLL3c9.jpeg',
    ),
    Ministry(
      name: 'Outreach Ministry',
      leader: 'Yesusdas & Deepika',
      description:
          'To win souls for Christ by outreach, mentoring new believers, and evangelizing through community engagement and public witness.',
      emoji: '🌍',
      email: 'outreach@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=705,fit=crop/q6jiTAAAMD2PFku5/dsc09831-5lMMEtQfQFaEPtPb.jpeg',
    ),
    Ministry(
      name: 'Media Ministry',
      leader: 'Sohini Davuluri',
      description:
          'Faith comes by hearing. We focus on spoken Word, prayer, and worship through engaging praise, clear audio-visuals, and sharing sermons beyond the church.',
      emoji: '📡',
      email: 'media@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=705,fit=crop/q6jiTAAAMD2PFku5/dsc09853-gUc8QgGoXe844HS3.jpeg',
    ),
    Ministry(
      name: 'Discipleship Ministry',
      leader: 'TCFC Leadership',
      description:
          'To equip individuals with a strong biblical foundation, grow closer to God, live like Christ, and become ambassadors drawing others to salvation.',
      emoji: '📖',
      email: 'discipleship@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768,h=705,fit=crop/q6jiTAAAMD2PFku5/dsc09842-iFk3UmWZhlgb2gVV.jpeg',
    ),
  ];
}
