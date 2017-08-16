using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.IO.Ports;


public class arduino_interface : MonoBehaviour {

	private const string SERIAL_PORT = "/dev/cu.usbmodem1421";
	private const int SERIAL_BAUD_RATE = 9600;
	private const int SERIAL_TIMEOUT = 50;
	private static SerialPort _serialPort;

	//--------------------------------//
	private const int maxLed = 192;
	string numOfLed = "N";
	int prevNum;
	int currNum;

	//Test Git
	int _prevNum;
	int _currNum;
	// Use this for initialization
	void Start () {
		Debug.Log ("connecting Arduino");
		_serialPort = new SerialPort (SERIAL_PORT, SERIAL_BAUD_RATE);
		_serialPort.ReadTimeout = SERIAL_TIMEOUT;
		_serialPort.Open ();
		prevNum = 500;
		_prevNum = 500;
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	public void SendArduino(string num){
		//Debug.Log ("*********************************** = " + numOfLed);
		//if (numOfLed != "N") {

		int number = int.Parse (num);
			//_currNum = number;
		//	if (_prevNum != _currNum) {
		Debug.Log ("I send that " + number.ToString());
		_serialPort.WriteLine (number.ToString ());
		_serialPort.BaseStream.Flush ();
		//		_prevNum = _currNum;
		//	}
		//}
	}
		
	void OnApplicationQuit(){
		_serialPort.Close ();
	}
}
