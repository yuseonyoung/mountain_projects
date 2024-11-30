# 등산어때

[side project] 

목적 : QGIS툴과 GIS가 웹에서 동작하는 방식과 EgovFramework를 공부하기 위하여 Project를 진행하였습니다.

설명 : 등산인들을 위한 SNS를 제작하였고, 벤치마킹은 Instagram을 참고하여 하였습니다.
       회원은 게시물을 올릴수 있고, 모집기능을 이용하여 회원들을 모집하여 같이 등산모임을 진행하는것도 가능합니다.

기술 : Java, SpringFrameWork, TilesFrameWork, OpenLayers, Qgis, EgovFrameWork, Geoserver, ERDCloud, Ajax, Javascript, Html, CSS, Jquery, PostgresSql, PostGIS, Maven, log4j

API : 공공데이터 포털의 산림청_산 정보 조회 openAPI, 공공데이터 포털의 100대명산목록기본정보조회 openAPI

산출물 및 이미지, Geoserver관련 파일은 Master branch에 있음.

[로그인 화면]
![image](https://github.com/user-attachments/assets/d3acfbf6-5b5a-44b5-8e85-5bd65af532bc)

{로그인 화면}

비밀번호는 암호화 알고리즘을 추가하여 저장되게 하였습니다.

![image](https://github.com/user-attachments/assets/fc5d1854-189f-4fdc-8238-6d1c41e377ca)

{암호화로 저장된 비밀번호}


[메인화면 - 전체조회, 친구만 조회]

![image](https://github.com/user-attachments/assets/1344e6f2-9256-4b39-a103-288873dfe037)

{게시물}

각 유저들의 게시물이 등록되는 화면이며 좋아요 댓글을 사용할 수 있습니다 (개발시간이 적은 관계로 공유는 기능에 넣지 못하였습니다)

![image](https://github.com/user-attachments/assets/a60cf52f-a818-4f62-99ff-9f19764fe763)
![image](https://github.com/user-attachments/assets/8f15aef5-1334-4adb-aec5-e6aa8e72b1ae)

{무한 스크롤 로직}

무한스크롤 기능을 적용하였고 한번에 모든 페이지를 조회하면 초기 로딩이 오래걸리고 부하가 걸리기 때문에 스크롤이 마지막 페이지의 도달하는식으로 처리 하였습니다.


![image](https://github.com/user-attachments/assets/7be388ca-62f9-449c-82b1-f354d68fe09c)

{좋아요, 댓글}

댓글은 평소에 숨겨져 있고 클릭시 오픈됩니다

친구만 조회는 자신이 친구로 등록한사람의 게시물만 표시됩니다.
=> 다른기능은 같기 때문에 넘어가겠습니다.

[모집게시물]

모집게시물은 등산을 같이 가고싶은 회원을 모집하여 함께 등산을 할 수 있도록 제공하는 게시판형식의 서비스입니다. 

각각의 게시물은 전부 조회가 가능하며 등록자가 본인 게시물을 들어갈 경우에만 수정버튼을 활성화 하였습니다.

기능으로는 게시물 CRUD가 있고 

지도와 FeatureLayer를 통하여 MultiPolygon으로 각 시도경계를 표현해주었습니다. Polygon의 데이터를 전부 openLayers로 올릴 경우 데이터의 양이 너무 많기 떄문에 

웹의 성능문제가 생겼고 이를 해결하기 위해 Geoserver에 FeatureLayer를 등록해놓고 서버의 api를 호출하여 웹에 보여주는 방식을 채택하여 사용하여 웹성능의 문제를 해결 하였습니다.

또한 산림청의 산정보 API를 통하여 각 산의 정보(산의 이미지, 산행길, 높이 등등..)를 실시간으로 조회하여 표출 하였습니다

![image](https://github.com/user-attachments/assets/eb06d0ac-72b5-4b47-9397-ed5c6c1686b1)

{모집게시물 리스트조회}

![image](https://github.com/user-attachments/assets/cdf61977-2f42-40d4-919f-804784cbcb10)

{모집게시물 상세조회}

![image](https://github.com/user-attachments/assets/3dcdc44b-8a5c-49fe-aec5-15cfb46c3b1a)

{산 조회}

![image](https://github.com/user-attachments/assets/dba428d0-095a-4eb2-a733-a0d76891a44f)

{산 상세조회 - 가리왕산 클릭 시}
※ 산림청_산 정보 조회 openAPI를 이용하여 산의 이미지 및 상세정보 조회
※ 100대명산목록 기본정보조회 openAPI를 이용하여 산의 좌표 및 정보를 조회
=> 산을 검색해서 해당 산을 찾으면 등록버튼을 눌러 산을 등록한다

![image](https://github.com/user-attachments/assets/23dea9f2-432e-413a-8db0-bcbdc2725fac)

{가리왕산이 등록된 모습}

[지역통계]

지역통계는 어느 산으로 모임을 많이 갔는지를 지도에 표현하여 색의 그라데이션이 진할 수록 모임횟수가 높고 연할 수록 모임횟수가 낮음을 표시하여 한눈에 보기 편하도록 만들었습니다.
FeatureLayer는 모집게시물과 동일하게 Geosever에 등록 해놓은 데이터를 API호출하여 보여주는식으로 성능개선을 하였습니다. 

![image](https://github.com/user-attachments/assets/96ec9a20-36eb-4ab4-b1f4-60f3edf7e9cd)

{모임 지역 통계}

![image](https://github.com/user-attachments/assets/5a5cab0a-6330-450a-9583-44474f48fe71)

{그라데이션으로 지도 색상 조절}


