<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Stats Page</title>
    <tiles:insertAttribute name="asset_main" />
    <style>
        body {
            background-color: #000000;
            color: #ffffff;
            font-family: Arial, sans-serif;
        }
        .content-container {
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
        .comment-container {
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
</head>
<body>
    <tiles:insertAttribute name="header_main" />

    <h1 style="text-align: center;">My ChatBot 통계</h1>

    <div class="content-container">
        <div class="chart-container">
            <canvas id="myChart"></canvas>
        </div>

        <div class="comment-container">
            <h3>차트 요약</h3>
            <p>이 차트는 2024년 월별 챗봇 이용 횟수를 나타냅니다. 8월에 가장 많이 사용하였으며 이번달은 지난 대비 -50 건입니다</p>
        </div>
    </div>
    

	<tiles:insertAttribute name="asset_bot" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
    <script>
        const ctx = document.getElementById('myChart').getContext('2d');
        const myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
                datasets: [{
                    label: 'Dataset',
                    data: [10, 20, 25, 35, 23, 65, 42, 85, 52, 62, 13, 0],
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
    </script>
</body>
</html>