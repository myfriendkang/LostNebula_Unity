using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class alertAutoResize : MonoBehaviour {


	public Transform target;
	private Transform origin;
	public Transform camera;
	float distance;
	float fixedDistance;
	Vector3 originSize;

	// Use this for initialization
	void Start () {
		
		origin = gameObject.transform;	
		originSize = new Vector3 (origin.transform.localScale.x, origin.transform.localScale.y, origin.transform.localScale.z);
		fixedDistance = Vector3.Distance (origin.position, target.position);
	
	}

	// Update is called once per frame
	void Update () {

		distance = Vector3.Distance (this.gameObject.transform.position, target.position);
		this.gameObject.transform.localScale = new Vector3 (0.06f * distance / fixedDistance, 0.06f * distance / fixedDistance, 0.06f  * distance / fixedDistance);
		if (MultiShooter.isAlienDestroyed == true) {
			//if (this.gameObject.activeSelf == true) {
				this.gameObject.SetActive (false);
			//}
		}
		FacingUp ();
	}

	void FacingUp(){
		var n = camera.transform.position - transform.position;
		var newRotation = Quaternion.LookRotation(n) * Quaternion.Euler(0, 180, 0);
		transform.rotation = Quaternion.Slerp(transform.rotation, newRotation, Time.deltaTime * 1.0f);
	}
}
