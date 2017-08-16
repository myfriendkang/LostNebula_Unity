using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DistanceControl : MonoBehaviour {

	public GameObject distanceText;
	public GameObject distanceLeft;

	public bool isTimerDone =false;
	public static bool alertAlien;
	public float temp;
	public GameObject alertSign;
	bool flag;
	void Start () {
		alertAlien = false;
		TimerStart ();
		alertSign.SetActive (false);
		flag = false;
	}

	void Update () {
		if (!isTimerDone) {
			TimerStart ();
		}
	}

	void TimerStart(){
		
		temp = ObjControl.distance;
		if (flag == false) {
			if (temp < 33200.0f) {
				if (!MultiShooter.isAlienDestroyed) {
					alertSign.SetActive (true);
					flag = true;
				}
			}
		}
		distanceLeft.GetComponent<TextMesh> ().text = temp.ToString ("F1");
		if (temp <5000.0f) {
			isTimerDone = true;
		}
	}
}
