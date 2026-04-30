class ScheduleItem {
  final String name;
  final String timing;
  final String emoji;
  const ScheduleItem(
      {required this.name, required this.timing, required this.emoji});
}

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
  static const String churchFullName =
      'Telugu Christian Fellowship Church VA';
  static const String churchShortName = 'TCFC';
  static const String churchTagline = 'Fellowship · Ashburn VA';
  static const String churchAddress =
      '21740 Beaumeade Circle, Suite 115, Ashburn, VA 20147';
  static const String churchEmail = 'connect@tcfcva.com';
  static const String churchPhone = '+1 (301) 237-0656';
  static const String churchPhoneUrl = 'tel:+13012370656';
  static const String websiteUrl = 'https://www.tcfcva.com';
  static const String serviceTime = 'Sundays 10:30 AM – 12:00 PM';
  static const String serviceMode = 'In-Person & Online';

  // 2026 Year Promise — update this at the start of each year
  static const String promiseYear = '2026 Promise';
  static const String promiseTheme = 'The Year of Healing and Restoration';
  static const String promiseText =
      '"If my people who are called by my name humble themselves, and pray '
      'and seek my face and turn from their wicked ways, then I will hear '
      'from heaven and will forgive their sin and heal their land."';
  static const String promiseVerse = '2 Chronicles 7:14';

  static const String mapsUrl =
      'https://maps.app.goo.gl/njaPbGaphg8HB33HA';
  static const String youtubeUrl = 'https://www.youtube.com/@tcfcva';
  static const String facebookUrl = 'https://www.facebook.com/tcfchurchva';
  static const String instagramUrl = 'https://www.instagram.com/tcfcva';
  static const String vancoUrl =
      'https://secure.myvanco.com/L-ZJBH/campaign/C-14K5E';
  static const String zelleEmail = 'Treasurer@tcfcva.com';

  static const List<ScheduleItem> schedule = [
    ScheduleItem(
        name: 'Intercessory Prayers',
        timing: 'Daily · 5:30 AM',
        emoji: '🙏'),
    ScheduleItem(
        name: "Men's Meeting",
        timing: '2nd Friday · 7:30 PM',
        emoji: '👨'),
    ScheduleItem(
        name: 'All Night Prayer',
        timing: '3rd Friday · 9:00 PM',
        emoji: '✨'),
    ScheduleItem(
        name: "Women's Meeting",
        timing: '4th Friday · 7:30 PM',
        emoji: '👩'),
    ScheduleItem(
        name: 'WBTC Prayer Call',
        timing: 'Every Friday · 12:00 PM',
        emoji: '📞'),
    ScheduleItem(
        name: "Women's Prayer Meet",
        timing: 'Every Wednesday · 7:00 PM',
        emoji: '🙌'),
    ScheduleItem(
        name: 'Sunday School',
        timing: 'Every Sunday · 11:00 AM',
        emoji: '📖'),
  ];

  static const List<Ministry> ministries = [
    Ministry(
      name: 'Church Pastor',
      leader: 'Rev. Rufus Bhimanapalli',
      description:
          'A faithful shepherd who biblically teaches Scripture, offers pastoral counseling, prays with members, and provides spiritual and administrative leadership.',
      emoji: '✝️',
      email: 'pastor@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09802-Cignaa9EAUBq5p2k.jpeg',
    ),
    Ministry(
      name: "Men's Ministry",
      leader: 'Samson Rentapalli',
      description:
          'As men, we empower one another through devotion, Spirit-led living, biblical values, spiritual growth, and discipleship in Christ Jesus.',
      emoji: '👨',
      email: 'mensministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09794-5vnBTLctcrGIiKG4.jpeg',
    ),
    Ministry(
      name: "Women's Ministry",
      leader: 'Vani Willson',
      description:
          'Like pearls woven together, we unite women to discover their identity in Christ, grow spiritually strong, and remain unwavering in God\'s promises.',
      emoji: '👩',
      email: 'womensministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09903-VO25jVehYDsVSbZB.jpeg',
    ),
    Ministry(
      name: 'Worship Ministry',
      leader: 'Sohini Davuluri',
      description:
          'To inspire people of all backgrounds to worship Christ daily, joyfully, and passionately, putting God first in every area of life.',
      emoji: '🙌',
      email: 'worship@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09935-yvYJQnJsGRzNcimu.jpeg',
    ),
    Ministry(
      name: "Kids' Ministry",
      leader: 'Swapna Joe',
      description:
          'To raise children in the fear of the Lord through biblical teaching, daily application, prayer, Bible reading, and using their God-given talents.',
      emoji: '🧒',
      email: 'kidsministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09896-TvKHiGD0aWlvEpJW.jpeg',
    ),
    Ministry(
      name: 'Prayer Ministry',
      leader: 'Christina Choppala',
      description:
          'Prayer is our faith\'s foundation. We foster intercession, teach and encourage prayer and fasting, build prayer networks, and support members through prayer care.',
      emoji: '🙏',
      email: 'prayerministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09910-8YMEH1dL787sgS9e.jpeg',
    ),
    Ministry(
      name: 'Ushering Ministry',
      leader: 'John Stephen Meeniga',
      description:
          'To serve God\'s commission by supporting church operations, welcoming visitors, assisting members, and partnering with ministries to foster worship.',
      emoji: '🙋',
      email: 'usheringministry@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09831-5lMMEtQfQFaEPtPb.jpeg',
    ),
    Ministry(
      name: 'Outreach Ministry',
      leader: 'Kamal Telagathoti',
      description:
          'To win souls for Christ by outreach, mentoring new believers, and evangelizing through community engagement and public witness.',
      emoji: '🌍',
      email: 'outreach@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09851-FKz8NkCPG2YLL3c9.jpeg',
    ),
    Ministry(
      name: 'Discipleship Ministry',
      leader: 'Yesusdas & Deepika',
      description:
          'To equip individuals with a strong biblical foundation, grow closer to God, live like Christ, and become ambassadors drawing others to salvation.',
      emoji: '📖',
      email: 'discipleship@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09842-iFk3UmWZhlgb2gVV.jpeg',
    ),
    Ministry(
      name: 'Media Ministry',
      leader: 'Kiran Vukanti',
      description:
          'Faith comes by hearing. We focus on spoken Word, prayer, and worship through engaging praise, clear audio-visuals, and sharing sermons beyond the church.',
      emoji: '🎬',
      email: 'media@tcfcva.com',
      imageUrl:
          'https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=768/q6jiTAAAMD2PFku5/dsc09853-gUc8QgGoXe844HS3.jpeg',
    ),
    Ministry(
      name: 'Events Ministry',
      leader: 'Eugene Bhatt',
      description:
          'Organizing retreats, revivals, and fellowship gatherings that draw the congregation closer to God and one another. Every event is intentionally designed to foster spiritual growth, restoration, and community — creating space for God to move powerfully in our lives.',
      emoji: '⛪',
      email: 'eugene.bhatt@gmail.com',
      imageUrl: '',
    ),
  ];
}
