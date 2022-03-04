const axios = require("axios");
const Parse = require("parse/node");
const moment = require("moment")
const jsdom = require("jsdom");
const { JSDOM } = jsdom;
const weather = require("./weather")
const database = require("./database")

var response = null;
getMeteoData();

async function getMeteoData() {
   
   try {
      response = await MeteoDal();
      if (response.status == 200 &&  response != null) {
         destructData(response.data);
      } else {
         return getMeteoData();
      }
   } catch (error) {
      //TODO Pozovi ponovno
   }
   
}

async function MeteoDal() {
   try {
      const response = await axios.get('https://www.fhmzbih.gov.ba/latinica/METEO/prognozaMO.php',);
   return response;
   } catch (error) {
      //TODO Pozovi ponovno
   }
   
}

function destructData(html) {
   const dom = new JSDOM(html);
   var weatherData = weather.getData(dom);

   var date = String(weatherData.date).replace('Posljednje mjerenje: ', '');
   date = date.slice(0, date.length - 1);
   date = date.concat(":00:00")

   var dateValue = dateFormatter(date);
   console.log(dateValue)

   var obj = {};
   obj = objectConstruct(weatherData, dateValue);
   if (obj != {}) {
      setDataToDatabase(obj);
   } else {
      //Konsturuiraj objekt
   }
}
function objectConstruct(weatherData, dateValue) {
   var obj = {};
   obj = {
      date: dateValue, windDirectionLabel: weatherData.windDirectionLabel,
      windDirectionValue: weatherData.windDirectionValue,
      windSpeedLabel: weatherData.windSpeedLabel,
      windSpeedValueInMS: weatherData.windSpeedValueInMS,
      windSpeedValueInKMH: weatherData.windSpeedValueInKMH,
      weatherDescription: weatherData.weatherDescription,
      humidityLabel: weatherData.humidityLabel,
      humidityValue: weatherData.humidityValue,
      temperatureValue: weatherData.temperatureValue,
      pressureValue: weatherData.pressureValue,
      pressureLabel: weatherData.pressureLabel,
      predictionDateOne: weatherData.predictionDateOne,
      predictionDateTwo: weatherData.predictionDateTwo,
      predictionDateThree: weatherData.predictionDateThree,
      predictionDateFour: weatherData.predictionDateFour,
      predictionDateOneValueMorning: weatherData.predictionDateOneValueMorning,
      predictionDateOneValueDay: weatherData.predictionDateOneValueDay,
      predictionDateTwoValueMorning: weatherData.predictionDateTwoValueMorning,
      predictionDateTwoValueDay: weatherData.predictionDateTwoValueDay,
      predictionDateThreeValueMorning: weatherData.predictionDateThreeValueMorning,
      predictionDateThreeValueDay: weatherData.predictionDateThreeValueDay,
      predictionDateFourValueMorning: weatherData.predictionDateFourValueMorning,
      predictionDateFourValueDay: weatherData.predictionDateFourValueDay,
   };
   return obj;
}

function setDataToDatabase(weather) {
   Parse.serverURL = 'https://parseapi.back4app.com';
   Parse.initialize('dw0s36y7mlb5mFqQ1Ifou3ykkuFpD9M2F2Cf6M3D', 'Kb8NXBGRXMEyEtspdL4lBHGr7yVL4lJAnuTRn8Gp', 'A6J7gGrLUVGHjhSouNL8QrmxPFr3g86f47Wcu8sW');

   (async () => {
      const myNewObject = new Parse.Object('weather');
      myNewObject.set('date', weather.date);
      myNewObject.set('windDirectionLabel', weather.windDirectionLabel);
      myNewObject.set('windDirectionValue', weather.windDirectionValue);
      myNewObject.set('windSpeedLabel', weather.windSpeedLabel);
      myNewObject.set('windSpeedValueInMS', weather.windSpeedValueInMS);
      myNewObject.set('windSpeedValueInKMH', weather.windSpeedValueInKMH);
      myNewObject.set('weatherDescription', weather.weatherDescription);
      myNewObject.set('humidityLabel', weather.humidityLabel);
      myNewObject.set('humidityValue', weather.humidityValue);
      myNewObject.set('temperatureValue', weather.temperatureValue);
      myNewObject.set('pressureValue', weather.pressureValue);
      myNewObject.set('pressureLabel', weather.pressureLabel);
      myNewObject.set('predictionDateOne', weather.predictionDateOne);
      myNewObject.set('predictionDateTwo', weather.predictionDateTwo);
      myNewObject.set('predictionDateThree', weather.predictionDateThree);
      myNewObject.set('predictionDateFour', weather.predictionDateFour);
      myNewObject.set('predictionDateOneValueMorning', weather.predictionDateOneValueMorning);
      myNewObject.set('predictionDateOneValueDay', weather.predictionDateOneValueDay);
      myNewObject.set('predictionDateTwoValueMorning', weather.predictionDateTwoValueMorning);
      myNewObject.set('predictionDateTwoValueDay', weather.predictionDateTwoValueDay);
      myNewObject.set('predictionDateThreeValueMorning', weather.predictionDateThreeValueMorning);
      myNewObject.set('predictionDateThreeValueDay', weather.predictionDateThreeValueDay);
      myNewObject.set('predictionDateFourValueMorning', weather.predictionDateFourValueMorning);
      myNewObject.set('predictionDateFourValueDay', weather.predictionDateFourValueDay);
      try {
         const result = await myNewObject.save();
         // Access the Parse Object attributes using the .GET method
         console.log('weather created', result);
      } catch (error) {
         //TODO Ponovno pozovi
         console.error('Error while creating weather: ', error);
      }
   })();
}


function dateFormatter(date) {
   const dateArray = date.split('.')
   var hoursArray = dateArray[3].split(':')
   dateArray[3] = hoursArray[0].trim()

   var yearData = parseInt(dateArray[2]);
   var monthData = parseInt(dateArray[1]) - 1;
   var dayData = parseInt(dateArray[0]);
   var hourData = parseInt(dateArray[3]);

   dateData = new Date(yearData, monthData, dayData, hourData, 0, 0, 0)
   return dateData;
}







