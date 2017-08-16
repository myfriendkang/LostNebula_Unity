/*
        *  Control 7 Led Segments and Led Strip
        *  assigned pin 
        *  pin #4 = Led strip
        *  pint #5,6,7 = 7 Led segment 
        */
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
#include <avr/power.h>
#endif

// For Led Strip Pin
#define PIN 4

// Parameter 1 = number of pixels in strip
// Parameter 2 = Arduino pin number (most are valid)
// Parameter 3 = pixel type flags, add together as needed:
//   NEO_KHZ800  800 KHz bitstream (most NeoPixel products w/WS2812 LEDs)
//   NEO_KHZ400  400 KHz (classic 'v1' (not v2) FLORA pixels, WS2811 drivers)
//   NEO_GRB     Pixels are wired for GRB bitstream (most NeoPixel products)
//   NEO_RGB     Pixels are wired for RGB bitstream (v1 FLORA pixels, not v2)
//   NEO_RGBW    Pixels are wired for RGBW bitstream (NeoPixel RGBW products)
Adafruit_NeoPixel strip = Adafruit_NeoPixel(192, PIN, NEO_GRB + NEO_KHZ800);

// IMPORTANT: To reduce NeoPixel burnout risk, add 1000 uF capacitor across
// pixel power leads, add 300 - 500 Ohm resistor on first pixel's data input
// and minimize distance between Arduino and first pixel.  Avoid connecting
// on a live circuit...if you must, connect GND first.

// 7 Led segment pins
byte segmentLatch = 5; //Brown
byte segmentClock = 6; //Red
byte segmentData = 7;  //Orange
                       //Yellow - 5v
                       //Green - 12v
#define MAXLEDS 192
#include <math.h>
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
String s = "";
int numOfSegmentsLed;
int numOfLedStrip;
float numberFromUnity;
const int defaultEnergy = 500; // 500/4000
const int defaultLedStrip = 23;
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
int prevNum;
int currNum;
int seg_pre;
int seg_curr;
int flag;

int prevRealNum;
int currRealNum;
void setup()
{
// This is for Trinket 5V 16MHz, you can remove these three lines if you are not using a Trinket
#if defined(__AVR_ATtiny85__)
    if (F_CPU == 16000000)
        clock_prescale_set(clock_div_1);
#endif
    // End of trinket special code
    Serial.begin(9600);
    while (!Serial)
        ;

    pinMode(segmentClock, OUTPUT);
    pinMode(segmentData, OUTPUT);
    pinMode(segmentLatch, OUTPUT);

    digitalWrite(segmentClock, LOW);
    digitalWrite(segmentData, LOW);
    digitalWrite(segmentLatch, LOW);

    strip.begin();
    strip.show(); // Initialize all pixels to 'off'

    //Initial default number
    colorWipeFromUnity(strip.Color(255, 0, 0), 5, int(floor(defaultEnergy / 20.942408377f)));
    showNumber((float)defaultEnergy);
    prevNum = defaultLedStrip;
    seg_pre = 500;
    prevRealNum = 500;
    flag = false;
}

void loop()
{
    if (Serial.available() > 0)
    {
        s = Serial.readString();
        numOfSegmentsLed = s.toInt();
        numOfLedStrip = abs(map(numOfSegmentsLed, 0, 4000, 0, 192));
        seg_curr = numOfSegmentsLed;
        updateLED(numOfLedStrip, numOfSegmentsLed);
    }

    delay(500);
}

void TurnOffAll()
{
    for (uint16_t i = 0; i < strip.numPixels(); i++)
    {
        strip.setPixelColor(i, 0); //turn every third pixel off
    }
    strip.show();
}

void updateLED(int num, int num2)
{
    currNum = num - 1;
    currRealNum = num2;
    if ((prevRealNum < 4001 && currRealNum < 4001) || (prevRealNum < 4001 && currRealNum > 4001) || (prevRealNum > 4001 && currRealNum < 4001))
    {
        Serial.print("prev number = ");
        Serial.println(prevRealNum);

        Serial.print("curr number = ");
        Serial.println(currRealNum);

        int gap = abs(prevNum - currNum);
        Serial.print("gap = ");
        Serial.println(gap);

        Serial.println("============================");
        if (prevRealNum > currRealNum)
        {
            subtractLED(strip.Color(0, 255, 0), 10, gap);
        }
        else
        {
            Serial.println("hey ADD");
            addUpLED(strip.Color(0, 255, 0), 10, gap);
        }
        prevNum = currNum;
    }
    else if (num2 > 4000 )
    {
        for (int i = prevRealNum; i <= currRealNum; i++)
        {
            showNumber((float)(i));
            delay(1);
        }
        // prevRealNum = currRealNum;
    }

     if (prevRealNum > 4000 && currRealNum >= 4000 && currRealNum < prevRealNum)
    {
        for (int i = prevRealNum; i >= currRealNum; i--)
        {
            showNumber((float)(i));
            delay(1);
        }
    }
    prevRealNum = currRealNum;
}

void colorWipeFromUnity(uint32_t c, uint8_t wait, int num)
{
    for (uint16_t i = 0; i <= num; i++)
    {
        strip.setPixelColor(i, c);
        strip.show();
        delay(wait);
    }
}

void addUpLED(uint32_t c, uint8_t wait, int num)
{
    //first later
    if (currNum < 48)
    {
        int temp;
        int lastNum;
        for (int i = 0; i < currNum + 1; i++)
        {
            temp = ceil(map(i, 0, 188, 0, 4000));
            strip.setPixelColor(i, strip.Color(255, i / 3.5f, 0));
            strip.show();
            lastNum = i;
            showNumber((float)(temp));
            delay(wait);
        }
        if ((int)numOfSegmentsLed != temp)
        {
            if (temp >= 0 && temp <= 4000)
            {
                for (int i = temp; i <= numOfSegmentsLed; i++)
                {
                    showNumber((float)(i));
                    delay(wait);
                }
            }
        }
    }
    //second layer
    else if (currNum >= 48 && currNum < 96)
    {
        int temp;
        int lastNum;
        for (int i = 0; i < prevNum; i++)
        {
            if (i < 48)
            {
                strip.setPixelColor(i, strip.Color(255, i / 3.5f, 0));
            }
        }
        for (int i = prevNum; i < currNum + 1; i++)
        {
            temp = ceil(map(i, 0, 190, 0, 4000));
            strip.setPixelColor(i, strip.Color(255, i / 2, 0));
            showNumber((float)(temp));
            lastNum = i;
            strip.show();
            delay(wait);
        }
        if ((int)numOfSegmentsLed != temp)
        {
            if (temp >= 0 && temp <= 4000)
            {
                for (int i = temp; i <= numOfSegmentsLed; i++)
                {
                    showNumber((float)(i));
                    delay(wait);
                }
            }
        }
    }
    //thrid layer
    else if (currNum >= 96 && currNum < 145)
    {
        int temp;
        int lastNum;
        for (int i = prevNum; i < currNum + 1; i++)
        {
            if (i < 48)
            {
                temp = ceil(map(i, 0, 188, 0, 4000));
                strip.setPixelColor(i, strip.Color(255, i / 3.5f, 0));
                showNumber((float)(temp));
                lastNum = i;
                strip.show();
                delay(wait);
            }
            else if (i >= 48 && i < 96)
            {
                temp = ceil(map(i, 0, 190, 0, 4000));
                strip.setPixelColor(i, strip.Color(255, i / 2, 0));
                showNumber((float)(temp));
                strip.show();
                lastNum = i;
                delay(wait);
            }
            else
            {
                temp = ceil(map(i, 0, 191, 0, 4000));
                strip.setPixelColor(i, strip.Color(255 - i, i / 2, 0));
                showNumber((float)(i * 20.98));
                strip.show();
                lastNum = i;
                delay(wait);
            }
        }
        if ((int)numOfSegmentsLed != temp)
        {
            if (temp >= 0 && temp <= 4000)
            {
                for (int i = temp; i <= numOfSegmentsLed; i++)
                {
                    showNumber((float)(i));
                    delay(wait);
                }
            }
        }
    }
    //fourth layer
    //else if (currNum >= 145 && currNum < 193)
    else if (currNum >= 145)
    {
        int temp;
        int lastNum;
        for (int i = prevNum; i < currNum + 1; i++)
        {
            if (i < 48)
            {
                temp = ceil(map(i, 0, 188, 0, 4000));
                strip.setPixelColor(i, strip.Color(255, i / 3.5f, 0));
                showNumber((float)(temp));
                lastNum = i;
                strip.show();
                delay(wait);
            }
            else if (i >= 48 && i < 96)
            {
                temp = ceil(map(i, 0, 190, 0, 4000));
                strip.setPixelColor(i, strip.Color(255, i / 2, 0));
                showNumber((float)(temp));
                lastNum = i;
                strip.show();
                delay(wait);
            }
            else if (i >= 96 && i < 144)
            {
                temp = ceil(map(i, 0, 188, 0, 4000));
                strip.setPixelColor(i, strip.Color(255 - i, i / 2, 0));
                showNumber((float)(i * 20.98));
                lastNum = i;
                strip.show();
                delay(wait);
            }
            else
            {
                temp = ceil(map(i, 0, 191, 0, 4000));
                //strip.setPixelColor(i, strip.Color(255 - i, i, 0));
                strip.setPixelColor(i, strip.Color(255 - (i * 1.3f), i + 20, 0));
                showNumber((float)(temp));
                lastNum = i;
                strip.show();
                delay(wait);
            }
        }
        if ((int)numOfSegmentsLed != temp)
        {
            if (temp >= 0)
            {
                for (int i = temp; i <= numOfSegmentsLed; i++)
                {
                    showNumber((float)(i));
                    delay(wait);
                }
            }
        }
    }
}

void subtractLED(uint32_t c, uint8_t wait, int num)
{
    if (MAXLEDS - currNum > 0)
    {
        //0-4000 -> 0-192
        int lastNum;
        float temp;

        //prevNum = 500
        //currn = 250;
        for (int i = prevNum; i > currNum; i--)
        {
            temp = ceil(map(i, 0, 192, 0, 4000));
            strip.setPixelColor(i, 0);
            showNumber((float)(temp));
            lastNum = i;
            strip.show();
            delay(1);
        }

        if ((float)numOfSegmentsLed != temp)
        {
            // if (temp >= 0 && temp <= 4000)
            if (temp >= 0 && temp <= 4000)
            {
                if (abs(numOfSegmentsLed - temp) >= 1000 && numOfSegmentsLed >= 1000)
                {
                    for (int i = 1000; i <= numOfSegmentsLed; i++)
                    {
                        showNumber((float)(i));
                        delay(1);
                    }
                }
                else
                {
                    for (int i = temp; i <= numOfSegmentsLed; i++)
                    {
                        showNumber((float)(i));
                        delay(1);
                    }
                }
            }
        }
    }
}

//Takes a number and displays 2 numbers. Displays absolute value (no negatives)
void showNumber(float value)
{
    int number = abs(value); //Remove negative signs and any decimals

    for (byte x = 0; x < 4; x++)
    {
        int remainder = number % 10;
        postNumber(remainder, false);
        number /= 10;
    }
    //Latch the current segment data
    digitalWrite(segmentLatch, LOW);
    digitalWrite(segmentLatch, HIGH); //Register moves storage register on the rising edge of RCK

    seg_pre = seg_curr;
}

//Given a number, or '-', shifts it out to the display
void postNumber(byte number, boolean decimal)
{
//    -  A
//   / / F/B
//    -  G
//   / / E/C
//    -. D/DP

#define a 1 << 0
#define b 1 << 6
#define c 1 << 5
#define d 1 << 4
#define e 1 << 3
#define f 1 << 1
#define g 1 << 2
#define dp 1 << 7

    byte segments;

    switch (number)
    {
    case 1:
        segments = b | c;
        break;
    case 2:
        segments = a | b | d | e | g;
        break;
    case 3:
        segments = a | b | c | d | g;
        break;
    case 4:
        segments = f | g | b | c;
        break;
    case 5:
        segments = a | f | g | c | d;
        break;
    case 6:
        segments = a | f | g | e | c | d;
        break;
    case 7:
        segments = a | b | c;
        break;
    case 8:
        segments = a | b | c | d | e | f | g;
        break;
    case 9:
        segments = a | b | c | d | f | g;
        break;
    case 0:
        segments = a | b | c | d | e | f;
        break;
    case ' ':
        segments = 0;
        break;
    case 'c':
        segments = g | e | d;
        break;
    case '-':
        segments = g;
        break;
    }

    if (decimal)
        segments |= dp;

    //Clock these bits out to the drivers
    for (byte x = 0; x < 8; x++)
    {
        digitalWrite(segmentClock, LOW);
        digitalWrite(segmentData, segments & 1 << (7 - x));
        digitalWrite(segmentClock, HIGH); //Data transfers to the register on the rising edge of SRCK
    }
}
