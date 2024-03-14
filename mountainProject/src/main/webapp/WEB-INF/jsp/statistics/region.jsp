<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#map{
		background-color : white;
	}
</style>

<div id='mapDiv'>
	<div id="map" class="map" style="width:70%;height:80vh;"></div>
</div>

<script>


var map; // 전역 변수로 map을 선언합니다.

function showMap() {
    // 이미 map 객체가 있으면 함수를 종료합니다.
    if (map) {
        return;
    }
	
    map = new ol.Map({
        target: 'map',
        layers: [], // 레이어 없음
        view: new ol.View({
            center: ol.proj.fromLonLat([128.4, 35.7]),
            zoom: 7
        })
    });


    // WFS 소스 생성
	
	var vectorSource = new ol.source.Vector({
    format: new ol.format.GeoJSON(), // ol.format.GeoJSON 사용
    url: function(extent) {
        // WFS GetFeature 요청 URL 생성
        return 'http://localhost:8080/geoserver/cite/wfs' +
            '?service=WFS&' +
            'version=1.1.0&' +
            'request=GetFeature&' +
            'typename=cite:region_statistics_4326&' +  // WFS 레이어 이름
            'outputFormat=application/json&' +
            'srsname=EPSG:3857&' +
            'bbox=' + extent.join(',') + ',EPSG:3857';
    },
    strategy: ol.loadingstrategy.bbox
});


    /* // vectorSource에서 피처 가져오기
    vectorSource.once('change', function() {
        var features = vectorSource.getFeatures();

        // 각 피처의 속성 및 기하정보 출력
        features.forEach(function(feature) {
            var properties = feature.getProperties(); // 피처의 속성 가져오기
            var geometry = feature.getGeometry(); // 피처의 기하정보 가져오기
            console.log('Feature Properties:', properties);
            console.log('Feature Geometry:', geometry);
        });
    }); */
        var minValue = 0; // 가장 밝은 초록색
        var maxValue = 27; // 가장 짙은 초록색
 // 색상 그라데이션을 생성하는 함수
    function getColorGradient(value) {
        // 색상 그라데이션 매핑을 위한 최소값과 최대값 설정
        // 색상 그라데이션 계산
        var ratio = value / maxValue;
        // RGB 색상 계산
        var r = 0;
        var g = Math.round(255 * ratio);
        var b = 0;
        // RGB 값을 16진수로 변환하여 반환
        return '#' + r.toString(16).padStart(2, '0') + g.toString(16).padStart(2, '0') + b.toString(16).padStart(2, '0');
    }

    var style = function(feature) {
        if (!feature) {
            return; // 피처가 없는 경우 함수 종료
        }

        var mountain_s = feature.get('mountain_s'); // mountain_s 속성 가져오기

        // mountain_s 값이 null인 경우
        if (mountain_s === null) {
            return new ol.style.Style({
                fill: new ol.style.Fill({
                    color: 'rgba(255, 255, 255, 0)' // 투명색으로 설정
                }),
                stroke: new ol.style.Stroke({
                    color: 'black', // 피처 경계선 색상을 검은색으로 설정
                    width: 2
                }),
                text: new ol.style.Text({
                    text: feature.get('path'),
                    font: '12px Arial',
                    fill: new ol.style.Fill({
                        color: 'black'
                    })
                })
            });
        }

        // 그라데이션 색상 계산
        var alpha = Math.max(0.1, Math.min(1, mountain_s / 50)); // 알파값 계산
        var fillColor = 'rgba(0, 128, 0, ' + alpha + ')'; // 초록색 그라데이션

        // 스타일 반환
        return new ol.style.Style({
            fill: new ol.style.Fill({
                color: fillColor // 계산된 그라데이션 색상 적용
            }),
            stroke: new ol.style.Stroke({
                color: 'black', // 피처 경계선 색상을 검은색으로 설정
                width: 2
            }),
            text: new ol.style.Text({
                text: feature.get('path'),
                font: '12px Arial',
                fill: new ol.style.Fill({
                    color: 'black'
                })
            })
        });
    };



    console.log(vectorSource);
    var vectorLayer = new ol.layer.Vector({
        source: vectorSource,
        style: style // 위에서 정의한 스타일 함수 적용
    });

   <%--  
	
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
                        text: feature.get('path'),
                        font: '12px Arial',
                        fill: new ol.style.Fill({
                            color: 'black'
                        })
                    })
                }));
                
                let path = feature.get('path');
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
    }); --%>
  
    // 지도에 피처 레이어 추가
    map.addLayer(vectorLayer);
    
}


showMap();
</script>