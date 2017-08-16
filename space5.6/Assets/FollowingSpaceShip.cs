using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowingSpaceShip : MonoBehaviour {
	public GameObject camera;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		this.gameObject.transform.position = camera.transform.position;
	}
}
