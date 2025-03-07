<script lang="ts" setup>
// import { Calendar } from '@element-plus/icons-vue'
// import { useUser } from "@/hooks/useUser";
//  按需引入 echarts
import dayjs from "dayjs";
import * as echarts from "echarts";
import { wrapperEnv } from '@/utils/env'

const { VITE_WEB_ENV } = wrapperEnv

const main = ref() // 使用ref创建虚拟DOM引用，使用时用main.value
let myChart = null
const startDate = ref('')
const endDate = ref('')

const selectDate = ref('')
const selectDateInterval = ref(0)
const dateInterval = ref([
    {
        name: '6 month',
        number: 6,
        target: 'month'
    },
    {
        name: '1 Year',
        number: 1,
        target: 'year'
    },
    {
        name: '2 years',
        number: 2,
        target: 'year'
    }
])

const selectData = ref(0)
const webColor = VITE_WEB_ENV === 'bhg' ? '#BE9670' : '#AD262F'

const dataList = ref([
    {
        name: 'Total Investment',
        text: 'Investment amount',
        key: 'totalInvestment',
        color: webColor
    },
    {
        name: 'Client number',
        text: 'Client number',
        key: 'clientNum',
        color: webColor
    },
    {
        name: 'Investment Return',
        text: 'Investment Return',
        key: 'investmentReturn',
        color: webColor
    }
])

const chartInfo = reactive({
    title: "",
    xAxisDate: [],
    series: [],
    color: ''
})

onMounted(
    () => {
        startDate.value = dayjs(new Date()).startOf("month").subtract(6, 'month').format("YYYY-MM-DD")
        endDate.value = dayjs(new Date()).format("YYYY-MM-DD")
        console.log(startDate.value, endDate.value)
        qetInvestment()
    }
)

function init() {
    // 基于准备好的dom，初始化echarts实例
    myChart = echarts.init(main.value);
    // 指定图表的配置项和数据
    let option = {
        title: {
            text: chartInfo.title
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: [chartInfo.title],
            left: '10%',
            bottom: 0
        },
        xAxis: {
            type: 'category',
            data: chartInfo.xAxisDate
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                name: chartInfo.title,
                data: chartInfo.series,
                type: 'line',
                color: chartInfo.color,
                lineStyle: {
                    color: chartInfo.color // 设置线的颜色为红色
                }
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
}

async function qetInvestment() {
    let params = {
        startDate: startDate.value,
        endDate: endDate.value
    }
    const [e, r] = await api.queryDashboardInvestment(params)
    if (!e && r) {
        console.log(r.data);
        if (r?.data && r?.data.length > 0) {
            chartInfo.title = dataList.value[selectData.value].text
            chartInfo.color = dataList.value[selectData.value].color
            const date = []
            const data = []
            for (let i = 0; i < r.data.length; i++) {
                date.push(r.data[i].dateStr)
                data.push(r.data[i][dataList.value[selectData.value].key])
            }
            chartInfo.xAxisDate = date
            chartInfo.series = data
            if (myChart) {
                echarts.dispose(myChart)
                myChart = null
            }
            init()
        }
    } else {
        console.log(e);
    }

}

const handleChooseDate = (item, index) => {
    selectDateInterval.value = index
    startDate.value = dayjs(new Date()).startOf("month").subtract(item.number, item.target).format("YYYY-MM-DD")
    endDate.value = dayjs(new Date()).format("YYYY-MM-DD")
    qetInvestment()
    selectDate.value = ''
}

const handleChooseData = (item, index) => {
    selectData.value = index
    qetInvestment()
}

const handleSelectDate = () => {
    if (selectDate.value) {
        selectDateInterval.value = null
        startDate.value = selectDate.value[0]
        endDate.value = selectDate.value[1]
        qetInvestment()
    }
}

</script>

<template>
    <div class="chart-box">
        <div class="top">
            <div class="title">Investment</div>
            <div class="date">
                <div :class="selectDateInterval === index ? 'item act' : 'item'" v-for="(item, index) in dateInterval"
                    :key="index" @click="handleChooseDate(item, index)">{{ item.name }}</div>
                <div class="item-icon pointer">
                    <el-date-picker v-model="selectDate" type="daterange" range-separator="To"
                        start-placeholder="Start date" end-placeholder="End date" value-format="YYYY-MM-DD"
                        format="YYYY-MM-DD" @change="handleSelectDate" />
                </div>
            </div>
        </div>
        <div class="data-list">
            <div></div>
            <div class="list">
                <div :class="selectData === index ? 'item act' : 'item'" v-for="(item, index) in dataList" :key="index"
                    @click="handleChooseData(item, index)">{{ item.name }}</div>
            </div>
        </div>
        <div ref="main" style="width: 100%; height: 450px"></div>
    </div>
</template>

<style lang="scss" scoped>
.chart-box {
    width: 100%;
    height: 612px;
    border-radius: 8px;
    background: #FFF;
    box-shadow: 0px 1px 1px 0px rgba(0, 0, 0, 0.08), 0px 2px 1px 0px rgba(0, 0, 0, 0.06), 0px 1px 3px 0px rgba(0, 0, 0, 0.10);
    padding: 40px 24px;

    .top {
        display: flex;
        justify-content: space-between;
        align-items: center;

        .title {
            color: #1C1C1C;
            font-size: 24px;
            font-style: normal;
            font-weight: 700;
        }

        .date {
            display: flex;
            align-items: center;

            .item {
                color: #000;
                font-size: 12px;
                font-style: normal;
                font-weight: 500;
                position: relative;
                cursor: pointer;
            }

            .item+.item {
                margin-left: 32px;
            }

            .item.act::after {
                content: "";
                width: 100%;
                height: 2px;
                position: absolute;
                left: 0;
                bottom: -4px;
                background: $web-color;
            }

            .item-icon {
                margin-left: 32px;
            }
        }
    }

    .data-list {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 16px 0 20px;

        .list {
            display: flex;
            align-items: center;

            .item {
                padding: 4px 8px;
                border-radius: 8px;
                border: 1px solid #E8E8E8;
                background: #FFF;
                box-shadow: 0px 1px 1px 0px rgba(0, 0, 0, 0.06);
                cursor: pointer;
            }

            .item+.item {
                margin-left: 9px;
            }

            .item.act {
                background: $web-color;
                color: #fff;
            }
        }
    }
}
</style>
