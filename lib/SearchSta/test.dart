 /* 
  SearchStaInfo.dart 파일 복붙한거라 무시해주세요
 */
 /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(

          child: Stack(
            children: [
              
             
              Positioned(
                top: 250,
                right: 32,
                child: GestureDetector(
                  onTap: () => _toggleFavorite,
                  child: SizedBox(
                    width: imagePath == '../assets/images/favStar.png'
                        ? 24.0
                        : 27.0,
                    height: imagePath == '../assets/images/favStar.png'
                        ? 24.0
                        : 27.0,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            
             
             
          

              // 날씨 상세 구현 : 역마다 바뀌는 값
              Positioned(
                left: 55,
                top: 805,
                child: Container(
                  width: 18,
                  height: 21,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          '../assets/images/subway_small.png'), // 이미지 경로 확인
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 84,
                top: 815,
                child: DefaultTextStyle(
                  //'901 역',
                  style: TextStyle(
                    color: Color(0xFF676363),
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    height: 0.5,
                    letterSpacing: 0.50,
                  ),
                  child: Text('901 역'),
                ),
              ),
              Positioned(
                left: 219,
                top: 864,
                child: SizedBox(
                  width: 116.14,
                  height: 20.70,
                  child: DefaultTextStyle(
                    //'체감 10.8° / 습도 95%',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: 'Roboto',
                      height: 0.20,
                      letterSpacing: 0.50,
                    ),
                    child: Text('체감 10.8° / 습도 95%'),
                  ),
                ),
              ),
              Positioned(
                left: 214,
                top: 828,
                child: SizedBox(
                  width: 85.29,
                  height: 20.70,
                  child: DefaultTextStyle(
                    //'10.8°',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Roboto',
                      height: 0.5,
                      letterSpacing: 0.50,
                    ),
                    child: Text('10.8°'),
                  ),
                ),
              ),
              Positioned(
                left: 59,
                top: 837,
                child: Container(
                  width: 140.75,
                  height: 39.67,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 49.52,
                        top: 0,
                        child: Container(
                          width: 41.70,
                          height: 39.67,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFFF4D1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 99.04,
                        top: 0,
                        child: Container(
                          width: 41.70,
                          height: 39.67,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9F5D2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 53,
                        top: 8,
                        child: SizedBox(
                          width: 33.88,
                          height: 20.70,
                          child: Text(
                            '미세먼지',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 1,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 41.70,
                          height: 39.67,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD1E9FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7.82,
                        top: 8,
                        child: SizedBox(
                          width: 25.20,
                          height: 20.70,
                          child: Text(
                            '강수량',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 1,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 9.56,
                        top: 25,
                        child: SizedBox(
                          width: 21.72,
                          height: 20.70,
                          child: Text(
                            '0mm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 0.9,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 61.69,
                        top: 24,
                        child: SizedBox(
                          width: 16.51,
                          height: 20.70,
                          child: Text(
                            '나쁨',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFE69800),
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 0.9,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 111.21,
                        top: 24,
                        child: SizedBox(
                          width: 16.51,
                          height: 20.70,
                          child: Text(
                            '보통',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF4A7700),
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 0.9,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 106.86,
                        top: 8,
                        child: SizedBox(
                          width: 25.20,
                          height: 20.70,
                          child: Text(
                            '자외선',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8,
                              fontFamily: 'Roboto',
                              height: 1,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
        ),
      ),

    );
  }
}*/