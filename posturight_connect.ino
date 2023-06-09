#include <ArduinoBLE.h>
#include <Arduino_LSM6DS3.h>

#define ALPHA 0.3

//----------------------------------------------------------------------------------------------------------------------
// BLE UUIDS
//----------------------------------------------------------------------------------------------------------------------

#define BLE_UUID_IMU_SERVICE                "1101"
#define BLE_UUID_ACC_X_CHAR                 "2101"
#define BLE_UUID_ACC_Y_CHAR                 "2102"
#define BLE_UUID_ACC_Z_CHAR                 "2103"
#define BLE_UUID_GYRO_X_CHAR                "2104"
#define BLE_UUID_GYRO_Y_CHAR                "2105"
#define BLE_UUID_GYRO_Z_CHAR                "2106"
#define BLE_UUID_ANGLE_CHAR                 "2107"

//----------------------------------------------------------------------------------------------------------------------
// APP & I/O
//----------------------------------------------------------------------------------------------------------------------

#define ACC_SENSOR_UPDATE_INTERVAL (500)
#define GYRO_SENSOR_UPDATE_INTERVAL (500)

float last_accX = 0.0;
float last_accY = 0.0;
float last_accZ = 0.0;
float last_gyrX = 0.0;
float last_gyrY = 0.0;
float last_gyrZ = 0.0;

float accX;
float accY;
float accZ;
float gyrX;
float gyrY;
float gyrZ;

float angle;

bool accDataUpdated = false;
bool gyroDataUpdated = false;
//----------------------------------------------------------------------------------------------------------------------
// BLE
//----------------------------------------------------------------------------------------------------------------------

#define BLE_DEVICE_NAME "PostURight Sensor"
#define BLE_LOCAL_NAME "PostURight Sensor"

BLEService IMUService(BLE_UUID_IMU_SERVICE);
BLEFloatCharacteristic accXCharacteristic(BLE_UUID_ACC_X_CHAR, BLERead | BLENotify);
BLEFloatCharacteristic accYCharacteristic(BLE_UUID_ACC_Y_CHAR, BLERead | BLENotify);
BLEFloatCharacteristic accZCharacteristic(BLE_UUID_ACC_Z_CHAR, BLERead | BLENotify);
BLEFloatCharacteristic gyroXCharacteristic(BLE_UUID_GYRO_X_CHAR, BLERead | BLENotify);
BLEFloatCharacteristic gyroYCharacteristic(BLE_UUID_GYRO_Y_CHAR, BLERead | BLENotify);
BLEFloatCharacteristic gyroZCharacteristic(BLE_UUID_GYRO_Z_CHAR, BLERead | BLENotify);
BLEFloatCharacteristic angleCharacteristic(BLE_UUID_ANGLE_CHAR, BLERead | BLENotify);

//----------------------------------------------------------------------------------------------------------------------
// SETUP
//----------------------------------------------------------------------------------------------------------------------

void setup()
{
  // Serial.begin(9600);
  // while (!Serial);
  
  if (!IMU.begin()) {
    // Serial.println("Failed to initialize IMU!");
    while (1);
  }
  if (!setupBleMode()) {
    while (1);
  } else {
    // Serial.println("BLE initialized. Waiting for clients to connect.");
  }
  
  // write initial value
  accX = 0.00;
  accY = 0.00;
  accZ = 0.00;
  gyrX = 0.00;
  gyrY = 0.00;
  gyrZ = 0.00;
  angle = 0.00;
}

void loop() {
  
  bleTask();
  if (accSensorTask()) {
    // accPrintTask();
  }
  if (gyroSensorTask()){
    // gyroPrintTask();
  }
}

//----------------------------------------------------------------------------------------------------------------------
// SENSOR TASKS
/*
 * We define bool function for each sensor.
 * Function returns true if sensor data are updated.
 * Allows us to define different update intervals per sensor data.
 */
//----------------------------------------------------------------------------------------------------------------------

bool accSensorTask() {
  static long previousMillis2 = 0;
  unsigned long currentMillis2 = millis();
  static float x = 0.00, y = 0.00, z = 0.00;
  if (currentMillis2 - previousMillis2 < ACC_SENSOR_UPDATE_INTERVAL) {
    return false;
  }
  previousMillis2 = currentMillis2;
  if(IMU.accelerationAvailable()){

    IMU.readAcceleration(x, y, z);

    float ewma_accX = ALPHA * x + (1-ALPHA)*last_accX;
    float ewma_accY = ALPHA * y + (1-ALPHA)*last_accY;
    float ewma_accZ = ALPHA * z + (1-ALPHA)*last_accZ;
    last_accX = ewma_accX;
    last_accY = ewma_accY;
    last_accZ = ewma_accZ;

    accX = ewma_accX;
    accY = ewma_accY;
    accZ = ewma_accZ;
    angle = atan2((sqrt(pow(ewma_accX,2)+pow(ewma_accY,2))),ewma_accZ)*(180/PI); 
    accDataUpdated = true;
  }
  return accDataUpdated;
}

bool gyroSensorTask() {
  static long previousMillis2 = 0;
  unsigned long currentMillis2 = millis();
  static float x = 0.00, y = 0.00, z = 0.00;
  if (currentMillis2 - previousMillis2 < GYRO_SENSOR_UPDATE_INTERVAL) {
    return false;
  }
  previousMillis2 = currentMillis2;
  if(IMU.gyroscopeAvailable()){
    IMU.readGyroscope(x, y, z);
    float ewma_gyrX = ALPHA * x + (1-ALPHA)*last_gyrX;
    float ewma_gyrY = ALPHA * y + (1-ALPHA)*last_gyrY;
    float ewma_gyrZ = ALPHA * z + (1-ALPHA)*last_gyrZ;
    last_gyrX = ewma_gyrX;
    last_gyrY = ewma_gyrY;
    last_gyrZ = ewma_gyrZ;

    gyrX = ewma_gyrX;
    gyrY = ewma_gyrY;
    gyrZ = ewma_gyrZ;
    gyroDataUpdated = true;
  }
  return gyroDataUpdated;
}


//----------------------------------------------------------------------------------------------------------------------
//  BLE SETUP
/*
 * Determine which services/characteristics to be advertised.
 * Determine the device name.
 * Set event handlers.
 * Set inital value for characteristics.
 */
//----------------------------------------------------------------------------------------------------------------------

bool setupBleMode() {
  if (!BLE.begin()) {
    return false;
  }

  // set advertised local name and service UUID:
  BLE.setDeviceName(BLE_DEVICE_NAME);
  BLE.setLocalName(BLE_LOCAL_NAME);
  BLE.setAdvertisedService(IMUService);

  // BLE add characteristics
  IMUService.addCharacteristic(accXCharacteristic);
  IMUService.addCharacteristic(accYCharacteristic);
  IMUService.addCharacteristic(accZCharacteristic);
  IMUService.addCharacteristic(gyroXCharacteristic);
  IMUService.addCharacteristic(gyroYCharacteristic);
  IMUService.addCharacteristic(gyroZCharacteristic);
  IMUService.addCharacteristic(angleCharacteristic);

  // add service
  BLE.addService(IMUService);

  // set the initial value for the characteristic:
  accXCharacteristic.writeValue(accX);
  accYCharacteristic.writeValue(accY);
  accZCharacteristic.writeValue(accZ);
  gyroXCharacteristic.writeValue(gyrX);
  gyroYCharacteristic.writeValue(gyrY);
  gyroZCharacteristic.writeValue(gyrZ);
  angleCharacteristic.writeValue(angle);

  // set BLE event handlers
  // BLE.setEventHandler(BLEConnected, blePeripheralConnectHandler);
  // BLE.setEventHandler(BLEDisconnected, blePeripheralDisconnectHandler);

  // start advertising
  BLE.advertise();

  return true;
}

void bleTask()
{
  const uint32_t BLE_UPDATE_INTERVAL = 10;
  static uint32_t previousMillis = 0;
  uint32_t currentMillis = millis();
  if (currentMillis - previousMillis >= BLE_UPDATE_INTERVAL) {
    previousMillis = currentMillis;
    BLE.poll();
  }
  if (accDataUpdated) {
    accXCharacteristic.writeValue(accX);
    accYCharacteristic.writeValue(accY);
    accZCharacteristic.writeValue(accZ);
    angleCharacteristic.writeValue(angle);
    accDataUpdated = false;
  }

  if (gyroDataUpdated) {
    gyroXCharacteristic.writeValue(gyrX);
    gyroYCharacteristic.writeValue(gyrY);
    gyroZCharacteristic.writeValue(gyrZ);
    gyroDataUpdated = false;
  }

}

//----------------------------------------------------------------------------------------------------------------------
// PRINT TASKS
/*
 * Print tasks per sensor type.
 * Useful to test accuracy of sensor data before sending over BLE.
 */
//----------------------------------------------------------------------------------------------------------------------

// void accPrintTask() {
//   Serial.print("AccX = ");
//   Serial.print(accData.values[0]);

//   Serial.print("AccY = ");
//   Serial.print(accData.values[1]);

//   Serial.print("AccZ = ");
//   Serial.print(accData.values[2]);

//   Serial.print("Acc. Subscription Status: ");
//   Serial.println(accCharacteristic.subscribed());
// }

// void gyroPrintTask() {
//   Serial.print("gyroX = ");
//   Serial.print(gyroData.values[0]);

//   Serial.print("gyroY = ");
//   Serial.print(gyroData.values[1]);

//   Serial.print("gyroZ = ");
//   Serial.print(gyroData.values[2]);

//   Serial.print("Gyro. Subscription Status: ");
//   Serial.println(gyroCharacteristic.subscribed());
// }

//----------------------------------------------------------------------------------------------------------------------
// Event Handlers
/*
 * These are handlers that inform connection status
 * Useful when testing, might be removed later on.
 */
//----------------------------------------------------------------------------------------------------------------------

// void blePeripheralConnectHandler(BLEDevice central) {
  // digitalWrite(BLE_LED_PIN, HIGH);
  // Serial.print(F( "Connected to central: " ));
  // Serial.println(central.address());
// }

// void blePeripheralDisconnectHandler(BLEDevice central) {
  // digitalWrite(BLE_LED_PIN, LOW);
  // Serial.print(F("Disconnected from central: "));
  // Serial.println(central.address());
// }