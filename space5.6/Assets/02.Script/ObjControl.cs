using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ObjControl : MonoBehaviour {

	public GameObject camera;
	public GameObject cameraMove_before;
	public GameObject targetPlanet;
	public static float distance;
	public GameObject finalDist;

	float speed = 300.0f;
	float speedfor = 200.5f;

	public GameObject soundMgr;
	public AudioSource thisAudio;



	void Awake(){
		cameraMove_before.SetActive (true);
		distance = Vector3.Distance (camera.GetComponent<Transform> ().position, targetPlanet.GetComponent<Transform> ().position);
	}

	void Start () {
	//	soundMgr.GetComponent<SoundManager> ().RandomizeSfx (thisAudio);
	}

	void Update () {
	
		if (Input.GetKeyDown (KeyCode.R)) {
			SceneManager.LoadScene("Scene");
		}
		if (Input.GetKeyDown (KeyCode.H) || distance <=8000.0f) {
			cameraMove_before.GetComponent<CPC_CameraPath> ().PausePath ();
			float step = speedfor * Time.deltaTime;
			camera.transform.position = Vector3.Lerp (camera.transform.position, finalDist.transform.position, Time.deltaTime/5.0f);
			//camera.transform.position = Vector3.MoveTowards (camera.transform.position, finalDist.transform.position, step);
		}
		if (Input.GetKeyDown (KeyCode.G)) {
			cameraMove_before.GetComponent<CPC_CameraPath> ().ResumePath ();
		}
		if (MultiShooter.isAlienDestroyed) {
			if (speed >= 10) {
				speed = speed - 1.5f;
			}
			cameraMove_before.GetComponent<CPC_CameraPath> ().UpdateTimeInSeconds (speed);
		} else {
			cameraMove_before.GetComponent<CPC_CameraPath> ().UpdateTimeInSeconds (300.0f);
		}

		if (Input.GetKeyDown (KeyCode.Escape)) {
			Application.Quit ();
		}

		CalculateDistance ();
	}

	public void CalculateDistance(){
		distance = Vector3.Distance (camera.GetComponent<Transform> ().position, targetPlanet.GetComponent<Transform> ().position);
	//	Debug.Log ("Distance = " + distance);
	}


}
