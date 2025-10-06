<template>
	<view>
		<view class="gui-flex gui-date-bt-block" 
		:style="{backgroundColor:weekBg}">
			<text class="gui-date-bt-item gui-date-bt-week gui-block-text">一</text>
			<text class="gui-date-bt-item gui-date-bt-week gui-block-text">二</text>
			<text class="gui-date-bt-item gui-date-bt-week gui-block-text">三</text>
			<text class="gui-date-bt-item gui-date-bt-week gui-block-text">四</text>
			<text class="gui-date-bt-item gui-date-bt-week gui-block-text">五</text>
			<text class="gui-date-bt-item gui-date-bt-week gui-block-text">六</text>
			<text class="gui-date-bt-item gui-date-bt-week gui-block-text">日</text>
		</view>
		<view v-for="(days, daysIndex) in daysData" :key="daysIndex">
			<view class="gui-flex gui-date-bt-month-w">
				<text class="gui-date-bt-month gui-block-text" 
				:style="{backgroundColor:startBg}">{{days[0][0]}}{{unit[0]}}{{days[0][1]}}{{unit[1]}}</text>
			</view>
			<view class="gui-flex gui-date-bt-block">
				<text class="gui-date-bt-item gui-date-bt-days" 
				v-for="(item, index) in days[1]" :key="index" 
				:style="{
					backgroundColor:item[1] ? sedBg : itemBg, 
					color:item[1] ? sedColor : color
				}" 
				:data-dt="item[0] == '' ? '' : days[0][0]+''+days[0][1]+''+item[0]" 
				@tap.stop="selectDay">{{item[0]}}<text class="gui-date-bt-start" 
				v-if="sedDays[0] == days[0][0]+''+days[0][1]+''+item[0] || sedDays[1] == days[0][0]+''+days[0][1]+''+item[0]" 
				:style="{
					backgroundColor : sedDays[1] == days[0][0]+''+days[0][1]+''+item[0] ? endBg : startBg, 
					color:sedColor}">{{item[0]}}</text></text>
			</view>
		</view>
	</view>
</template>
<script>
/* 组件百分百原创 拒绝任何代码抄袭及思路抄袭 */
export default{
	name  : "gui-date-between",
	props : {
		weekBg      : { type : String, default:'#F8F8F8'},
		unit        : { type : Array,  default:function(){return [' 年 ',' 月'];}},
		sedBg       : { type : String, default:'rgba(54,136,255,0.8)'},
		itemBg      : { type : String, default:'#FFFFFF'},
		color       : { type : String, default:'#323232'},
		sedColor    : { type : String, default:'#FFFFFF'},
		startBg     : { type : String, default:'rgba(54,136,255,1)'},
		endBg       : { type : String, default:'rgba(54,136,255,1)'},
		monthNumber : { type : Number, default:2}
	},
	data() {
		return {
			sedDays:[0,0],
			btDays :[],
			daysData : []
		}
	},
	created:function(){
		this.setMonth(this.currentMonth());
	},
	methods:{
		setBetween:function(days){
			if(days[1] == 0){days[1] = days[0];}
			days[0]          = Number(days[0]);
			days[1]          = Number(days[1]);
			this.sedDays     = days;
			var countNumber  = 0;
			var daysNew      = [];
			this.daysData.forEach((itm)=>{
				var year     = itm[0][0];
				var month    = itm[0][1];
				var daysIn   = [];
				itm[1].forEach((item)=>{
					var cDay = year+''+month+''+item[0];
					cDay = Number(cDay);
					if(cDay >= days[0] && cDay <= days[1]){
						item[1] = true; 
						countNumber++;
					}else{
						item[1] = false;
					}
					daysIn.push(item);
				});
				daysNew.push([[year, month], daysIn]);
			});
			this.daysData = daysNew;
			this.$emit('selectDate', [days, countNumber]);
		},
		setMonth:function(month){
			var reg = /^([0-9]{4}).*([0-9]{2}).*$/;
			var res = month.match(reg);
			if(res == null){month = this.currentMonth(); res = month.match(reg);}
			this.setMonthBase(res);
		},
		setMonthBase : function(res){
			var daysData = [];
			if(res[2].substr(0,1) == '0'){res[2] = res[2].substr(1);}
			res[1]    = Number(res[1]);
			res[2]    = Number(res[2]);
			var year  = res[1];
			var month = res[2];
			for(let i = 0; i < this.monthNumber; i++){
				var monthIn = month + i;
				var yearIn  = year;
				if(monthIn > 12){monthIn = monthIn - 12; yearIn += 1;}
				if(monthIn < 10){monthIn = '0'+monthIn;}
				daysData[i] = [];
				daysData[i].push([yearIn, monthIn]);
				var days = this.getDays(yearIn,monthIn);
				var daysList  = [];
				for (let ii = (0 - days[1]); ii < days[0]; ii++){
					if(ii >= 0){
						daysList.push([ii >= 9 ? ii + 1 : '0' + (ii+1), false]);
					}else{
						daysList.push(['',false]);
					}
				}
				daysData[i].push(daysList);
			}
			this.daysData = daysData;
		},
		currentMonth : function () {
			var date = new Date();
			var y = date.getFullYear();
			var m = date.getMonth() + 1;
			m = m < 10 ? ('0' + m) : m;
			return y + '年' + m + '月';
		},
		getDays : function(year,month){
			var d         = new Date(year, month, 0);
			var days      = d.getDate();
			var d2        = new Date(year, month - 1, 0);
			var startWeek = d2.getDay();
			return [days, startWeek];
		},
		selectDay:function(e){
			var day = e.currentTarget.dataset.dt;
			if(day == ''){return ;}
			day = Number(day);
			if(this.sedDays[0] == 0){ this.sedDays[0] = day; }
			else if(this.sedDays[1] == 0 || this.sedDays[0] == this.sedDays[1]){
				if(day > this.sedDays[0]){
					this.sedDays[1] = day;
				}else if(day < this.sedDays[0]){
					this.sedDays[1] = this.sedDays[0];
					this.sedDays[0] = day;
				}
			}else{
				this.sedDays[0] = day;
				this.sedDays[1] = 0;
			}
			this.setBetween(this.sedDays);
		}
	}
}
</script>
<style scoped>
.gui-date-bt-block{flex-direction:row; flex-wrap:wrap;}
.gui-date-bt-item{width:98rpx; text-align:center; position:relative;}
.gui-date-bt-week{line-height:80rpx; height:80rpx; font-size:28rpx;}
.gui-date-bt-month-w{flex-direction:row; flex-wrap:nowrap; margin:25px 0;}
.gui-date-bt-month{line-height:50rpx; text-align:center; color:#FFFFFF; width:258rpx; border-radius:30rpx; font-size:26rpx;}
.gui-date-bt-days{line-height:98rpx; height:98rpx; width:98rpx; font-size:28rpx;}
.gui-date-bt-start{position:absolute; font-size:28rpx; font-weight:bold; width:98rpx; height:98rpx; text-align:center; line-height:98rpx; z-index:1; left:0; top:0;}
</style>