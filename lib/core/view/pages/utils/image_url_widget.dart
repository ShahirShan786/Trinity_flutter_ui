import 'dart:math';

class NotificationImage {
  static final List<String> imageUrls = [
    'https://cdn-icons-png.flaticon.com/512/3178/3178793.png', //1
    'https://th.bing.com/th/id/R.37992e887c59f262ba084f7682dc823f?rik=KOEr%2flPX%2bFGNhg&riu=http%3a%2f%2ftranslit.com%2fwp-content%2fuploads%2f2019%2f07%2fcustomer-service.png&ehk=HL2kQFz5F48djOHtXq%2f3RE0T0aaezoBX7Y0hsaSCDgU%3d&risl=&pid=ImgRaw&r=0', //2
    'https://cdn-icons-png.flaticon.com/512/3178/3178808.png', //3
    'https://cdn-icons-png.flaticon.com/512/4694/4694179.png', //4
    'https://cdn-icons-png.flaticon.com/512/12964/12964093.png', //5
    'https://cdn2.iconfinder.com/data/icons/alert-message/64/mobile-bell-icon-128.png', //6
    'https://shiftme.in/img/Packers-Movers-01.png', //7
    'https://poolpatch.com/wp-content/uploads/2022/10/Return-Policy-600x467.png', //8
    'https://cdn-icons-png.freepik.com/512/12214/12214473.png', //9
  ];

  static String getRandomImage() {
    final random = Random();
    return imageUrls[random.nextInt(imageUrls.length)];
  }
}