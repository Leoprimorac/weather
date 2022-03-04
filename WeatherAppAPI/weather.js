var date,
  windDirectionLabel,
  windDirectionValue,
  windSpeedLabel,
  windSpeedValueInMS,
  windSpeedValueInKMH,
  weatherDescription,
  humidityLabel,
  humidityValue,
  temperatureValue,
  pressureValue,
  pressureLabel,
  predictionDateOne,
  predictionDateTwo,
  predictionDateThree,
  predictionDateFour,
  predictionDateOneValueMorning,
  predictionDateOneValueDay,
  predictionDateTwoValueMorning,
  predictionDateTwoValueDay,
  predictionDateThreeValueMorning,
  predictionDateThreeValueDay,
  predictionDateFourValueMorning,
  predictionDateFourValueDay;

function  getData(dom) {
  console.log('ff');
    date = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('p')
      .item(0)
      .textContent;
    windDirectionLabel = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(0)
      .getElementsByTagName('td')
      .item(1)
      .textContent;
    windDirectionValue = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(0)
      .getElementsByTagName('td')
      .item(2)
      .textContent;
    windSpeedLabel = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(0)
      .textContent;
    windSpeedValueInMS = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(1)
      .textContent +
      ' ' +
      dom.window.document
        .getElementsByClassName('post')
        .item(0)
        .getElementsByClassName('tabela')
        .item(0)
        .getElementsByTagName('tr')
        .item(1)
        .getElementsByTagName('td')
        .item(2)
        .textContent;
    windSpeedValueInKMH = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(2)
      .getElementsByTagName('td')
      .item(0)
      .textContent +
      ' ' +
      dom.window.document
        .getElementsByClassName('post')
        .item(0)
        .getElementsByClassName('tabela')
        .item(0)
        .getElementsByTagName('tr')
        .item(2)
        .getElementsByTagName('td')
        .item(1)
        .textContent;
    weatherDescription = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(3)
      .getElementsByTagName('td')
      .item(0)
      .textContent;
    humidityLabel = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(3)
      .getElementsByTagName('td')
      .item(1)
      .textContent;
    humidityValue = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(3)
      .getElementsByTagName('td')
      .item(2)
      .textContent +
      ' ' +
      dom.window.document
        .getElementsByClassName('post')
        .item(0)
        .getElementsByClassName('tabela')
        .item(0)
        .getElementsByTagName('tr')
        .item(3)
        .getElementsByTagName('td')
        .item(3)
        .textContent;
    temperatureValue = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(4)
      .getElementsByTagName('td')
      .item(0)
      .textContent;
    pressureLabel = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(5)
      .getElementsByTagName('td')
      .item(0)
      .textContent;
    pressureValue = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByClassName('tabela')
      .item(0)
      .getElementsByTagName('tr')
      .item(5)
      .getElementsByTagName('td')
      .item(1)
      .textContent +
      ' ' +
      dom.window.document
        .getElementsByClassName('post')
        .item(0)
        .getElementsByClassName('tabela')
        .item(0)
        .getElementsByTagName('tr')
        .item(5)
        .getElementsByTagName('td')
        .item(2)
        .textContent;
    predictionDateOne = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(0)
      .getElementsByTagName('td')
      .item(0)
      .textContent;
  
    predictionDateTwo = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(0)
      .getElementsByTagName('td')
      .item(1)
      .textContent;
    predictionDateThree = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(0)
      .getElementsByTagName('td')
      .item(2)
      .textContent;
    predictionDateFour = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(0)
      .getElementsByTagName('td')
      .item(3)
      .textContent;
    predictionDateOneValueMorning = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(1)
      .textContent;
    predictionDateOneValueDay = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(2)
      .textContent;
  
    predictionDateTwoValueMorning = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(5)
      .textContent;
    predictionDateTwoValueDay = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(6)
      .textContent;
  
    predictionDateThreeValueMorning = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(9)
      .textContent;
    predictionDateThreeValueDay = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(10)
      .textContent;
  
    predictionDateFourValueMorning = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(13)
      .textContent;
    predictionDateFourValueDay = dom.window.document
      .getElementsByClassName('post')
      .item(0)
      .getElementsByTagName('table')
      .item(2)
      .getElementsByTagName('tr')
      .item(1)
      .getElementsByTagName('td')
      .item(14)
      .textContent;
      console.log(predictionDateFour);

      var data = {
        date:date,
        windDirectionLabel:windDirectionLabel,
        windDirectionValue:windDirectionValue,
        windSpeedLabel:windSpeedLabel,
        windSpeedValueInMS:windSpeedValueInMS,
        windSpeedValueInKMH:windSpeedValueInKMH,
        weatherDescription:weatherDescription,
        humidityLabel:humidityLabel,
        humidityValue:humidityValue,
        temperatureValue:temperatureValue,
        pressureValue:pressureValue,
        pressureLabel:pressureLabel,
        predictionDateOne:predictionDateOne,
        predictionDateTwo:predictionDateTwo,
        predictionDateThree:predictionDateThree,
        predictionDateFour:predictionDateFour,
        predictionDateOneValueMorning:predictionDateOneValueMorning,
        predictionDateOneValueDay:predictionDateOneValueDay,
        predictionDateTwoValueMorning:predictionDateTwoValueMorning,
        predictionDateTwoValueDay:predictionDateTwoValueDay,
        predictionDateThreeValueMorning:predictionDateThreeValueMorning,
        predictionDateThreeValueDay:predictionDateThreeValueDay,
        predictionDateFourValueMorning:predictionDateFourValueMorning,
        predictionDateFourValueDay:predictionDateFourValueDay
      }
      return data;
  }
  module.exports = { getData };