<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Stats Page</title>
    <style>
        body {
            background-color: #000000;
            color: #ffffff;
            font-family: Nanum Gothic;
        }
        .stats-content-container {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            gap: 60px;
            width: 80%;
            max-width: 1200px;
            margin: 50px auto;
        }
        .chart-container {
            width: 60%;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .stats-comment-container {
            width: 30%;
            background-color: #1e1e1e;
            padding: 20px;
            border-radius: 10px;
            color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            font-size: 16px;
            line-height: 1.5;
        }
    </style>
    <tiles:insertAttribute name="header_main" />
</head>
<body>
	<sec:authorize access="isAuthenticated()">
		<meta name="_csrf" content="${_csrf.token}"/>
		<meta name="_csrf_header" content="${_csrf.headerName}"/>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<sec:authentication property="principal.member" var="member"/>
		
		<script type="text/javascript">
		    const member = {
		    	seq: '${member.seq}',
		    	id: '${member.id}',
		    	nick: '${member.nick}'
		    };
		</script>
	</sec:authorize>
	
	<tiles:insertAttribute name="asset_main" />
    <h1 style="text-align: center;">My ChatBot 통계</h1>

    <div class="stats-content-container">
        <div class="chart-container">
            <canvas id="myChart"></canvas>
        </div>

        <div class="stats-comment-container">
            <h3>차트 요약</h3>
            <p></p>
        </div>
    </div>    

	<tiles:insertAttribute name="asset_bot" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
    <script>
	    const seq = '<%= request.getParameter("seq") %>';
	    
	    $.ajax({
	        url: '/editor/statsData',
	        type: 'GET',
	        data: { seq: seq },
	        success: function(response) {
	            const statsData = response.statsData;
	            console.log(statsData);
	            
	            let monthlyCounts = Array(12).fill(0);

	            // statsData에 따라 각 월별 데이터 채우기
	            statsData.forEach(data => {
	                let monthIndex = parseInt(data.month) - 1;
	                monthlyCounts[monthIndex] = data.count || 0;
	            });

	            // 현재 월을 가져와 그동안의 데이터 평균과 비교용 데이터를 계산
	            const currentMonth = new Date().getMonth() + 1;
	            const totalSoFar = monthlyCounts.slice(0, currentMonth).reduce((sum, count) => sum + count, 0);
	            const averageSoFar = totalSoFar / currentMonth;

	            // 저번 달 데이터와 비교 (단, 1월이면 이전 달 비교 불가)
	            const previousMonthCount = currentMonth > 1 ? monthlyCounts[currentMonth - 2] : 0;
	            const currentMonthCount = monthlyCounts[currentMonth - 1];
	            const difference = currentMonthCount - previousMonthCount;
	            
	            // 결과 정보를 DOM에 추가
	            const summaryText = `
				    <p>
				        이번 달 (<span style="color: tomato;">${currentMonth}월</span>) 과 지난 달의 차이는 
				        <span style="color: tomato;">${difference}</span> 건입니다.<br>
				        월별 평균 통계는 약 <span style="color: tomato;">${averageSoFar.toFixed(2)}</span> 건입니다.
				    </p>
				`;
	            document.querySelector('.stats-comment-container p').innerHTML = summaryText;

	            // 차트 생성
	            const ctx = document.getElementById('myChart').getContext('2d');
	            const myChart = new Chart(ctx, {
	                type: 'bar',
	                data: {
	                    labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
	                    datasets: [{
	                        label: 'Dataset',
	                        data: monthlyCounts,
	                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
	                        borderColor: 'rgba(75, 192, 192, 1)',
	                        borderWidth: 1
	                    }]
	                },
	                options: {
	                    responsive: true,
	                    scales: {
	                        y: {
	                            beginAtZero: true
	                        }
	                    }
	                }
	            });
	        },
	        error: function() {
	            console.error("데이터를 불러오는 데 실패했습니다.");
	        }
	    });
	</script>
</body>
</html>
