#include "DHT.h"

//Sensor de luminosidade LDR
int sensorLum = A1;            //Pino analógico em que o sensor de luminosidade está conectado.

//sensor de temperatura e umidade
#define DHTPIN A0              //Pino analogico em que o sensor DHT11 esta conectado
#define DHTTYPE DHT11          //Definindo o tipo do sensor: DHT11
DHT dht(DHTPIN, DHTTYPE);

//Função setup, executado uma vez ao ligar o Arduino.
void setup(){
  //Ativando o serial monitor que eexxibirá os valores lidos no sensor.
  Serial.begin(115200);
  //Iniciando o dht11
  dht.begin();

}

//Função loop, executado enquanto o Arduino estiver ligado.
void loop(){
  //valor da luminosidade.
  float valorSensorLum = analogRead(sensorLum);
  //Valor da Umidade
  float valorSensorUmi = dht.readHumidity();
  //Valor da temperatura
  float valorSensorTemp = dht.readTemperature();

  //Checando alguma falha
  if (isnan(valorSensorUmi) || isnan(valorSensorTemp)) {
    Serial.println("Falha ao ler do DHT11!");
    return;
  }

  //Espera 1 seg para realizar a proxima leitura
  delay(1000);  

  //Imprimir os valores
  Serial.print("Luminosidade: "); 
  Serial.print(valorSensorLum);
  Serial.print("           ");
  Serial.print("Umidade: "); 
  Serial.print(valorSensorUmi);
  Serial.print("%            ");
  Serial.print("Temperatura: "); 
  Serial.print(valorSensorTemp);
  Serial.println(" *C ");
}


