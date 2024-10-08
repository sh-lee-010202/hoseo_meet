import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'room_list.dart'; // 자취방 리스트를 불러오기 위한 import
import '../widgets/post_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _selectOptions = ['전체', '모임', '배달', '택시', '카풀'];
  String _selectedOption = '전체';
  bool _isDropdownOpened = false; // 드롭다운이 열렸는지 여부를 추적

  bool _isSubCategoryVisible = false; // 자취방을 눌렀을 때 하위 카테고리 표시
  String _selectedSubCategory = '전체'; // 기본값으로 '전체' 카테고리 선택

  // 메인 카테고리 활성화를 위한 변수 (디폴트 선택 없음)
  String _selectedMainCategory = '';

  // 하위 카테고리 리스트 (첫번째 인덱스에 '전체' 추가)
  final List<String> subCategories = ['전체', '정문', '중문', '후문', '기숙사'];

  final List<Map<String, dynamic>> posts = [
    {
      "id": 123,
      "type": "배달",
      "title": "주말 모임",
      "content": "주말에 함께 모여 식사해요!",
      "join_people": 4,
      "max_people": 10,
      "gender": "무관",
      "page_view": 3,
      "created_at": "2024-08-12T10:00:00Z"
    },
    {
      "id": 124,
      "type": "모임",
      "title": "주중 모임",
      "content": "주중에 함께 산책해요!",
      "join_people": 4,
      "max_people": 8,
      "gender": "무관",
      "page_view": 23,
      "created_at": "2024-08-13T12:00:00Z"
    },
    {
      "id": 125,
      "type": "배달",
      "title": "저녁 모임",
      "content": "저녁에 함께 영화 봐요!",
      "join_people": 4,
      "max_people": 12,
      "gender": "무관",
      "page_view": 13,
      "created_at": "2024-08-14T18:00:00Z"
    },
    {
      "id": 126,
      "type": "택시",
      "title": "저녁 모임",
      "content": "저녁에 함께 영화 봐요!",
      "join_people": 4,
      "max_people": 12,
      "gender": "무관",
      "page_view": 13,
      "created_at": "2024-08-14T18:00:00Z"
    },
    {
      "id": 127,
      "type": "모임",
      "title": "저녁 모임",
      "content": "저녁에 함께 영화 봐요!",
      "join_people": 4,
      "max_people": 12,
      "gender": "무관",
      "page_view": 13,
      "created_at": "2024-08-14T18:00:00Z"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double panelHeightOpen = MediaQuery.of(context).size.height * 0.73; // 슬라이드 패널이 완전히 열렸을 때 높이
    final double panelHeightClosed = MediaQuery.of(context).size.height * 0.15; // 슬라이드 패널이 닫혔을 때 높이 (카테고리 탭 바로 아래까지)

    return Scaffold(
      body: Stack(
        children: [
          // 지도 또는 백그라운드
          Center(
            child: Text('지도 API 백그라운드'), // 여기에는 지도 API 연동 코드가 들어가야 합니다.
          ),

          // 검색바
          Positioned(
            top: 15,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "장소, 음식점, 카페 검색",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 카테고리 탭
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(), // 좌우 슬라이드 가능하게 설정
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    children: [
                      _buildCategoryButton('자취방', _selectedMainCategory == '자취방' ? 'assets/img/icon/mainpage/roomtypered.png' : 'assets/img/icon/mainpage/roomtype.png', _toggleSubCategory, _selectedMainCategory == '자취방'),
                      _buildCategoryButton('음식점', _selectedMainCategory == '음식점' ? 'assets/img/icon/mainpage/foodtypered.png' : 'assets/img/icon/mainpage/foodtype.png', () => _selectMainCategory('음식점'), _selectedMainCategory == '음식점'),
                      _buildCategoryButton('카페', _selectedMainCategory == '카페' ? 'assets/img/icon/mainpage/cafetypered.png' : 'assets/img/icon/mainpage/cafetype.png', () => _selectMainCategory('카페'), _selectedMainCategory == '카페'),
                      _buildCategoryButton('술집', _selectedMainCategory == '술집' ? 'assets/img/icon/mainpage/bartypered.png' : 'assets/img/icon/mainpage/bartype.png', () => _selectMainCategory('술집'), _selectedMainCategory == '술집'),
                      _buildCategoryButton('편의점', _selectedMainCategory == '편의점' ? 'assets/img/icon/mainpage/shoptypered.png' : 'assets/img/icon/mainpage/shoptype.png', () => _selectMainCategory('편의점'), _selectedMainCategory == '편의점'),
                      _buildCategoryButton('놀거리', _selectedMainCategory == '놀거리' ? 'assets/img/icon/mainpage/playtypered.png' : 'assets/img/icon/mainpage/playtype.png', () => _selectMainCategory('놀거리'), _selectedMainCategory == '놀거리'),
                    ],
                  ),
                ),

                // 자취방 선택 시 하위 카테고리 표시
                if (_isSubCategoryVisible)
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      children: subCategories.map<Widget>((category) {
                        return _buildCategoryButton(
                          category,
                          '', // 하위 카테고리는 아이콘이 없으므로 빈 문자열 전달
                              () => _selectSubCategory(category), // 하위 카테고리 선택 시 호출
                          _selectedSubCategory == category, // 선택된 하위 카테고리 강조
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),

          // 슬라이드 패널
          SlidingUpPanel(
            minHeight: panelHeightClosed, // 패널이 닫혔을 때 높이
            maxHeight: panelHeightOpen, // 패널이 열렸을 때 높이
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            // 패널 내부의 내용을 조건에 따라 자취방 리스트와 기존 패널로 구분
            panel: _selectedMainCategory == '자취방' ? RoomList() : _buildPanelContent(),
            body: Stack(
              children: [
                // 패널 뒤에 있는 내용: 지도와 버튼
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.28,
                  left: 16,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/img/icon/mainpage/heart.png',
                            width: 30, // 이미지 크기 조정
                            height: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/img/icon/mainpage/gps.png',
                            width: 30, // 이미지 크기 조정
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ), // 패널 뒤에 있는 지도나 다른 내용
          ),
        ],
      ),
    );
  }

  // 카테고리 버튼 빌드 함수
  Widget _buildCategoryButton(String text, String iconPath, [VoidCallback? onPressed, bool isSelected = false]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 6), // 버튼 간격을 약간 넓게 유지
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.red : Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8), // 부드러운 패딩 값
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 2,
          side: BorderSide(color: Colors.grey),
        ),
        child: Row(
          children: [
            if (iconPath.isNotEmpty) // 아이콘이 있을 때만 출력
              Image.asset(
                iconPath,
                width: 20, // 아이콘 크기 유지
                height: 20,
              ),
            if (iconPath.isNotEmpty) SizedBox(width: 6), // 아이콘과 텍스트 간격을 적절히 유지
            Text(
              text,
              style: TextStyle(fontSize: 14), // 텍스트 크기를 줄여서 정돈된 느낌 제공
            ),
          ],
        ),
      ),
    );
  }

  // 하위 카테고리 선택 함수
  void _selectSubCategory(String category) {
    setState(() {
      _selectedSubCategory = category;
    });
  }

  // 메인 카테고리 선택 함수
  void _selectMainCategory(String category) {
    setState(() {
      _selectedMainCategory = category;
      _isSubCategoryVisible = false; // 자취방 외 다른 메인 카테고리 선택 시 서브카테고리 비활성화
    });
  }

  // 하위 카테고리 토글 함수
  void _toggleSubCategory() {
    setState(() {
      _isSubCategoryVisible = !_isSubCategoryVisible;
      _selectedMainCategory = '자취방'; // 자취방을 다시 선택하면 메인 카테고리 활성화
    });
  }

  // 기존 패널 내용
  Widget _buildPanelContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Center(
          child: Container(
            height: 3,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '지금 소소님을 기다리고 있어요!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Select 탭을 Title 우측에 배치
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // 흰색 배경 설정
                  boxShadow: _isDropdownOpened
                      ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // 그림자 위치 조정
                    ),
                  ]
                      : [], // 클릭 전에는 그림자 없음
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white, // 드롭다운 배경을 흰색으로 설정
                    value: _selectedOption,
                    icon: SizedBox.shrink(), // 기본 화살표 숨김
                    items: _selectOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          width: 70, // 드롭다운의 아이템 너비 조정
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(value),
                              Divider(color: Colors.grey), // 경계선 추가
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue!;
                        _isDropdownOpened = false; // 드롭다운이 닫히면 그림자 제거
                      });
                    },
                    onTap: () {
                      setState(() {
                        _isDropdownOpened = true; // 드롭다운이 열리면 그림자 추가
                      });
                    },
                    // 텍스트와 아이콘을 평행하게 배치
                    selectedItemBuilder: (BuildContext context) {
                      return _selectOptions.map((String value) {
                        return Row(
                          children: [
                            Text(value),
                            Icon(Icons.keyboard_arrow_down, color: Colors.black),
                          ],
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return buildPostItem(posts[index]); // 기존 게시물 출력
            },
          ),
        ),
      ],
    );
  }
}
