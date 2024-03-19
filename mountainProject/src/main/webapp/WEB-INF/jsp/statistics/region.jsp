<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#map{
		background-color : white;
	}
	#mapDiv{
		display: flex;
	    align-content: center;
	    justify-content: center;
	    margin-top: 1%;
	}
	#regionInfo{
		background-color: green;
		width : 20%;
		height : 72vh;
		display: flex;
    	justify-content: center;
	}
	#headerInfo{
	    display: flex;
 	    justify-content: center;
    	margin-top: 6%;
	}
	#regionBody td {
	    text-align: center;
	}
	#regionTable{
		width : 100%;
	}
</style>
<div id="headerInfo">
	<h1>지역별 모임이 많은 통계</h1>
	
</div>
<div id='mapDiv'>
	<div id="map" class="map" style="width:50%;height:72vh;"></div>
	<div id = regionInfo>
	<div>
		<h2>모임이 많은 지역 순위</h2>
		<table id="regionTable">
			<thead>
				<tr>
					<th>지역</th>
					<th>등산횟수</th>
				</tr>
			</thead>
			<tbody id="regionBody">
				
			</tbody>
		</table>
	</div>
	</div>
</div>

<script>


	var map; // 전역 변수로 map을 선언합니다.
	var flag = 0;
	
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
	
	    var minValue = 0; // 가장 밝은 초록색
	    var maxValue = 27; // 가장 짙은 초록색
	
	
	    var style = function(feature) {
	    	flag++;
	    	
	        if (!feature) {
	            return; // 피처가 없는 경우 함수 종료
	        }
	
	        var mountain_nm = feature.get('name'); // name 속성 가져오기
	        var mountain_s = feature.get('mountain_s'); // mountain_s 속성 가져오기
	        
	        createListTag(mountain_s, mountain_nm);
	        
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
	                    text: mountain_nm+"\n(0)", // 피처의 이름을 텍스트로 설정
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
	                text: mountain_nm+"\n("+mountain_s+")", // 피처의 이름을 텍스트로 설정
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
	    
	    // 지도에 피처 레이어 추가
	    map.addLayer(vectorLayer);
	}
	function createListTag(count, name){
		if(flag<=17){
			let tempHtml = '<tr>' +
						    '<td>' + name + '</td>' +
						    '<td>' + (count !== null ? count : "0") + '</td>' +
						    '</tr>';
	
			
			$('#regionBody').append(tempHtml);
		}
	}



//화면 출력
showMap();
</script>