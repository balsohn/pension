# 펜션 예약 관리 시스템

Spring MVC 기반의 객실 예약, 관광 정보 공유 기능을 갖춘 웹 애플리케이션입니다. 사용자 계정 관리, 실시간 객실 예약, 게시판 관리 등 펜션 관리에 필요한 종합적인 기능을 제공합니다.

## 프로젝트 개요

- **개발 기간**: 2023.07 - 2023.08
- **개발 인원**: 1명 (개인 프로젝트)
- **담당 역할**: 풀스택 개발 (DB 설계, 백엔드/프론트엔드 구현, 서버 구축)

## 사용 기술

- **백엔드**: Java, Spring MVC, MyBatis
- **프론트엔드**: JSP, JavaScript, HTML/CSS
- **데이터베이스**: MySQL
- **서버**: Apache Tomcat
- **기타 라이브러리**: JavaMail API, MultipartRequest(파일 업로드)

## 주요 기능

### 1. 사용자 관리
- 회원가입, 로그인/로그아웃 기능
- 개인정보 조회 및 수정
- 아이디/비밀번호 찾기 (이메일 인증)

### 2. 객실 관리 및 예약 시스템
- 객실 정보 CRUD (관리자)
- 객실 목록 조회 및 상세 정보 확인
- 날짜별 객실 예약 가능 여부 확인
- 실시간 예약 프로세스
- 예약 목록 조회 및 취소

### 3. 게시판 관리
- 공지사항 게시판
- 일반 게시판 (CRUD 기능)
- 관광 정보 게시판 (이미지 업로드 기능)
- 문의하기 기능 (회원/비회원)

### 4. 관리자 기능
- 객실 관리 (등록/수정/삭제)
- 예약 관리
- 문의 답변 관리

## 구현 내용

### 객실 예약 시스템
- 날짜 기반의 객실 예약 가능 여부 검사 로직 구현
- 예약 정보 저장 및 조회 기능
- 예약 취소 처리

```java
// 날짜 비교를 통한 객실 예약 가능 여부 확인
public static boolean isCheck(String date, int rid) throws Exception {
    // DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    String db="jdbc:mysql://localhost:3306/pension";
    Connection conn=(Connection) DriverManager.getConnection(db,"root","1234");
    
    String sql="select count(*) as cnt from reserve where inday <= ?  and outday > ? and rid=?";
    PreparedStatement pstmt=(PreparedStatement) conn.prepareStatement(sql);
    pstmt.setString(1, date);
    pstmt.setString(2, date);
    pstmt.setInt(3, rid);
    
    ResultSet rs=pstmt.executeQuery();
    rs.next();
    int cnt=rs.getInt("cnt");
            
    rs.close();
    pstmt.close();
    conn.close();
    
    if(cnt==0)
        return false; // 예약 가능
    else
        return true;  // 예약 불가능
}
```

### 이메일 인증 기능
- JavaMail API를 활용한 이메일 발송 기능
- 비밀번호 찾기 및 인증 기능에 활용

```java
public int setEmail(String email, String subject, String body) throws Exception {
    String host = "smtp.naver.com"; 
    final String username = ""; // 송신자 네이버 아이디
    final String password = ""; // 송신자 네이버 비밀번호
    int port=465;
    int state=0;

    String recipient = email; // 받는 사람 이메일 주소

    Properties props = System.getProperties();
    // ... 이메일 전송 설정 및 로직
}
```

### 파일 업로드 기능
- 객실 이미지 및 관광 정보 이미지 업로드
- MultipartRequest를 활용한 파일 처리

```java
String path=request.getRealPath("/resources/tour");
int size=1024*1024*30;
MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

Enumeration files=multi.getFileNames();

String newimg="";
while(files.hasMoreElements()) {
    String imsi=files.nextElement().toString();
    newimg+=multi.getFilesystemName(imsi)+"/";
}
newimg=newimg.replace("null/", "");
```

## 배운 점 및 개선 사항

### 배운 점
- Spring MVC 아키텍처 패턴 적용 및 이해
- MyBatis를 활용한 데이터 접근 계층 구현
- 복잡한 날짜 비교 로직 구현
- JSP와 JSTL을 활용한 화면 구현

### 향후 개선 사항
- 트랜잭션 관리 강화를 통한 동시성 이슈 해결
- 보안 강화 (XSS, CSRF 방지)
- RESTful API로 리팩토링
- JUnit 테스트 코드 추가

## 프로젝트 구조
```
src/main/java/kr/co/pension/
├── controller/
│   ├── AdminController.java       # 관리자 기능
│   ├── BoardController.java       # 게시판 관리
│   ├── DefaultController.java     # 기본 REST 컨트롤러
│   ├── InquiryController.java     # 문의 기능
│   ├── MemberController.java      # 회원 관리
│   ├── NoticeController.java      # 공지사항 관리
│   ├── ReserveController.java     # 예약 관리
│   ├── RoomController.java        # 객실 관리
│   └── TourController.java        # 관광 정보 관리
├── dao/                           # 데이터 접근 객체
│   ├── AdminDAO.java/xml
│   ├── BoardDAO.java/xml
│   └── ...
├── dto/                           # 데이터 전송 객체
│   ├── BoardDTO.java
│   ├── InquiryDTO.java
│   └── ...
└── util/                          # 유틸리티 클래스
    ├── MailSend.java              # 이메일 발송
    └── Utils.java                 # 공통 유틸리티
```
