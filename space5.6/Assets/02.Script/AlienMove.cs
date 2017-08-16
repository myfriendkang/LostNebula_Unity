using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AlienMove : MonoBehaviour {
	private Vector3 _startPosition;
	public float temp = 10.0f;
	public static bool isDestroyed;
	// Use this for initialization
	void Start () {
		_startPosition = transform.position;
		isDestroyed = false;
	}
	
	// Update is called once per frame
	void Update () {
		transform.position = _startPosition + new Vector3(0.0f, Mathf.Sin(Time.time) * temp, 0.0f);


	}
}
