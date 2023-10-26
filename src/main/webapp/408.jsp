<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>MyECommerceSite | 408 Error</title>
<!-- Imports -->
<%@include file="components/imports.jsp"%>
<style>
html {
	box-sizing: border-box;
}

*, *:before, *:after {
	box-sizing: inherit;
}

* {
	position: absolute;
}

*:before, *:after {
	content: "";
	position: absolute;
}

html, body {
	width: 100vw;
	height: 100vh;
	margin: 0;
}

body {
	background: #f5f9ff;
}

body .status-wrapper {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	max-height: 500px;
	height: 95vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

@media ( max-width : 767px) {
	body .status-wrapper {
		top: 45%;
		height: 75vh;
	}
}

body .messages {
	top: 0;
	width: 45vw;
	text-align: center;
	font-size: 1rem;
	color: #fff;
	background-color: #21a8ff;
	border-radius: 5px;
	text-align: left;
	padding: 0rem 1rem;
	margin-bottom: 20px;
	font-weight: bold;
}

@media ( max-width : 767px) {
	body .messages {
		width: 90vw;
		font-size: 0.75rem;
	}
}

body .messages.bottom {
	top: auto;
	bottom: -20px;
	background-color: #f0eff0;
	color: #243966;
	opacity: 1;
	-webkit-animation: on-finish 6.5s linear;
	animation: on-finish 6.5s linear;
}

body .messages p {
	position: relative;
}

body .number {
	position: relative;
	font-size: 15rem;
	color: #ff6882;
	text-shadow: 2px 2px 2px #243966;
	opacity: 1;
	-webkit-animation: on-finish 6s linear;
	animation: on-finish 6s linear;
}

@media ( max-width : 767px) {
	body .number {
		font-size: 7.5rem;
	}
}

body .timer-container {
	width: 270px;
	height: 270px;
	min-width: 270px;
	min-height: 270px;
	position: relative;
	z-index: 2;
	-webkit-animation: shake 4.5s linear 4.6s;
	animation: shake 4.5s linear 4.6s;
}

@media ( max-width : 767px) {
	body .timer-container {
		width: 150px;
		height: 150px;
		min-width: 150px;
		min-height: 150px;
	}
}

body .timer-container .exclamation-marks {
	width: 100%;
	height: 50%;
	top: -10px;
}

body .timer-container .exclamation-marks .exclamation {
	width: 55px;
	height: 9px;
	border-radius: 25px;
	background: #243966;
	opacity: 1;
	-webkit-animation: on-finish 6s linear;
	animation: on-finish 6s linear;
}

@media ( max-width : 767px) {
	body .timer-container .exclamation-marks .exclamation {
		width: 20px;
		height: 5px;
	}
}

body .timer-container .exclamation-marks .exclamation:nth-child(1) {
	bottom: 25%;
	left: -25px;
	transform: translate(-50%, 0) rotate(20deg);
}

body .timer-container .exclamation-marks .exclamation:nth-child(2) {
	top: 25%;
	left: 10%;
	width: 40px;
	transform: translate(-50%, -50%) rotate(45deg);
}

@media ( max-width : 767px) {
	body .timer-container .exclamation-marks .exclamation:nth-child(2) {
		width: 20px;
	}
}

body .timer-container .exclamation-marks .exclamation:nth-child(2)::before
	{
	bottom: 0;
	right: -15px;
	width: 10px;
	height: 10px;
	border-radius: 100%;
	background-color: #243966;
}

@media ( max-width : 767px) {
	body .timer-container .exclamation-marks .exclamation:nth-child(2)::before
		{
		width: 5px;
		height: 5px;
	}
}

body .timer-container .exclamation-marks .exclamation:nth-child(3) {
	left: 90%;
	top: 25%;
	transform: translate(-50%, -50%) rotate(-45deg);
}

body .timer-container .exclamation-marks .exclamation:nth-child(4) {
	bottom: 25%;
	right: -25px;
	width: 40px;
	transform: translate(50%, 0) rotate(-20deg);
}

@media ( max-width : 767px) {
	body .timer-container .exclamation-marks .exclamation:nth-child(4) {
		width: 20px;
	}
}

body .timer-container .exclamation-marks .exclamation:nth-child(4)::before
	{
	bottom: 0;
	left: -15px;
	width: 10px;
	height: 10px;
	border-radius: 100%;
	background-color: #243966;
}

@media ( max-width : 767px) {
	body .timer-container .exclamation-marks .exclamation:nth-child(4)::before
		{
		width: 5px;
		height: 5px;
	}
}

body .timer-container .timer {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 100%;
	height: 100%;
	text-align: center;
}

body .timer-container .timer .handle-group {
	left: 0;
	right: 0;
	margin: 0 auto;
	width: 45%;
	height: 25%;
}

body .timer-container .timer .handle-group .handle {
	position: absolute;
	left: 50%;
	top: -6px;
	transform: translate(-50%, 0);
	width: 65%;
	height: 100%;
	border: 10px solid #243966;
	background: transparent;
	border-top-left-radius: 50px 50px;
	border-top-right-radius: 50px 50px;
	border-bottom-left-radius: 40px 35px;
	border-bottom-right-radius: 40px 35px;
	overflow: hidden;
}

@media ( max-width : 767px) {
	body .timer-container .timer .handle-group .handle {
		border-width: 6px;
	}
}

body .timer-container .timer .handle-group .handle .border {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 100%;
	height: 100%;
	background-color: #21a8ff;
	overflow: hidden;
}

body .timer-container .timer .handle-group .handle .border::before {
	background: #56d4f2;
	top: 0;
	left: -15%;
	width: 85%;
	height: 50%;
	border-radius: 100%;
	transform: rotate(-55deg);
}

body .timer-container .timer .handle-group .handle .border::after {
	background: #1990ff;
	bottom: -10%;
	right: -35%;
	width: 100%;
	height: 50%;
	border-radius: 100%;
	transform: rotate(-20deg);
	z-index: 0;
}

body .timer-container .timer .handle-group .handle .border .inner {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 70%;
	height: 70%;
	background-color: white;
	border: 10px solid #243966;
	border-top-left-radius: 40px 40px;
	border-top-right-radius: 40px 40px;
	border-bottom-left-radius: 35px 30px;
	border-bottom-right-radius: 35px 30px;
	z-index: 1;
}

@media ( max-width : 767px) {
	body .timer-container .timer .handle-group .handle .border .inner {
		border-width: 6px;
	}
}

body .timer-container .timer .handle-group .base {
	left: 0;
	right: 0;
	bottom: -23%;
	margin: 0 auto;
	height: 80%;
	width: 35%;
	background: #21a8ff;
	border: 10px solid #243966;
	border-radius: 50px;
}

@media ( max-width : 767px) {
	body .timer-container .timer .handle-group .base {
		border-width: 6px;
	}
}

body .timer-container .timer .handle-group .base::before {
	top: 20%;
	left: 37%;
	width: 50%;
	height: 25%;
	border-radius: 100%;
	background-color: #56d4f2;
	transform: translate(-50%, -50%) rotate(-35deg);
}

body .timer-container .timer .body {
	left: 0;
	right: 0;
	bottom: 0;
	margin: 0 auto;
	width: 80%;
	height: 80%;
	border-radius: 100%;
	z-index: 2;
}

body .timer-container .timer .body .button-group {
	width: 25%;
	height: 25%;
	right: 10px;
	top: -10%;
	z-index: 0;
	transform: rotate(40deg);
	-webkit-animation: button 5s linear;
	animation: button 5s linear;
}

body .timer-container .timer .body .button-group .base {
	bottom: 0;
	left: 0;
	right: 0;
	margin: 0 auto;
	width: 55%;
	height: 50%;
	border: 10px solid #243966;
	background: #1990ff;
}

@media ( max-width : 767px) {
	body .timer-container .timer .body .button-group .base {
		border-width: 6px;
	}
}

body .timer-container .timer .body .button-group .button {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	top: 47%;
	height: 50%;
	width: 100%;
	border-radius: 25px;
	border: 10px solid #243966;
	background: #56d4f2;
	background: linear-gradient(90deg, #56d4f2 50%, #21a8ff 50%);
	overflow: hidden;
}

@media ( max-width : 767px) {
	body .timer-container .timer .body .button-group .button {
		border-width: 6px;
	}
}

body .timer-container .timer .body .button-group .button::before {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 50%;
	height: 150%;
	border-left: 6px solid #243966;
	border-right: 6px solid #243966;
	background: #21a8ff;
}

@media ( max-width : 767px) {
	body .timer-container .timer .body .button-group .button::before {
		border-width: 3px;
	}
}

body .timer-container .timer .body .border {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 100%;
	height: 100%;
	border-radius: 100%;
	background-color: #ff5e7a;
	border: 10px solid #243966;
	overflow: hidden;
}

@media ( max-width : 767px) {
	body .timer-container .timer .body .border {
		border-width: 6px;
	}
}

body .timer-container .timer .body .border::before {
	background: #ffa9aa;
	top: 0;
	left: -25%;
	width: 85%;
	height: 50%;
	border-radius: 100%;
	transform: rotate(-45deg);
}

body .timer-container .timer .body .border::after {
	background: #fe3074;
	bottom: -10%;
	right: -25%;
	width: 75%;
	height: 50%;
	border-radius: 100%;
	transform: rotate(-45deg);
	z-index: 0;
}

body .timer-container .timer .body .border .inner-body-group {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 85%;
	height: 85%;
	border-radius: 100%;
	z-index: 2;
	border: 10px solid #243966;
}

@media ( max-width : 767px) {
	body .timer-container .timer .body .border .inner-body-group {
		border-width: 6px;
	}
}

body .timer-container .timer .body .border .inner-body-group .border-gap
	{
	top: 75%;
	left: 3%;
	width: 30px;
	height: 30px;
	border-radius: 100%;
	background: #ff5e7a;
	background: linear-gradient(90deg, #ff5e7a 50%, #daf2ff 50%);
	border: 1px solid red;
	z-index: 3;
	transform: translate(-50%, -50%);
}

body .timer-container .timer .body .border .inner-body-group .border-gap::before
	{
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 12px;
	height: 12px;
	border-radius: 100%;
	background-color: orange;
}

body .timer-container .timer .body .border .inner-body {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 100%;
	height: 100%;
	border-radius: 100%;
	background-color: #cde8ff;
	overflow: hidden;
}

body .timer-container .timer .body .border .inner-body::before {
	width: 125%;
	height: 100%;
	left: -25%;
	top: -15%;
	border-radius: 100%;
	background-color: #daf2ff;
	transform: rotate(-55deg);
}

body .timer-container .timer .body .border .inner-body .reflection {
	width: 100%;
	height: 100%;
}

body .timer-container .timer .body .border .inner-body .reflection::before
	{
	top: 30%;
	left: 30%;
	width: 45%;
	height: 30%;
	border-radius: 100%;
	background-color: #f5feff;
	transform: translate(-50%, -50%) rotate(-45deg);
}

body .timer-container .timer .body .border .inner-body .reflection::after
	{
	top: 55%;
	left: 10%;
	width: 12%;
	height: 12%;
	border-radius: 100%;
	background-color: #f5feff;
}

body .timer-container .timer .body .border .inner-body .hours {
	left: 0;
	right: 0;
	width: 100%;
	height: 100%;
	border-radius: 100%;
}

body .timer-container .timer .body .border .inner-body .hours .hour {
	height: 10%;
	width: 5%;
	left: 50%;
	top: 10%;
	border-radius: 10px;
	background-color: #243966;
	transform: translate(-50%, -50%);
}

body .timer-container .timer .body .border .inner-body .hours .hour:nth-child(2)
	{
	transform: translate(-50%, -50%) rotate(45deg);
	top: 25%;
	left: 80%;
}

body .timer-container .timer .body .border .inner-body .hours .hour:nth-child(3)
	{
	transform: translate(-50%, -50%) rotate(90deg);
	top: 50%;
	left: 90%;
}

body .timer-container .timer .body .border .inner-body .hours .hour:nth-child(4)
	{
	transform: translate(-50%, -50%) rotate(135deg);
	top: 75%;
	left: 80%;
}

body .timer-container .timer .body .border .inner-body .hours .hour:nth-child(5)
	{
	transform: translate(-50%, -50%) rotate(180deg);
	top: 90%;
	left: 50%;
}

body .timer-container .timer .body .border .inner-body .hours .hour:nth-child(6)
	{
	transform: translate(-50%, -50%) rotate(225deg);
	top: 75%;
	left: 20%;
}

body .timer-container .timer .body .border .inner-body .hours .hour:nth-child(7)
	{
	transform: translate(-50%, -50%) rotate(270deg);
	top: 50%;
	left: 10%;
}

body .timer-container .timer .body .border .inner-body .hours .hour:nth-child(8)
	{
	transform: translate(-50%, -50%) rotate(315deg);
	top: 25%;
	left: 20%;
}

body .timer-container .timer .body .border .inner-body .hand {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 20%;
	height: 20%;
	max-width: 35px;
	max-height: 35px;
	border-radius: 100%;
	background-color: #243966;
	transform: translate(-50%, -50%) rotate(-75deg);
	z-index: 1;
	-webkit-animation: tick 3.5s linear 1s;
	animation: tick 3.5s linear 1s;
}

body .timer-container .timer .body .border .inner-body .hand::before,
	body .timer-container .timer .body .border .inner-body .hand::after {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	left: 100%;
	height: 10px;
	width: 85px;
	background-color: #243966;
	border-radius: 25px;
	z-index: 0;
}

@media ( max-width : 767px) {
	body .timer-container .timer .body .border .inner-body .hand::before,
		body .timer-container .timer .body .border .inner-body .hand::after {
		width: 40px;
		height: 5px;
	}
}

body .timer-container .timer .body .border .inner-body .hand::after {
	left: 0%;
	width: 20px;
}

body .timer-container .timer .body .border .inner-body .hand .center {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 45%;
	height: 45%;
	border-radius: 100%;
	background-color: #21a8ff;
	z-index: 3;
}

@
-webkit-keyframes tick { 0% {
	transform: translate(-50%, -50%) rotate(-75deg);
}

100




%
{
transform




:




translate


(




-50


%
,
-50


%
)




rotate


(




285deg




)


;
}
}
@
keyframes tick { 0% {
	transform: translate(-50%, -50%) rotate(-75deg);
}

100




%
{
transform




:




translate


(




-50


%
,
-50


%
)




rotate


(




285deg




)


;
}
}
@
-webkit-keyframes button { 5%, 15% {
	transform: translateY(0) rotate(40deg);
}

10




%
{
transform




:




translateY


(




5px




)




translateX


(




-3px




)




rotate


(




40deg




)


;
}
}
@
keyframes button { 5%, 15% {
	transform: translateY(0) rotate(40deg);
}

10




%
{
transform




:




translateY


(




5px




)




translateX


(




-3px




)




rotate


(




40deg




)


;
}
}
@
-webkit-keyframes on-finish { 0% {
	opacity: 0;
}

95




%
{
opacity




:




0


;
}
100




%
{
opacity




:




1


;
}
}
@
keyframes on-finish { 0% {
	opacity: 0;
}

95




%
{
opacity




:




0


;
}
100




%
{
opacity




:




1


;
}
}
@
-webkit-keyframes shake { 1% {
	transform: rotateZ(15deg);
	transform-origin: 50% 0%;
}

3




%
{
transform




:




rotateZ


(




-15deg




)


;
transform-origin




:




50


%
0


%;
}
6




%
{
transform




:




rotateZ


(




20deg




)


;
transform-origin




:




50


%
0


%;
}
9




%
{
transform




:




rotateZ


(




-20deg




)


;
transform-origin




:




50


%
0


%;
}
12




%
{
transform




:




rotateZ


(




15deg




)


;
transform-origin




:




50


%
0


%;
}
15




%
{
transform




:




rotateZ


(




-15deg




)


;
transform-origin




:




50


%
0


%;
}
18




%
{
transform




:




rotateZ


(




0




)


;
transform-origin




:




50


%
0


%;
}
100




%
{
transform




:




rotateZ


(




0




)


;
transform-origin




:




50


%
0


%;
}
}
@
keyframes shake { 1% {
	transform: rotateZ(15deg);
	transform-origin: 50% 0%;
}
3




%
{
transform




:




rotateZ


(




-15deg




)


;
transform-origin




:




50


%
0


%;
}
6




%
{
transform




:




rotateZ


(




20deg




)


;
transform-origin




:




50


%
0


%;
}
9




%
{
transform




:




rotateZ


(




-20deg




)


;
transform-origin




:




50


%
0


%;
}
12




%
{
transform




:




rotateZ


(




15deg




)


;
transform-origin




:




50


%
0


%;
}
15




%
{
transform




:




rotateZ


(




-15deg




)


;
transform-origin




:




50


%
0


%;
}
18




%
{
transform




:




rotateZ


(




0




)


;
transform-origin




:




50


%
0


%;
}
100




%
{
transform




:




rotateZ


(




0




)


;
transform-origin




:




50


%
0


%;
}
}
</style>
</head>
<body>


	<div class="status-wrapper">
		<div class="number">4</div>
		<div class="timer-container">
			<div class="exclamation-marks">
				<div class="exclamation"></div>
				<div class="exclamation"></div>
				<div class="exclamation"></div>
				<div class="exclamation"></div>
			</div>
			<div class="timer">
				<div class="handle-group">
					<div class="handle">
						<div class="border">
							<div class="inner"></div>
						</div>
					</div>
					<div class="base"></div>
				</div>
				<div class="body">
					<div class="button-group">
						<div class="base"></div>
						<div class="button"></div>
					</div>
					<div class="border">
						<div class="inner-body-group">
							<div class="border-gaps"></div>
							<div class="inner-body">
								<div class="reflection"></div>
								<div class="hours">
									<div class="hour"></div>
									<div class="hour"></div>
									<div class="hour"></div>
									<div class="hour"></div>
									<div class="hour"></div>
									<div class="hour"></div>
									<div class="hour"></div>
									<div class="hour"></div>
								</div>
								<div class="hand">
									<div class="center"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="number last">8</div>
		<div class="messages bottom">
			<p class="server p-2 text-center">Request time Out</p>
		</div>
	</div>
</body>
</html>