using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using SocketIO;

public class Unity_interface : MonoBehaviour {

	//192.168.1.139
	//ws://192.168.1.139:8080/socket.io/?EIO=4&transport=websocket
	//ws://127.0.0.1:8080/socket.io/?EIO=4&transport=websocket
	//public GameObject input;
	//public GameObject sendBtn;
	public GameObject arduino;
	string temp;
	public int numOfEnergy;

	private SocketIOComponent socket;

	private int currNum;
	private int prevNum;

	public bool readyToShot;

	// Use this for initialization
	void awake () {
		numOfEnergy = 0;
		readyToShot = false;
	}

	void Start(){
		GameObject go = GameObject.Find ("SocketIO");
		socket = go.GetComponent<SocketIOComponent>();
		socket.On ("open", TestOpen);
		//socket.On("unity",ServerData);
		socket.On("brandon",ServerData);
		socket.On("error", TestError);
		socket.On ("close", TestClose);
		prevNum = 500;
	}

	// Update is called once per frame
	void Update () {
		//socket.On("brandon",ServerData);
	}
	/*
	public void SendButtonClick(){
		
		try
		{
			temp = input.GetComponent<InputField> ().text;
			numOfEnergy = int.Parse (temp);
			numOfEnergy = Mathf.FloorToInt(numOfEnergy/10.41f);
			Debug.Log ("Number of Energy = " + numOfEnergy);
			arduino.GetComponent<arduino_interface> ().UpdateNumberOfEnergy (temp);
		}
		catch(System.Exception e){
			Debug.LogException (e, this);
		}
	}
	*/
	public void ServerData(SocketIOEvent e)
	{   
		string ss= e.data.GetField("value").ToString();
		Debug.Log("### [SocketIO] received: ==== " + ss);
		currNum = System.Int32.Parse (ss);
		if (currNum >= 4000) {
			readyToShot = true;
		}
		if (currNum >= 0) {
			Debug.Log ("Happening!!!-----------------------------");
			arduino.GetComponent<arduino_interface> ().SendArduino (ss);
		}
	}
	public void TestOpen(SocketIOEvent e){
		Debug.Log ("[SocketIO] open received " + " : " + e.data);
	}
	public void TestClose(SocketIOEvent e)
	{	
		//Debug.Log("[SocketIO] Close received: " + e.name + " " + e.data);
	}

	public void TestError(SocketIOEvent e)
	{
		//Debug.Log ("[SocketIO] Error received: " + e.name + " " + e.data);
	}

	void OnApplicationQuit(){
		//Debug.Log ("Quit! + close the socket");
		socket.Close();
	}

}


