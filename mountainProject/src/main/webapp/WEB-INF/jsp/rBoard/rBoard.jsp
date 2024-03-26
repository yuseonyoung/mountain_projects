<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/rBoard.css">

<%
String selectBoard = (String) request.getAttribute("selectBoard");
String userId = (String) session.getAttribute("userId");
%>
<div id="totalPage">
	<div id="listForm">
		<table id="rBoardTable">
			<!-- Header -->
			<thead>
				<tr>
					<th id="headText" colspan="6" style="text-align: center;">등산
						모집 공고</th>
				</tr>
			</thead>

			<!-- Body -->
			<tbody>
				<tr>
					<th class="tbodyTh">순번</th>
					<th class="tbodyTh">제목</th>
					<th class="tbodyTh">참여일</th>
					<th class="tbodyTh">참여금액</th>
					<th class="tbodyTh">마감여부</th>
					<th class="tbodyTh">작성자</th>
				</tr>
				<c:forEach items="${RBoardList}" var="item">
					<tr>
						<td class="rnumTd">${item.rnum}</td>
						<td class="titleTd">
						<input type='hidden' class='rBoardId' value='${item.boardVO.boardId}' /> 
						<input type="hidden" class="userIdTd" value="${item.userDetail.userId}"> 
						<a class='rBoardDetail' href='javascript:;' onclick='rBoardDetail(this)'>${item.boardTitle}</a></td>
						<td class="cdateTd">${item.boardVO.cdate}</td>
						<td class="participationPeeTd">${item.participationPee}</td>
						<td class="deadlineStatusTd">${item.deadlineStatus}</td>
						<td class="userNameTd">${item.userDetail.name}</td>
					</tr>
				</c:forEach>
			</tbody>

			<!-- Footer -->
			<tfoot>
				<tr>
					<td colspan="6">
						<div class="paging" style="text-align: center; font-size: 20px;">
							<ui:pagination paginationInfo="${paginationInfo}" type="image"
								jsFunction="linkPage" />
						</div>
						<button id="createForm" class="custom-btn btn-1" type="button">
							<span>등록</span>
						</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

	<div id="formView" style="display: none">
		<form:form id="rBoardForm" modelAttribute="totBoard"
			action="${pageContext.request.contextPath}/board/rBoardInsert.do"
			method="post" enctype="multipart/form-data">
			<div id='rBoardFormDiv'>
				<div id="rBoardLineDiv">
					<div id="titleBox">
						<input id="titleText" type="text" placeholder="제목을 입력해 주세요"
							name="boardTitle" />
					</div>
					<span id="boardTitle_error" class="error"></span>
					<div id="flexBox">
						<div class="inputBox"></div>
						<div class="searchBox">
							<button id="customButton" type='button'></button>
						</div>
					</div>
					<div id="dataBox">
						<div>
							<label>참여일자 : </label> <input id="dateInput" class="datepicker"
								type="text" name="cdate" />
						</div>
						<span id="cdate_error" class="error"></span>
					</div>
					<div id="subDataBox">
						<div id="pee">
							<label>참여금액 : </label> <input id="peeInput" type="number"
								name="participationPee" placeholder="금액을 입력 하세요" /> <span
								id="participationPee_error" class="error"></span>
						</div>
						<div id="p_people">
							<div>
								<label>참여인원 : </label> <input id="participationInput"
									name="recQty" type="number" placeholder="0" />
							</div>
							<span id="recQty_error" class="error"></span>
						</div>
					</div>
					<div id="contentsLine">
						<div id="ctntImageDIv">
							<input type="file" id="fileInput" name="fileCode"
								style="display: none;" />
							<div class="fileConfirm">
								<button id="addFile" class="add-button" type="button"></button>
							</div>
							<div id="cancleData"></div>
						</div>
						<div id="ctntDiv">
							<textarea id="ctntText" name="ctnt" placeholder="내용을 입력해 주세요"></textarea>
							<span id="ctnt_error" class="error"></span>
						</div>
					</div>
					<button class="custom-btn btn-1" type="submit">
						<span>등록</span>
					</button>
					<button id="cancleBtn" class="custom-btn btn-2" type="button">
						<span>취소</span>
					</button>
				</div>
			</div>
		</form:form>
	</div>

	<div id="updateForm" style="display: none">
		<form:form id="u_rBoardForm" modelAttribute="updateBoard"
			action="${pageContext.request.contextPath}/board/rBoardUpdate.do"
			enctype="multipart/form-data">
			<div id='u_rBoardFormDiv'>
					<div id="u_rBoardLineDiv">
						<div id="u_titleBox">
							<input id="hiddenUdpateBoardId" type="hidden" name="boardId" /> 
							<input id="u_titleText" type="text" placeholder="제목을 입력해 주세요"
								name="boardTitle" />
						</div>
						<span id="u_boardTitle_error" class="error"></span>
						<div id="u_flexBox">
							<div class="u_inputBox"></div>
							<div class="u_searchBox">
								<button id="customButton" type='button'></button>
							</div>
						</div>
						<div id="u_dataBox">
							<div>
								<label>참여일자 : </label> <input id="u_dateInput" class="datepicker"
									type="text" name="cdate" />
							</div>
							<span id="u_cdate_error" class="error"></span>
						</div>
						<div id="u_subDataBox">
							<div id="u_pee">
								<label>참여금액 : </label> <input id="u_peeInput" type="number"
									name="participationPee" placeholder="금액을 입력 하세요" /> <span
									id="u_participationPee_error" class="error"></span>
							</div>
							<div id="u_p_people">
								<div>
									<label>참여인원 : </label> <input id="u_participationInput"
										name="recQty" type="number" placeholder="0" />
								</div>
								<span id="u_recQty_error" class="error"></span>
							</div>
						</div>
						<div id="u_contentsLine">
							<div id="u_ctntImageDIv">
								<img id="u_rBoardImage" src=""
									style="width: 100%; height: 100%; background-size: cover;">
							</div>
							<input type="file" id="u_fileInput" name="fileCode"/>
							<div id="u_cancleData"></div>
							<div id="u_ctntDiv">
							<textarea id="u_ctntText" name="ctnt" placeholder="내용을 입력해 주세요"></textarea>
							<span id="u_ctnt_error" class="error"></span>
						</div>
					</div>
					<button class="custom-btn btn-1" type="submit">
						<span>수정</span>
					</button>
					<button id="u_returnBtn" class="custom-btn btn-2" type="button">
						<span>돌아가기</span>
					</button>
				</div>
			</div>
		</form:form>
	</div>


	<div id="rboardDetailView" style="display: none">
		<div id='rBoardFormDiv'>
			<div id="rBoardLineView">
				<div id="titleBoxView">
					<input id="hiddenBoardId" type="hidden" /> <input id="titleInput"
						type="text" readonly />
				</div>
				<div id="flexBoxData">
					<label style="width: 10%;">산 명 : </label>
					<div class="inputBoxClass">
						<input type="text" id="mntnNmInput" readonly>
					</div>
				</div>
				<div id="dateBox">
					<label>참여일자 : </label> <input id="cdateInput" class="datepicker"
						type="text" readonly>
				</div>
				<div id="subDataBoxDiv">
					<div id="pee">
						<label>참여금액 : </label> <input id="peeInputData" readonly>
					</div>
					<div id="p_peopleDetail" style="margin-left: 10px;">
						<label>참여인원 : </label> <input id="participationInputData" readonly>
					</div>
					<div id="p_recruitment" style="margin-left: 10px;">
						<label>모집된 인원 : </label> <input id="recruitmentInputData" readonly>
					</div>
				</div>

				<div id="contentsLineDiv">
					<div id="contentImageDIv">
						<div class="fileConfirm">
							<img id="rBoardImage" src=""
								style="width: 100%; height: 100%; background-size: cover;">
						</div>
					</div>
					<div id="contentDiv">
						<textarea id="contentText" readonly></textarea>
					</div>
				</div>
				<div id="btnDiv"></div>
			</div>
		</div>
	</div>

</div>
<!-- 팝업 모달 -->
<div class="main-popup">
	<div class="popup-header">
		<div id="popup-close-button">
			<a href="#"></a>
		</div>
		<div id="headerButton">
			<button class="custom-btn btn-1" type="button"
				onclick="areaView(event)">
				<span>지도보기</span>
			</button>
			<button class="custom-btn btn-1" type="button"
				onclick="selectMountain(event)">
				<span>등록</span>
			</button>
		</div>
	</div>
	<div class="popup-content">
		<div id="popup-contentDiv">
			<div id="popup-search">
				<div id="popupLine">
					<div id="searchDiv1">
						<table id="popup-table">
							<thead>
								<tr>
									<th id="popup-headerText" colspan="3"
										style="text-align: center;"><h1 id="titlepath">지역을
											선택해 주세요</h1></th>
								</tr>
							</thead>
							<tbody id="mnListBody">
							</tbody>
						</table>
					</div>
					<div id="searchDiv2">
						<div>
							<label>선택 : </label> <input type="text" id="mountainNm" />
						</div>
						<div>
							<label>추천코스길 : </label>
							<textarea id="popupTextArea"></textarea>
						</div>
					</div>
				</div>
			</div>
			<div id="popup-map" style="display: flex">
				<div id="map" class="map" style="width: 70%; height: 80vh;"></div>
				<div
					style="width: 30%; height: 80vh; display: flex; flex-direction: column;">
					<div id="mntnImages"></div>
					<div id="infoDatas" style="display: none;">
						<label>산 정보 : </label>
						<textarea id="mntnInfos"></textarea>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>

<div class="modal-background"></div>
<script>
	
	$( ".datepicker" ).datepicker({
		  dateFormat: "yy-mm-dd"
		});

	
  	$(document).on("click", "#popup-close-button", function() {
       $(".main-popup").removeClass('visible');
       $(".modal-background").hide();
    });
  	
    $(document).on("click", ".inputBox, #customButton", function() {
        console.log("클릭");
        $(".main-popup").addClass('visible');
        $(".modal-background").show();
        
        //map 생성
    	showMap();
        
    });
    
    var flagData = false;
    var map; // 전역 변수로 map을 선언합니다.
    function showMap() {
        // 이미 map 객체가 있으면 함수를 종료합니다.
        if (map) {
            return;
        }

        map = new ol.Map({
            target: 'map',
            layers: [
                // OpenStreetMap 타일 레이어 추가
                new ol.layer.Tile({
                    source: new ol.source.OSM()
                })
            ],
            view: new ol.View({
                center: ol.proj.fromLonLat([128.4, 35.7]),
                zoom: 7
            })
        });

        // WFS 소스 생성
        var vectorSource = new ol.source.Vector({
            format: new ol.format.GeoJSON(),
            url: function(extent) {
                // WFS GetFeature 요청 URL 생성
                return 'http://localhost:8080/geoserver/mountain/wfs' +
                    '?service=WFS&' +
                    'version=1.1.0&' +
                    'request=GetFeature&' +
                    'typeName=mountain:boundaryMap_4326&' +  // WFS 레이어 이름
                    'outputFormat=application/json&' +
                    'srspath=EPSG:3857&' +
                    'bbox=' + extent.join(',') + ',EPSG:3857';
            },
            strategy: ol.loadingstrategy.bbox
        });

        // vectorSource에서 피처 가져오기
        vectorSource.once('change', function() {
            var features = vectorSource.getFeatures();

            // 각 피처의 속성 및 기하정보 출력
            features.forEach(function(feature) {
                var properties = feature.getProperties(); // 피처의 속성 가져오기
                var geometry = feature.getGeometry(); // 피처의 기하정보 가져오기
                console.log('Feature Properties:', properties);
                console.log('Feature Geometry:', geometry);
            });
        });

        // 피처 레이어에 스타일 설정
        var style = function(feature) {
            return new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: 'black', // 검은색 경계선
                    width: 2
                }),
                fill: new ol.style.Fill({
                    color: 'rgba(255, 255, 0, 0.5)' // 노란색 피처
                }),
                text: new ol.style.Text({
                    text: feature.get('NAME'), // 라벨 템플릿: 속성 'path' 값으로 라벨 표시
                    font: '12px Arial',
                    fill: new ol.style.Fill({
                        color: 'black'
                    })
                })
            });
        };
	
        
        var vectorLayer = new ol.layer.Vector({
            source: vectorSource,
            style: style // 위에서 정의한 스타일 함수 적용
        });
		
        var selectedFeature = null; // 선택된 피처를 저장하기 위한 변수
        
        // 피처 클릭 이벤트 리스너 추가
        map.on('click', function(event) {
            /* $('#mnListBody').empty(); */
            let tbodyTitle = `<tr>
                <th>순번</th>
                <th>산명</th>
                <th>높이</th>
            </tr>
            `;
            
            map.forEachFeatureAtPixel(event.pixel, function(feature) {
                if (selectedFeature !== null) {
                    // 선택 취소: 이전에 선택된 피처의 스타일을 원래대로 되돌림
                    selectedFeature.setStyle(style);
                }
                if (selectedFeature !== feature) {
                    // 새로운 피처 선택: 선택된 피처의 스타일을 변경하고 selectedFeature 업데이트
                    selectedFeature = feature;
                    feature.setStyle(new ol.style.Style({
                        stroke: new ol.style.Stroke({
                            color: 'black', // 검은색 경계선
                            width: 2
                        }),
                        fill: new ol.style.Fill({
                            color: 'red' // 빨간색으로 변경
                        }),
                        text: new ol.style.Text({
                            text: feature.get('NAME'),
                            font: '12px Arial',
                            fill: new ol.style.Fill({
                                color: 'black'
                            })
                        })
                    }));
                    
                    let path = feature.get('NAME');
                    $.ajax({
                        url: '<%=request.getContextPath()%>/board/' + path + '/searchArea.do',
                        method: 'GET',
                        success: function(res) {
                            let mtInfo = res.mountainInfoList;
                 
                         // HTML에 추가할 문자열을 저장할 변수 선언
                            let mountainDataHTML = '';

                            mtInfo.forEach(function(item) {
                                let rnum = item.rnum;
                                let addrnm = item.addrnm;
                                let aslaltide = item.aslaltide;
                                let frtrlnm = item.frtrlnm;
                                let lat = item.lat;
                                let lot = item.lot;
                                let mtncd = item.mtncd;
                                
                                // 각 데이터를 mountainDataHTML에 추가
                                mountainDataHTML += "<tr class='contentInfo'>" +
                                                    "<td>" + rnum + "</td>" +
                                                    "<td><a href='javascript:;' onclick='callOpenApi(this, event)'>" + frtrlnm + "</a>" +
                                                        "<input type='hidden' class='addrnm' value='" + addrnm + "' >" +
                                                        "<input type='hidden' class='aslaltide' value='" + aslaltide + "' >" +
                                                        "<input type='hidden' class='frtrlnm' value='" + frtrlnm + "' >" +
                                                        "<input type='hidden' class='lat' value='" + lat + "' >" +
                                                        "<input type='hidden' class='lot' value='" + lot + "' >" +
                                                        "<input type='hidden' class='mtncd' value='" + mtncd + "' >" +
                                                    "</td>" +
                                                    "<td>" + aslaltide + "</td>" +
                                                "</tr>";
                            });
							let titlepathDetail = path+"의 명산";
                            $('#titlepath').html(titlepathDetail);
                            $('#mnListBody').html(mountainDataHTML);
                            $('#mnListBody').prepend(tbodyTitle);
                            
                        },
                        error: function(xhr, status, error) {
                            // 오류가 발생했을 때 처리하는 코드를 여기에 작성합니다.
                            console.error('API 호출 중 오류 발생:', error);
                        }
                    });
                    
                } else {
                    // 선택 취소: 클릭한 피처가 이미 선택된 상태일 경우
                    selectedFeature = null;
                }
            });
        });
      
        // 지도에 피처 레이어 추가
        map.addLayer(vectorLayer);
    }

    
    function callOpenApi(data, event) {
        event.preventDefault();
        
        // 기존에 생성한 피처 레이어를 찾습니다.
        var vectorLayer = map.getLayers().getArray().find(function(layer) {
            return layer instanceof ol.layer.Vector;
        });

        // 피처 레이어가 존재한다면 제거합니다.
        if (vectorLayer) {
            map.removeLayer(vectorLayer);
        }
        
        $(".img-popup").addClass('visible');
        
        let inputs = $(data).parent().find('input[type="hidden"]');
        
        // 추출된 hidden 데이터를 저장할 객체 생성
        let extractedData = {};

        // 모든 hidden 데이터의 값을 추출하여 객체에 저장
        inputs.each(function() {
            let key = $(this).attr('class'); // input 요소의 클래스 이름을 키로 사용
            let value = $(this).val(); // input 요소의 값
            extractedData[key] = value; // 객체에 키와 값 저장
        });

        // 추출된 데이터 확인
        console.log(extractedData);
        mountainContent(extractedData.frtrlnm);	
        
        areaSelect(extractedData.lat, extractedData.lot);
    } 


	function mountainContent(mtnm){
		
		
		//api호출하는 방법
        var apiUrl = 'http://openapi.forest.go.kr/openapi/service/trailInfoService/getforeststoryservice';
        var serviceKey = 'Ed/35mELOivS5oYydxyKhiKHx7lQFpvLvJ2Qc6M8Tu+YtAVJ7rZ0stzA1lG6sHs8aFq01IC8x0ZcnRg26Rj5zw==';
        var pageNo = 1;
        var numOfRows = 100;
		
        // AJAX 요청
        $.ajax({
            url: apiUrl,
            method: 'GET',
            dataType: 'xml',
            data: {
                'serviceKey': serviceKey,
            	'pageNo' : pageNo,
            	'numOfRows' : numOfRows,
            	'mntnNm' : mtnm
            },
            success: function(res) {
                // API 응답을 처리하는 코드를 여기에 작성합니다.
                console.log("이미지",res);
                
                var xmlDoc = res;
	            var $xml = $(xmlDoc);
	            var mountainInfo = $xml.find('mntninfodscrt').text();
	            var content = $xml.find('crcmrsghtnginfoetcdscrt').text();
	            var image = $xml.find('mntnattchimageseq').first().text();
	            var mtnm = $xml.find('mntnnm').text();
	            var mtInfo = $xml.find('mntninfodtlinfocont').first().text();
				
	            //태그를 제거하는 함수를 호출
	            var formattedContent = formatContent(content);
	            var formattedMninfo = formatContent(mtInfo);
	            
	            console.log('Content:', content);
	            console.log('Image:', image);
	            console.log('mountainInfo:', mountainInfo);
	            
	            $('#mountainNm').val('');
	            $('#popupTextArea').val('');
	            $('#mountainNm').val($xml.find('mntnnm').first().text());
	            $('#popupTextArea').val(formattedContent);
	            $('#mntnImages').empty();
	            imageExists(image, function(exists) {
	                if (exists) {
	                    var imgElement = $('<img>').attr('src', image).css({
	                        'width': '95%',
	                        'height': '300px',
	                        'margin-left': '10px'
	                    });
	                    $('#mntnImages').append(imgElement);
	                }
	            });
	            $('#mntnInfos').val('');
	            $('#mntnInfos').val(formattedMninfo);
            	$('#infoDatas').show();
            },
            error: function(xhr, status, error) {
                // 오류가 발생했을 때 처리하는 코드를 여기에 작성합니다.
                console.error('API 호출 중 오류 발생:', error);
            }
        });
	}
 
	//text에 태그가 들어간것 제거
	function formatContent(content) {
	    return content.replace(/&gt;/g, ">")
	                  .replace(/<BR>/g, "\n")
	                  .replace(/<br>/g, "\n")
	                  .replace(/&amp;#160;/g, " ")
	                  .replace(/&amp;nbsp;/g, " ")
	                  .replace(/&nbsp;/g, " ")
	                  .replace(/<P> <\/P>/g, "")
	                  .replace(/<p>/g, "")
	                  .replace(/<\/p>/g, "")
	                  .replace(/<P>/gi, "")
	                  .replace(/<\/P>/gi, "")
	                  .replace(/&lt;br \/>/g, "\n");
	}
	
	
 	//경로에 이미지가있는지 확인해주는 함수
 	function imageExists(url, callback) {
	    var img = new Image();
	    img.onload = function() {
	        callback(true);
	    };
	    img.onerror = function() {
	        callback(false);
	    };
	    img.src = url;
	}
 	
 	function areaSelect(lat, lot) {
 	    // 기존의 마커를 찾습니다.
 	    var markerOverlay = map.getOverlayById('markerOverlay');

 	    if (markerOverlay) {
 	        // 기존의 마커를 제거합니다.
 	        map.removeOverlay(markerOverlay);
 	    }

 	    // 새로운 중심 좌표를 계산합니다.
 	    var newCenter = ol.proj.fromLonLat([lot, lat]);

 	    // 애니메이션을 사용하여 맵을 새로운 중심 좌표로 부드럽게 이동시킵니다.
 	    map.getView().animate({
 	        center: newCenter, // 이동할 새로운 중심 좌표
 	        duration: 2000,    // 애니메이션의 지속 시간 (밀리초 단위)
 	        easing: ol.easing.linear // 이동 애니메이션에 사용할 easing 함수
 	    });

 	    // 맵의 중심 좌표를 설정합니다.
 	    map.getView().setCenter(
 	        new ol.geom.Point([lot, lat]).transform('EPSG:4326', 'EPSG:3857').getCoordinates()
 	    );

 	    // 맵의 줌 레벨을 설정합니다.
 	    map.getView().setZoom(16);

 	    // 마커를 생성하고 오버레이로 추가합니다.
 	    var markerElement = document.createElement('img');
 	    markerElement.src = '<%=request.getContextPath()%>/images/board/marker.png';
 	    markerElement.style.width = '20px'; // 마커 크기 조정

 	    var markerOverlay = new ol.Overlay({
 	        id: 'markerOverlay',
 	        position: newCenter,
 	        element: markerElement
 	    });

 	    map.addOverlay(markerOverlay);
 	}


 	
     // 배경을 클릭해도 팝업이 닫히지 않도록 이벤트 핸들러 추가
    $(document).on("click", ".modal-background", function(event) {
        event.stopPropagation(); // 이벤트 버블링 방지
    });
      
    $(document).on('click', '#addFile', function() {
   		$('#fileInput').click(); // 파일 입력 요소 클릭
	});
    
    $(document).on('change', '#fileInput', function(e) {
	    let files = e.target.files;
	    console.log('파일 정보:', files); // 파일 정보 출력
	    const fileConfirm = $('.fileConfirm');
		let cancleData = $('#cancleData');
	    for (let i = 0; i < files.length; i++) {
	        const file = files[i];
	        
	        // 파일이 이미지가 아닌 경우 경고 메시지 표시
	        if (!file.type.startsWith('image/')) {
	            alert('이미지 파일을 선택해주세요.');
	            $('#fileInput').val(''); // 파일 선택 취소
	            return; // 함수 종료
	        }
	        
	        const reader = new FileReader();
	
	        reader.onload = function(e) {
	            let image = $('<img>');
	            image.attr('src', e.target.result);
	            image.css('max-width', '100%');
	            image.css('max-height', '100%');
	            fileConfirm.empty();
	            fileConfirm.append(image);
	
	            // 파일 선택 취소 버튼 추가
	            const cancelButton = $('<button>');
	            cancelButton.attr('id', 'cancelFile');
	            cancelButton.attr('type', 'button'); // 버튼 타입을 명시적으로 지정
	            cancelButton.text('파일 취소');
	            cancelButton.css('background-color', '#6B8E23'); // 배경색을 연한 초록색으로 설정
	            cancelButton.css('color', 'white'); // 텍스트 색상을 하얀색으로 설정
	            cancleData.append(cancelButton);
	        };
	        reader.readAsDataURL(file);
	    }
	});
	    
	// 파일 선택 취소 버튼 클릭 시
	$(document).on('click', '#cancelFile', function() {
	    $('#fileInput').val(''); // 파일 선택 취소
	    $('.fileConfirm').empty(); // 이미지 미리보기 영역 비우기
	    
	    let imageData =`
	    	<input type="file" id="fileInput" style="display: none;">  
	   		<button id="addFile" class="add-button" type="button"></button>
	    `
	    $('.fileConfirm').append(imageData); 
	    $('#cancelFile').hide();
	});
	   
	
	
	//비동기로 목록 불러오기 - paging이 동기방식이라 안쓸듯 
	function loadData(){
		// Ajax 요청
		 $.ajax({
		    url: '<%=request.getContextPath()%>/board/rBoardList.do',
		    method: 'GET',
		    success: function(res) {
		    	
		    	console.log(res);
		    	
		        let tbody = $('#rBoardTable');
		        rbList=res.RBoardList
		        
		    	console.log(rbList);
		        
		        rbList.forEach(function(item) {
		            let newRow = "<tr>" +
		                            "<td class='rnumTd'>" + item.rnum + "</td>" +
		                            "<td class='titleTd'><a herf='#'>" + item.boardTitle + "</a></td>" +
		                            "<td class='cdateTd'>" + item.boardVO.cdate + "</td>" +
		                            "<td class='participationPeeTd'>" + item.participationPee + "</td>" +
		                            "<td class='deadlineStatusTd'>" + item.deadlineStatus + "</td>" +
		                        "</tr>";
		            tbody.append(newRow);
		        });

		    }
		}); 
	}
	//지도보기를 눌렀을때 맵을 초기화하고 다시 찍어서 보여줌
	function areaView(event) {
	    // 맵 초기화
	    if (map) {
   	        map.setTarget(null);
   	        map = null;
	    } 
	    //제목 초기화
	    $('#titlepath').html('지역을 선택해 주세요');
	    //산 이미지 초기화
	    $('#mntnImages').html('');
	    //산정보 초기화
	    $('#mntnInfos').val('');
	    $('#infoDatas').css('display','none');
	    //tbody 초기화
	    $('#mnListBody').html('');
	    //tbody th 추가
	    let tbodyTitle = `<tr>
                <th>순번</th>
                <th>산명</th>
                <th>높이</th>
            </tr>
        `;
	    $('#mnListBody').html(tbodyTitle);
		//산 선택 초기화
	    $('#mountainNm').val('');
	    //추천코스길 초기화
		$('#popupTextArea').val('');
	    
	    //새로운 map 표시
    	showMap();
	}
	
	function selectMountain(event){
		event.preventDefault();
		
		let mntnNm = $('#mountainNm').val();
		if (mntnNm) {
		    // 새로운 input 요소 생성
		    var inputElement = $('<input>', {
		        'type': 'text',
		        'id': 'mntnNm',
		        'path': 'mntnNm',
		        'value': mntnNm,
		        'readonly': true // 읽기 전용으로 설정
		    });

		    // CSS 스타일 설정
		    inputElement.css({
		        'width': '100%',
		        'font-size': '16px', // 원하는 폰트 크기로 조정
		        'font-weight': 'bold', // 볼드체로 설정
		        'text-align': 'center', // 가운데 정렬
		        'background-color': '#333',
		        'color': 'white',
		        'border': 'none',
		        'pointer-events': 'none' // 마우스 이벤트 비활성화
		    });

		    // 생성한 input 요소를 해당 위치에 삽입
		    $('.inputBox').replaceWith(inputElement);
		    $('#u_mntnNm').val(mntnNm);
			$('#mntnNm').val(mntnNm);
		}
		
		$('.main-popup').hide();
		$('.modal-background').hide();
	}
	
	function linkPage(pageNo){
		    location.href = "<%=request.getContextPath()%>/board/rBoardList.do?pageNo="+pageNo;
	}	
	 
	$(document).on("submit", "#u_rBoardForm", function(e) {
	    	
    	e.preventDefault();
        
        // FormData 객체를 생성하여 폼 데이터를 담습니다.
        var formData = new FormData($('#u_rBoardForm')[0]);

        // AJAX를 이용하여 서버로 데이터를 전송합니다.
        $.ajax({
            url: $(this).attr('action'), 
            method: "POST",
            data: formData,
            processData: false, // 데이터 처리를 jQuery에 맡깁니다.
            contentType: false, // 데이터의 content type을 설정하지 않습니다.
            success: function(res) {
                console.log(res);
                let result = res.success;
                if(result == 'success'){
                    alert('수정이 완료되었습니다.');
                }  else {
                    alert('수정이 실패하였습니다.');
                }
            },
            error: function(xhr, status, error) {
                console.error('오류:', error);
            }
        });
    });
    
	 // 파일 입력 요소에 변경 이벤트 리스너 추가
	document.getElementById("u_fileInput").addEventListener("change", function(event) {
	     // 파일이 선택되었는지 확인
	     if (event.target.files.length > 0) {
	         // 파일 객체 가져오기
	         var file = event.target.files[0];
	         
	         // FileReader 객체 생성
	         var reader = new FileReader();

	         // 파일 읽기 완료 후 실행될 콜백 함수 정의
	         reader.onload = function(event) {
	             // 이미지 URL을 이미지 요소의 src 속성에 할당하여 이미지 표시
	             document.getElementById("u_rBoardImage").src = event.target.result;
	         };
	         // 파일을 읽기
	         reader.readAsDataURL(file);
	     }
	 });
	
    //Board 리스트중 한개 클릭하면 발생하는 이벤트 
    //차후 진행하겠음
    function rBoardDetail(data){
    	//클릭한 이벤트에서 부모요소중 rBoardId를 클래스로가진 value를 가져옴
    	let boardId = $(data).parent().find('.rBoardId').val();
    	let userId = $(data).parent().find('.userIdTd').val();
    	let sessionUserId = <%=userId%>
    	
    	
    	$('#listForm').css('display','none');
    	
    	$.ajax({
 		    url: '<%=request.getContextPath()%>/board/'+boardId+'/rBoardDetail.do',
 		    method: 'GET',
 		    success: function(res) {
 		    	console.log(res);
 		    	let rBoardDetail = res.rBoardDetail; // res에서 rBoardDetail 추출
 		        let boardId = rBoardDetail[0].boardId;
 		        let boardTitle = rBoardDetail[0].boardTitle;
 		        let ctnt = rBoardDetail[0].ctnt;
 		        let mntnNm = rBoardDetail[0].mntnNm;
 		        let userId = rBoardDetail[0].userId;
 		        let fileCode = rBoardDetail[0].fileCode;
 		        let recQty = parseInt(rBoardDetail[0].recQty);
 		        
 		        let participationPee = parseInt(rBoardDetail[0].participationPee);
 		        let cdate = new Date(rBoardDetail[0].cdate);
 		        let formattedCdate = cdate.toISOString().split('T')[0];
 		        
 		        //참여인원이 꽉차면 비활성화
 		        let recCount = rBoardDetail[0].recCount;
 		        let caculate = recQty - recCount;
 		        console.log("나와줘 제ㅏㅂㄹ {}",caculate);
 		        // 조건에 따라 버튼의 래스를 변경하여 배경색을 제어합니다.
	        
				
 		        
	        	if(sessionUserId == userId){
	              	$('#updateForm').css('display','block');
	      							  
				    var inputElement = $('<input>', {
				        'type': 'text',
				        'id': 'u_mntnNm',
				        'name': 'mntnNm',
				        'value': mntnNm,
				        'readonly': true // 읽기 전용으로 설정
				    });

				    // CSS 스타일 설정
				    inputElement.css({
				        'width': '100%',
				        'font-size': '16px', // 원하는 폰트 크기로 조정
				        'font-weight': 'bold', // 볼드체로 설정
				        'text-align': 'center', // 가운데 정렬
				        'background-color': '#333',
				        'color': 'white',
				        'border': 'none',
				        'pointer-events': 'none' // 마우스 이벤트 비활성화
				    });				  
				    
				    $('.u_inputBox').replaceWith(inputElement);
				    
					$('#u_mntnNm').val(mntnNm);				  
					$('#hiddenUdpateBoardId').val(boardId);
	      			$('#u_titleText').val(boardTitle);
	      	    	$('#u_dateInput').val(formattedCdate);
	      	    	$('#u_peeInput').val(participationPee);
	      	    	$('#u_participationInput').val(recQty);
	      	    	$('#u_ctntText').val(ctnt);
		      	    	
		      	    //이미지
	 		        $('#u_rBoardImage').attr('src','<%=request.getContextPath()%>/files/board/'+boardId+'/image.do');
	      							  
	      							  
	          	}else{
	      	    	$('#rboardDetailView').css('display','block');
	          		let appendHtml = `
	      				    		  <button id="participateBtn" class="custom-btn btn-1" type="button"><span>신청하기</span></button>
	      							  <button id="returnBtn" class="custom-btn btn-2" type="button"><span>돌아가기</span></button>
	          						`;
	          		$('#btnDiv').html(appendHtml);
	          		
	          		if (caculate <= 0) {
		        	    $('#participateBtn').addClass('btn-disabled');
		        	}else {
		        		//마감여부 Y로변경
		        	    $('#participateBtn').removeClass('btn-disabled');
		        	}
	          		
	          		//boardId
	 		        $('#hiddenBoardId').val(boardId);
	 		        //제목
	 		        $('#titleInput').val(boardTitle);
	 		        //산 이름
	 		        $('#mntnNmInput').val(mntnNm);
	 		        //참여금액
	 		        $('#peeInputData').val(participationPee);
	 		        //참여인원
	 		        $('#participationInputData').val(recQty);
	 		        //내용
	 		        $('#contentText').val(ctnt);
	 		        //이미지
	 		        $('#rBoardImage').attr('src','<%=request.getContextPath()%>/files/board/'+boardId+'/image.do');
	 		    	//참여일자
	 		        $('#cdateInput').val(formattedCdate);
	 		    	$('#recruitmentInputData').val(recCount);
	          	}
 		    }
 		}); 
    }
    
    
    $('#createForm').on('click',function(){
    	$('#listForm').css('display','none');
    	$('#formView').css('display','block');
    })
    
    $('#cancleBtn').on('click',function(){
    	$('#listForm').css('display','block');
    	$('#formView').css('display','none');
    })
    
    $(document).on('click', '#returnBtn', function() {
    	$('#rboardDetailView').css('display','none');
    	$('#listForm').css('display','block');
	});
    $(document).on('click', '#u_returnBtn', function() {
    	$('#updateForm').css('display','none');
    	$('#listForm').css('display','block');
    });

    $(document).on('click', '#participateBtn', function() {
    	Swal.fire({
    	    title: '참가신청',
    	    text: '참가신청을 하시겠습니까?',
    	    icon: 'question',
    	    showCancelButton: true,
    	    confirmButtonColor: '#3085d6',
    	    cancelButtonColor: '#d33',
    	    confirmButtonText: '확인'
    	}).then((result) => {
    	    if (result.isConfirmed) {
    	        // 확인 버튼이 클릭되었을 때의 동작
    	        let boardId = $('#hiddenBoardId').val();
    	        $.ajax({
    			    url: '<%=request.getContextPath()%>/board/recruitment.do',
    			    method: 'POST',
    			    data:{
    			    	"boardId" : boardId
    			    },
    			    success: function(res) {
    			    	if(res.success){
			    	        Swal.fire('완료!', '참가가 완료되었습니다.', 'success').then((result) => {
			    	            if (result.isConfirmed) {
			    	                window.location.href = '/board/rBoardList.do';
			    	            }
			    	        });
    			    	}else if(res.duplicated){
    			    		Swal.fire({
    							title: "경고!",
    							text: "이미 참여한 모임입니다.",
    							icon: "warning",
    							showCancelButton: true,
    							confirmButtonColor: "#3085d6",
    							cancelButtonColor: "#d33",
    							confirmButtonText: "확인"
    						})
    			    	}
    			    }
    			}); 
    	    }
    	});
    })
    
    $('#rBoardForm').submit(function(event) {
        event.preventDefault();
        
        // FormData 객체를 생성하여 폼 데이터를 담습니다.
        var formData = new FormData($('#rBoardForm')[0]);

        // AJAX를 이용하여 서버로 데이터를 전송합니다.
        $.ajax({
            url: $(this).attr('action'), 
            type: $(this).attr('method'), 
            data: formData,
            processData: false, // 데이터 처리를 jQuery에 맡깁니다.
            contentType: false, // 데이터의 content type을 설정하지 않습니다.
            success: function(res) {
                console.log(res);
                let result = res.success;
                if(result == 'success'){
                    alert('등록이 완료되었습니다.');
                    location.reload();
                } else if(res.errors) {
                    console.log(res.errors);
                    
                    $.each(res.errors, function(key, value) {
                        $("#" + key + "_error").text(value);
                    });
           
                    // 에러가 아닌 span은 숨깁니다.
                    $("span.error").each(function() {
                        var id = $(this).attr("id").replace("_error", "");
                        if (!res.errors[id]) {
                            $(this).hide();
                        } else {
                            $(this).show();
                        }
                    });
                } else {
                    alert('등록이 실패하였습니다.');
                    $('input[type="text"], input[type="number"], textarea').val('');
                }
            },
            error: function(xhr, status, error) {
                console.error('오류:', error);
            }
        });
    });
    
</script>