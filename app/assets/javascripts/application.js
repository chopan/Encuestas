// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var chart;
$(document).ready(function() {
    chart = new Highcharts.Chart({
        chart: {
                renderTo: 'container',
                defaultSeriesType: 'bar'
        },
        title: {
                text: 'Aplicación de ejemplo'
        },
        subtitle: {
                text: 'Source: <a href="http://www.uach.mx">'+
                        'UACH</a>'
        },
        //xAxis: {
          /*      labels: {
                   formatter: function() {
                       return this.value; // clean, unformatted number for year
                    }
                }
        },
        yAxis: {
                title: {
                        text: 'Promedio'
                },
                labels: {
                        formatter: function() {
                                return this.value / 1000 +'%';
                        }
                }
        },
        tooltip: {
                formatter: function() {
                        return this.series.name +' produced <b>'+
                                Highcharts.numberFormat(this.y, 0) +'</b><br/>warheads in '+ this.x;
                }
        },
        plotOptions: {
                area: {
                        pointStart: 1940,
                        marker: {
                                enabled: false,
                                symbol: 'circle',
                                radius: 2,
                                states: {
                                        hover: {
                                                enabled: true
                                        }
                                }
                        }
                }
        },
        series: [{
                name: 'USA',
                data: [null, null, null, null, null, 6 , 11, 32, 110, 235, 369, 640,
                        1005, 1436, 2063, 3057, 4618, 6444, 9822, 15468, 20434, 24126,
                        27387, 29459, 31056, 31982, 32040, 31233, 29224, 27342, 26662,
                        26956, 27912, 28999, 28965, 27826, 25579, 25722, 24826, 24605,
                        24304, 23464, 23708, 24099, 24357, 24237, 24401, 24344, 23586,
                        22380, 21004, 17287, 14747, 13076, 12555, 12144, 11009, 10950,
                        10871, 10824, 10577, 10527, 10475, 10421, 10358, 10295, 10104 ]
        }, {
                name: 'USSR/Russia',
                data: [null, null, null, null, null, null, null , null , null ,null,
                5, 25, 50, 120, 150, 200, 426, 660, 869, 1060, 1605, 2471, 3322,
                4238, 5221, 6129, 7089, 8339, 9399, 10538, 11643, 13092, 14478,
                15915, 17385, 19055, 21205, 23044, 25393, 27935, 30062, 32049,
                33952, 35804, 37431, 39197, 45000, 43000, 41000, 39000, 37000,
                35000, 33000, 31000, 29000, 27000, 25000, 24000, 23000, 22000,
                21000, 20000, 19000, 18000, 18000, 17000, 16000]
        }]*/
        //------------------------------EJEMPLO BAR-------------------

      xAxis: {
         categories: ['Africa', 'America', 'Asia', 'Europe', 'Oceania'],
         title: {
            text: null
         }
      },
      yAxis: {
         min: 0,
         title: {
            text: 'Population (millions)',
            align: 'high'
         }
      },
      tooltip: {
         formatter: function() {
            return ''+
                this.series.name +': '+ this.y +' millions';
         }
      },
      plotOptions: {
         bar: {
            dataLabels: {
               enabled: true
            }
         }
      },
      legend: {
         layout: 'vertical',
         align: 'right',
         verticalAlign: 'top',
         x: -100,
         y: 100,
         floating: true,
         borderWidth: 1,
         backgroundColor: Highcharts.theme.legendBackgroundColor || '#FFFFFF',
         shadow: true
      },
      credits: {
         enabled: false
      },
           series: [{
         name: 'Year 1800',
         data: [107, 31, 635, 203, 2]
      }, {
         name: 'Year 1900',
         data: [133, 156, 947, 408, 6]
      }, {
         name: 'Year 2008',
         data: [973, 914, 4054, 732, 34]
      }]
    });

});



